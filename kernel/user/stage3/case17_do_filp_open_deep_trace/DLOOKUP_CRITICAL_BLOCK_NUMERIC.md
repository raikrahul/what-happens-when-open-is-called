# `__d_lookup` Critical Block: Numeric Worksheet (One Block Only)

Code block under study:

```c
spin_lock(&dentry->d_lock);
if (dentry->d_parent != parent)
    goto next;
if (d_unhashed(dentry))
    goto next;

if (!d_same_name(dentry, parent, name))
    goto next;

dentry->d_lockref.count++;
found = dentry;
spin_unlock(&dentry->d_lock);
break;
```

Middle-first concrete run (from your logs):

1. `parent = 0xffff8dda3ba6f0c0`.
2. `target child name = "missing_case17_filp_75221.txt"`.
3. `target hash = 0xf168d14a`.
4. replay hit: `dentry = 0xffff8ddc063cb3c0`, `inode = 0x0`, `negative=1`, `unhashed=0`.

---

## Numeric walk: one pass of the loop body

1. lock op: `spin_lock(&dentry->d_lock)` on `dentry=0xffff8ddc063cb3c0`.
2. parent compare: `dentry->d_parent == 0xffff8dda3ba6f0c0` -> `true` -> no `goto next`.
3. hash-link check: `d_unhashed(dentry) == 0` -> `false` branch not taken -> no `goto next`.
4. name compare: `d_same_name(...) == 1` -> `!1 == 0` -> no `goto next`.
5. refcount step: `dentry->d_lockref.count = k` -> `k+1`.
6. assign: `found = 0xffff8ddc063cb3c0`.
7. unlock: `spin_unlock(&dentry->d_lock)`.
8. `break` exits bucket loop immediately.
9. function return later: `return found` -> non-NULL hit pointer.

---

## Failure branches in same block (numbers only)

1. branch A: `d_parent mismatch` -> `goto next` -> unlock -> continue bucket scan.
2. branch B: `d_unhashed(dentry)=1` -> `goto next` -> unlock -> continue.
3. branch C: `d_same_name=0` -> `goto next` -> unlock -> continue.
4. all branches A/B/C keep `found=NULL` unless later candidate passes all checks.

---

## Small / mid / large bucket arithmetic

1. small: bucket size `k=1` -> comparisons max `1` -> hit at index `0` -> cost ~`1` candidate.
2. mid: bucket size `k=7` -> indices `{0,1,2,3,4,5,6}` -> hit at index `3` -> `4` candidates tested.
3. large: bucket size `k=1000000` -> worst case miss checks `1000000` candidates.
4. strict worst-case complexity: `O(k)` where `k = bucket chain length`.
5. average expected with good hash spread: small `k` => near-constant behavior.

---

## Fractional and edge arithmetic

1. load factor style toy: `N=1000 dentries`, `B=256 buckets` -> avg `N/B=3 remainder 232`.
2. bucket occupancy example: `232` buckets with `4`, `24` buckets with `3`.
3. edge 1: `N=0` -> all buckets empty -> immediate miss.
4. edge 2: all names collide into one bucket -> `k=N` -> worst-case linear scan.

---

## Concrete memory-state sketch (`found` path)

Stack frame (`__d_lookup`):

```text
[stack @ SP+0x00] parent = 0xffff8dda3ba6f0c0
[stack @ SP+0x08] name.ptr -> "missing_case17_filp_75221.txt"
[stack @ SP+0x10] hash = 0xf168d14a
[stack @ SP+0x18] found = 0x0000000000000000 (init)
[stack @ SP+0x20] dentry = 0xffff8ddc063cb3c0 (candidate)
```

Transition:

1. before checks: `found = 0x0`.
2. after all three checks pass: `found = 0xffff8ddc063cb3c0`.
3. return value: `0xffff8ddc063cb3c0`.

Observed replay output aligns:

```text
[DLOOKUP_REPLAY] d_lookup HIT dentry=ffff8ddc063cb3c0 inode=0000000000000000 negative=1 unhashed=0
```

---

## W-table (numbers-first)

1. What: `3` gate checks + `1` refcount increment + `1` pointer assignment.
2. Why: avoid false hit (`parent`, `hashed`, `full-name`) before returning pointer.
3. Where: `fs/dcache.c::__d_lookup` bucket scan loop.
4. Who: caller `d_lookup(parent,qstr)` -> `__d_lookup`.
5. When: after bucket select by `d_hash(hash)`.
6. Without: skipping any check can produce wrong hit probability `>0` under collisions/moves.
7. Which: winning candidate in this run = `0xffff8ddc063cb3c0`.

---

## Failure predictions for this block

1. F1: stale parent pointer -> parent check fails for all candidates -> miss.
2. F2: stale unhashed dentry -> `d_unhashed=1` -> skip.
3. F3: hash collision but different name -> `d_same_name=0` -> skip.
4. F4: lock/refcount bug -> use-after-free risk if count not incremented before return.
