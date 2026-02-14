# 7-Day Prewritten X Posts (Copy/Paste)

Use these exactly. Replace only links if you move files.

## Shared Links
- Product page: `https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/docs/product/index.md`
- Free worksheet (case17): `https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace/worksheet_lingering_dentry_proof.md`
- Driver (case17): `https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace/driver.c`
- Pointer-check driver: `https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace/pointer_check_driver.c`
- Release: `https://github.com/raikrahul/what-happens-when-open-is-called/releases/tag/pack-v0.1.0`

---

## Day 1
### Post A (Myth-breaker)
Wrong: `ENOENT` means no dentry object existed.

Trace says otherwise.
`__d_alloc RET dentry=... inode=0x0`
then
`do_filp_open RET ... err=2`

Failure + allocated dentry can both be true.

Fill worksheet yourself:
<free worksheet link>

### Post B (Proof snippet)
3-line proof:
1) `d_alloc_parallel ENTRY ... child_name=missing_case17_raw_syscall.txt`
2) `__d_alloc RET ... inode=0x0`
3) `do_filp_open RET ... err=2`

That is the missing-file negative-dentry chain.
Driver: <driver link>

---

## Day 2
### Post A
Wrong: dentry always implies inode.

Counterexample:
`dentry=0xffff...`
`d_inode=0x0`

Negative dentry is a real dentry object with no inode.

Worksheet:
<free worksheet link>

### Post B
Same filename, same hash, but `err=2` on open:
`name=missing_case17_raw_syscall.txt`
`hash=0x4101d47`
`do_filp_open err=2`

Missing file path is still traceable object-by-object.

---

## Day 3
### Post A
Wrong: libc loader noise makes open tracing useless.

Use raw syscall trigger.
No libc wrapper needed.
Signal becomes clean:
`do_filp_open -> d_alloc_parallel -> __d_alloc -> ENOENT`

Trigger + driver in repo:
<release link>

### Post B
Raw trigger run result:
`openat_raw`
`__d_alloc RET ...`
`do_filp_open RET err=2`

Minimal path, maximal signal.

---

## Day 4
### Post A
Wrong: from `sb` pointer you can recover unique parent dentry via `container_of`.

No.
Many dentries share one `sb`.
Reverse mapping is non-unique.

Use `d_alloc_parallel` probe for parent.
Use `__d_alloc` probe for new dentry.

### Post B
Pointer classes matter:
- member-slot pointer
- pointed-object pointer
- shared-object pointer

Mix these and proofs break.
I documented the exact mistake pattern in case17 artifacts.

---

## Day 5
### Post A
Wrong: `d_lookup` miss means no dentry allocation follows.

Observed chain:
`d_lookup RET NULL`
`d_alloc_parallel ENTRY`
`__d_alloc ENTRY/RET`

Miss -> allocation is expected.

### Post B
One trace line people ignore:
`parent_sb ... sb_magic=0xef53`

You can prove filesystem context and still show missing-file failure in same run.

---

## Day 6
### Post A
Wrong: once userspace exits, this dentry evidence is gone.

Hardcoded pointer-check run after process exit:
`d_name.len=30`
`d_name.hash=0x4101d47`
`text=missing_case17_raw_syscall.txt`

Pointer-check driver:
<pointer-check link>

### Post B
If pointer reads with no-fault API return `rc=0` and name bytes match, you have post-exit evidence.

This is why I keep a separate pointer-check module.

---

## Day 7
### Post A (Weekly recap)
This week’s 5 wrong beliefs corrected:
1) ENOENT => no dentry
2) dentry => inode always
3) libc noise => unusable trace
4) sb pointer => recover parent
5) process exit => no evidence

All disproved with logs + worksheet.

### Post B (CTA)
If you want the harder version:
- multi-run confidence matrix
- pointer reuse ambiguity drills
- failure invalidation checklist

Public release:
<release link>

---

## Reply Templates (use daily)
1. `If you disagree, point to one exact log line. I’ll respond line-by-line.`
2. `Show your kernel version + 3 lines of dmesg. We can verify the claim quickly.`
3. `Good catch. Now test same path with raw syscall trigger and compare.`
4. `This is exactly why the worksheet has a separate invalidation block.`
5. `I can post the full command sequence if you want a clean reproduction.`

## Posting Rule
For every post:
1. one wrong claim
2. one numeric/log anchor
3. one artifact link
4. one CTA
