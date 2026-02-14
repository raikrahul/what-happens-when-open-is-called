# Negative Dentry Proof Method (Missing File Case)

## Objective
Prove, with source-aligned runtime evidence, that:
1. `do_filp_open()` returns error for a missing filename (`-ENOENT`), and
2. a dentry for that missing name is still created/cached as a **negative dentry** (`d_inode == NULL`), and
3. this cached entry can be observed again (lingering in global dcache) for the same `(parent,name)` key.

---

## Why This Works

The kernel open path is split into two logically different outcomes:
1. **Name cache outcome**: did we create/find a dentry object for the name?
2. **File existence/open outcome**: does that dentry have an inode and can we return a valid `struct file *`?

A missing file can still produce a valid dentry object (negative dentry), then fail open with `-ENOENT`.

This is expected behavior and useful for caching repeated misses.

---

## Ground Truth in Local Source (this machine)

Kernel source root used: `/usr/src/linux-hwe-6.17-6.17.0`

1. `lookup_open()` performs dcache lookup then allocation on miss:
- `fs/namei.c:3635` -> `dentry = d_lookup(dir, &nd->last);`
- `fs/namei.c:3638` -> `dentry = d_alloc_parallel(dir, &nd->last, &wq);` when miss

2. For this machine/path, ext4 non-atomic lookup path is used:
- `fs/namei.c:3686` gate `if (dir_inode->i_op->atomic_open)`
- ext4 ops table has `.lookup = ext4_lookup`, no `.atomic_open` in this tree:
  - `fs/ext4/namei.c:4214-4233`

3. ext4 lookup returns dentry result via splice:
- `fs/ext4/namei.c:1814` -> `return d_splice_alias(inode, dentry);`
- in missing case, `inode == NULL` => negative dentry result

4. Missing inode becomes ENOENT downstream:
- `step_into()` returns `-ENOENT` when inode is absent in RCU branch:
  - `fs/namei.c:1988`

5. Failed open cleanup still occurs:
- `path_openat()` cleanup -> `fput_close(file)` at `fs/namei.c:4063`

---

## Proof Strategy

Use **four synchronized observations** for the same target PID/path:

1. `do_filp_open` return (kretprobe)
- prove final return is `ERR_PTR(-ENOENT)` (`-2`)

2. `d_alloc_parallel` return (kretprobe)
- prove allocation path executed on miss (valid dentry pointer returned)

3. `lookup_open` return (kretprobe)
- prove returned dentry exists and is negative (`d_inode == NULL`)

4. direct dcache query using kernel API `d_lookup(parent, qstr)`
- prove same `(parent,name)` key now hits negative dentry in cache

---

## Detailed Procedure

### Step A: Controlled miss input
Use one fixed missing absolute path (your case):
`/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case17_do_filp_open_deep_trace/missing_case17_filp.txt`

Expected userspace result: `fd=-1, errno=2`.

### Step B: Instrumentation points

1. kretprobe `do_filp_open`
- log PID, pathname, return pointer, `PTR_ERR` if error

2. kretprobe `d_alloc_parallel`
- log PID, returned dentry pointer, name key if available from context

3. kretprobe `lookup_open`
- log returned dentry pointer and `d_inode` pointer
- derive negative state: `d_inode == NULL`

4. in-kernel query helper
- build `qstr` for same basename + parent dentry
- call `d_lookup(parent, &qstr)`
- log hit/miss and `d_is_negative(hit)`
- `dput(hit)` after use

### Step C: Two-run validation

Run 1:
- trigger missing open
- collect logs

Run 2 (same path immediately):
- trigger same missing open again
- collect logs

---

## Expected Evidence Pattern

### First run (cold miss)
1. `do_filp_open` returns `-ENOENT`
2. `d_alloc_parallel` observed (allocation path)
3. `lookup_open` returns dentry with `d_inode == NULL`
4. `d_lookup(parent,name)` hits and is negative (or immediately after lookup path)

### Second run (reuse)
1. still `do_filp_open -> -ENOENT`
2. stronger chance of direct dcache hit for same key
3. `d_lookup(parent,name)` hit with negative dentry confirms lingering cache entry

---

## Why This is a Valid Proof

Because it closes all logical gaps:
1. open failed (`-ENOENT`) is proven by syscall/open return path,
2. dentry creation path is proven by `d_alloc_parallel` observation,
3. dentry state is proven negative (`d_inode == NULL`) at lookup return,
4. cache persistence is proven by subsequent `d_lookup` hit on the same key.

If all four are observed for the same PID/path key, the claim is established.

---

## Common Misinterpretations (and fixes)

1. "Open failed, so no dentry existed"
- false; negative dentry can exist without inode.

2. "`IS_ERR` after `d_alloc_parallel` means missing file"
- false; `IS_ERR` there is hard allocator/internal error path, not normal ENOENT.

3. "Need `atomic_open` to prove this"
- false for this machine/path; ext4 here uses non-atomic `.lookup` path.

4. "`__fput` proves dentry birth"
- weak signal; cleanup path is asynchronous and noisy. Use lookup/dcache probes for proof.

---

## Pass/Fail Criteria

Pass if all true for same target path:
1. `do_filp_open` -> `-ENOENT`
2. `d_alloc_parallel` seen on miss path
3. `lookup_open` dentry has `d_inode == NULL`
4. repeated `d_lookup(parent,name)` finds negative dentry

Fail if any missing or inconsistent correlation.

---

## Minimal Verdict Template

- `OPEN_RET_ENOENT`: 0/1
- `DALLOC_SEEN`: 0/1
- `NEG_DENTRY_SEEN`: 0/1
- `DCACHE_REHIT_NEGATIVE`: 0/1

Proof established iff all 4 are `1`.
