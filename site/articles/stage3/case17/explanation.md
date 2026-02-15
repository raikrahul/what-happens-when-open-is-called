---
layout: default
title: "Stage 3 CASE17: Explanation"
---
[CASE]
- id: case17
- title: Deep filp_open
- userspace root: [kernel/user/stage3/case17_do_filp_open_deep_trace](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace)
- driver root: [kernel/drivers/stage3/case17_do_filp_open_deep_trace](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case17_do_filp_open_deep_trace)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Deep filp_open.

[REPORT ARTIFACTS]
- [user_trigger_raw_openat_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_raw_openat_trace_report.md)
- [user_trigger_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_trace_report.md)

[RAW LOG ARTIFACTS]
- [user_trigger_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_dmesg.txt)
- [user_trigger_raw_openat_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_raw_openat_dmesg.txt)

<!-- AUTO-EMBED START -->
[AUTO] case=case17

[FOLDER] case17_do_filp_open_deep_trace
[INTENT] missing-file dentry proof
[BASELINE_PROBES] do_sys_openat2;do_filp_open;path_openat;lookup_open;__d_alloc
[EXTRA_PROBES] do_filp_open;lookup_open;atomic_open;d_alloc_parallel;__d_alloc;fput_close
[EXPECTED_SIGNATURES] __d_alloc hit + do_filp_open ERR_PTR(-ENOENT)

================================================================================
[EMBED] user_trigger_raw_openat_trace_report.md (primary)
[SOURCE] kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_raw_openat_trace_report.md
================================================================================
# Trace Report: user_trigger_raw_openat.S

- Userspace source: `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger_raw_openat.S`
- Driver source: `kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger_raw_openat/trace_user_trigger_raw_openat.c`
- Module: `trace_user_trigger_raw_openat`
- Binary: `kernel/user/stage3/case17_do_filp_open_deep_trace/openat_raw`
- Run timestamp: `2026-02-15T23:32:18`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 1
- do_filp_open.ret: 1
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 1
- Non-error pointer returns observed: 0

## Commands
```bash
make -C kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger_raw_openat
kernel/user/stage3/case17_do_filp_open_deep_trace/openat_raw
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger_raw_openat/trace_user_trigger_raw_openat.ko target_comm="openat_raw"
sudo rmmod trace_user_trigger_raw_openat
```

## Dmesg
`kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_raw_openat_dmesg.txt`

================================================================================
[EMBED] user_trigger_dmesg.txt (primary)
[SOURCE] kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_dmesg.txt
================================================================================
[38317.947023] [trace_user_trigger] loaded target_comm=user_trigger user=kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger.c
[38317.949977] [trace_user_trigger] do_filp_open.entry pid=181836 comm=user_trigger dfd=4294967196 pathname=ffff8dda12eb4000 op=ffffd0c940c9fbb4
[38317.949990] [trace_user_trigger] do_filp_open.ret pid=181836 comm=user_trigger ret=fffffffffffffffe
[38317.949997] [trace_user_trigger] do_filp_open.entry pid=181836 comm=user_trigger dfd=4294967196 pathname=ffff8dda12eb4000 op=ffffd0c940c9fe34
[38317.950002] [trace_user_trigger] do_filp_open.ret pid=181836 comm=user_trigger ret=fffffffffffffffe
[38317.950007] [trace_user_trigger] do_filp_open.entry pid=181836 comm=user_trigger dfd=4294967196 pathname=ffff8dda12eb4000 op=ffffd0c940c9fdb4
[38317.950012] [trace_user_trigger] do_filp_open.ret pid=181836 comm=user_trigger ret=fffffffffffffffe
[38317.950019] [trace_user_trigger] do_filp_open.entry pid=181836 comm=user_trigger dfd=4294967196 pathname=ffff8dda12eb4000 op=ffffd0c940c9fe44
[38317.950023] [trace_user_trigger] do_filp_open.ret pid=181836 comm=user_trigger ret=fffffffffffffffe
[38317.950026] [trace_user_trigger] do_filp_open.entry pid=181836 comm=user_trigger dfd=4294967196 pathname=ffff8dda12eb4000 op=ffffd0c940c9fb94
[38317.950029] [trace_user_trigger] do_filp_open.ret pid=181836 comm=user_trigger ret=fffffffffffffffe
[38317.950032] [trace_user_trigger] do_filp_open.entry pid=181836 comm=user_trigger dfd=4294967196 pathname=ffff8dda12eb4000 op=ffffd0c940c9faa4
[38317.950035] [trace_user_trigger] do_filp_open.ret pid=181836 comm=user_trigger ret=fffffffffffffffe
[38317.950039] [trace_user_trigger] do_filp_open.entry pid=181836 comm=user_trigger dfd=4294967196 pathname=ffff8dda12eb4000 op=ffffd0c940c9fdf4
[38317.950043] [trace_user_trigger] do_filp_open.ret pid=181836 comm=user_trigger ret=ffff8dda03350000
[38317.950060] [trace_user_trigger] do_filp_open.entry pid=181836 comm=user_trigger dfd=4294967196 pathname=ffff8dda12eb4000 op=ffffd0c940c9fe34
[38317.950065] [trace_user_trigger] do_filp_open.ret pid=181836 comm=user_trigger ret=ffff8dda03350c00
[38317.950273] [trace_user_trigger] do_filp_open.entry pid=181836 comm=user_trigger dfd=4294967196 pathname=ffff8dda12eb4000 op=ffffd0c940c9fd04
[38317.950279] [trace_user_trigger] __d_alloc.entry pid=181836 comm=user_trigger sb=ffff8dda0bce8000 name_qstr=ffffd0c940c9fbd0
[38317.950283] [trace_user_trigger] __d_alloc.ret pid=181836 comm=user_trigger dentry=ffff8dda130d76c0
[38317.950296] [trace_user_trigger] do_filp_open.ret pid=181836 comm=user_trigger ret=fffffffffffffffe

================================================================================
[EMBED] DLOOKUP_REPLAY_RUN_LOG.txt (deep)
[SOURCE] kernel/user/stage3/case17_do_filp_open_deep_trace/DLOOKUP_REPLAY_RUN_LOG.txt
================================================================================
[RUN] Case17 d_lookup replay proof

Step1: capture with probe driver
- module: driver.ko
- params: target_comm=user_trigger target_name=missing_case17_filp_
- trigger: ./user_trigger

Captured lines:
[C17][d_alloc_parallel][ENTRY] pid=75221 tgid=75221 parent=ffff8dda3ba6f0c0 parent_inode=ffff8ddb28e95d98 parent_name=case17_do_filp_open_deep_trace child_name=missing_case17_filp_75221.txt parent_sb=ffff8dda0bce8000 sb_magic=0xef53 sb_blocksize=4096
[C17][__d_alloc][ENTRY] pid=75221 tgid=75221 qstr_ptr=ffffd0c941f33a80 name_ptr=ffff8dda082a8083 len=29 hash=0xf168d14a name=missing_case17_filp_75221.txt
[C17][__d_alloc][RET] pid=75221 tgid=75221 dentry=ffff8ddc063cb3c0 inode=0000000000000000 unhashed=1 in_lookup=0 name.hash=0xf168d14a name.len=29 name_ptr=ffff8ddc063cb3f8
[C17][do_filp_open][RET] pid=75221 tgid=75221 ret_ptr=fffffffffffffffe is_err=1 err=2

Parsed replay inputs:
- parent_addr=0xffff8dda3ba6f0c0
- child_name=missing_case17_filp_75221.txt
- child_hash=0xf168d14a

Step2: replay with direct d_lookup module
- module: dlookup_replay_driver.ko
- params: parent_addr=0xffff8dda3ba6f0c0 child_name=missing_case17_filp_75221.txt child_hash=0xf168d14a

Replay output:
[DLOOKUP_REPLAY] init parent=ffff8dda3ba6f0c0 child_name=missing_case17_filp_75221.txt child_hash=0xf168d14a
[DLOOKUP_REPLAY] d_lookup HIT dentry=ffff8ddc063cb3c0 inode=0000000000000000 negative=1 unhashed=0

Result:
- d_lookup returned non-NULL HIT for captured parent+qstr
- returned dentry is negative (inode=NULL)

================================================================================
[EMBED] REVERSE_FULL_TRACE_MISSING_FILE_CASE17_PSTREE.md (deep)
[SOURCE] kernel/user/stage3/case17_do_filp_open_deep_trace/REVERSE_FULL_TRACE_MISSING_FILE_CASE17_PSTREE.md
================================================================================
# Reverse Full Trace (Case17 Missing File) (pstree style, end -> start)
Run data source: `kernel/user/stage3/case17_do_filp_open_deep_trace/DLOOKUP_REPLAY_RUN_LOG.txt`
Kernel source anchors: `/usr/src/linux-hwe-6.17-6.17.0`

Legend (tokens used inline per-line): `CALL`=enter function, `RET`=return from function, `RESUME`=caller continues after callee returns.

0.  [ROOT] user_trigger(pid=75221 tgid=75221 comm="user_trigger") -> open("/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case17_do_filp_open_deep_trace/missing_case17_filp_75221.txt", O_RDONLY=0x0)
|
|-- #1 RET  userspace:open() -> fd=-1 errno=2(ENOENT)  path_len=114  flags=0x0  (result printed by `user_trigger.c`)
|   |
|   `-- #2 RET  kernel:do_sys_openat2  /usr/src/linux-hwe-6.17-6.17.0/fs/open.c:1420  caller=__x64_sys_openat2/?  fd_result=-2  (ENOENT)
|       |
|       `-- #3 RESUME fs/open.c:1437  do_sys_openat2 resumes after do_filp_open(dfd=AT_FDCWD? or abs path) returned IS_ERR(f)=1
|           |
|           `-- #4 RET  kernel:do_filp_open  /usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:4073  pid=75221  ret_ptr=0xfffffffffffffffe  is_err=1  err=2
|               |
|               `-- #5 RESUME fs/namei.c:4040-4063  path_openat() had alloc_empty_file() already; error path executed -> fput_close(file) (fs/namei.c:4063)
|                   |
|                   `-- #6 RET  kernel:path_openat  /usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:4034  pid=75221  error=-2
|                       |
|                       `-- #7 RESUME fs/namei.c:4049-4055  while-loop ended with error=-2 from do_open() path (not ECHILD/ESTALE)
|                           |
|                           `-- #8 RET  kernel:do_open  /usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3851  pid=75221  error=-2
|                               |
|                               `-- #9 RET  kernel:may_open  /usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3447  pid=75221  inode=0x0 -> return -2
|                                   |
|                                   `-- #10 DATA fs/namei.c:3450-3455  dentry=nd->path.dentry=(NEGATIVE)  inode=dentry->d_inode=0x0  if(!inode) return -ENOENT
|
|-- #11 RESUME (how nd->path.dentry became NEGATIVE)  do_open() at fs/namei.c:3860-3864 saw file->f_mode lacks FMODE_OPENED|FMODE_CREATED -> complete_walk() then audit/idmap then may_open()
|   |
|   `-- #12 RET  kernel:open_last_lookups  /usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3768  pid=75221  returns NULL/err-sentinel such that path_openat while-loop exits
|       |
|       `-- #13 RESUME fs/namei.c:3815  open_last_lookups called lookup_open() under inode_lock_shared()
|           |
|           `-- #14 RET  kernel:lookup_open  /usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3618  pid=75221  returns dentry=0xffff8ddc063cb3c0  d_inode=0x0  (negative)
|               |
|               |-- #15 DATA fs/namei.c:3634  file->f_mode &= ~FMODE_CREATED  (O_CREAT not set; open_flag=0x0 from userspace O_RDONLY)
|               |
|               |-- #16 RESUME fs/namei.c:3635  dentry = d_lookup(dir=0xffff8dda3ba6f0c0, name=&nd->last)
|               |   |
|               |   `-- #17 RET  kernel:d_lookup  /usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:2332  parent=0xffff8dda3ba6f0c0  qstr.hash=0xf168d14a  -> returns NULL (cache miss)
|               |       |
|               |       `-- #18 RET  kernel:__d_lookup  /usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:2362  bucket=d_hash(0xf168d14a)  scan count>=0  found=0x0
|               |
|               |-- #19 RESUME fs/namei.c:3637  if(!dentry) -> dentry=d_alloc_parallel(dir,&nd->last,&wq)
|               |   |
|               |   `-- #20 RET  kernel:d_alloc_parallel  /usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:2542  pid=75221
|               |       parent=0xffff8dda3ba6f0c0  parent_inode=0xffff8ddb28e95d98  parent_sb=0xffff8dda0bce8000  sb_magic=0xef53  sb_blocksize=4096
|               |       child_name="missing_case17_filp_75221.txt" len=29 hash=0xf168d14a
|               |       returns new=0xffff8ddc063cb3c0
|               |       |
|               |       |-- #21 DATA fs/dcache.c:2549  new = __d_alloc(parent->d_sb, name)
|               |       |   |
|               |       |   `-- #22 RET  kernel:__d_alloc  /usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:1684  qstr_ptr=0xffffd0c941f33a80 name_ptr=0xffff8dda082a8083 len=29 hash=0xf168d14a
|               |       |       -> dentry=0xffff8ddc063cb3c0  inode=0x0  unhashed=1  in_lookup=0  (captured at __d_alloc RET)
|               |       |
|               |       |-- #23 DATA fs/dcache.c:2558-2559  new->d_parent = dget_dlock(parent)  AND  hlist_add_head(&new->d_sib,&parent->d_children)
|               |       |-- #24 DATA fs/dcache.c:2647-2649  new->d_wait=&wq  AND  hlist_bl_add_head(&new->d_u.d_in_lookup_hash, in_lookup_bucket(parent,hash))
|               |       `-- #25 NOTE fs/dcache.c:2648  this is NOT global dentry_hashtable; it is the per-parent “in-lookup” chain to dedupe parallel lookups
|               |
|               |-- #26 RESUME fs/namei.c:3642-3643  if(d_in_lookup(dentry)) break;  (dentry is in-lookup now)
|               |
|               `-- #27 RESUME fs/namei.c:3693-3705  because d_in_lookup(dentry)=1:
|                   |
|                   |-- #28 CALL kernel:FS->lookup  (ext4)  dir_inode->i_op->lookup(dir_inode=0xffff8ddb28e95d98, dentry=0xffff8ddc063cb3c0, flags=nd->flags)
|                   |   |
|                   |   `-- #29 RET  kernel:ext4_lookup  /usr/src/linux-hwe-6.17-6.17.0/fs/ext4/namei.c:1762
|                   |       inode=0x0 (miss)  -> return d_splice_alias(inode=0x0, dentry=0xffff8ddc063cb3c0) at fs/ext4/namei.c:1814
|                   |
|                   |-- #30 RESUME (FS -> VFS callback)  d_splice_alias(NULL,dentry) enters dcache attach path:
|                   |   |
|                   |   |-- #31 CALL kernel:__d_add  /usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:2692  dentry=0xffff8ddc063cb3c0 inode=0x0 ops=0x0
|                   |   |-- #32 DATA fs/dcache.c:2699-2703  d_in_lookup(dentry)=1 -> __d_lookup_unhash(dentry) removes d_u.d_in_lookup_hash node (ends “lookup in progress” chain)
|                   |   |-- #33 DATA fs/dcache.c:2714  __d_rehash(dentry)
|                   |   |   |
|                   |   |   `-- #34 DATA kernel:__d_rehash  /usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:2484  b=d_hash(dentry->d_name.hash=0xf168d14a)  -> hlist_bl_add_head_rcu(&dentry->d_hash,b) at fs/dcache.c:2489
|                   |   |       RESULT: dentry=0xffff8ddc063cb3c0 now reachable by future __d_lookup(parent,qstr) bucket scan
|                   |   `-- #35 RET  __d_add returns (still inside lookup_open call stack)
|                   |
|                   |-- #36 RESUME fs/namei.c:3696  d_lookup_done(dentry) executes after FS lookup returns (clears in-lookup state / wakes waiters)
|                   |-- #37 RESUME fs/namei.c:3697-3704  res!=NULL (ext4 returned dentry*) -> dput(old_dentry) then dentry=res (same pointer in this run)
|                   `-- #38 RET  fs/namei.c:3725  lookup_open returns negative dentry 0xffff8ddc063cb3c0 (open_flag lacks O_CREAT)
|
`-- [POST-PROOF] replay verification (separate module, after the failed open)
    |
    |-- #39 CALL  d_lookup_replay_driver:init  parent=0xffff8dda3ba6f0c0  child_name="missing_case17_filp_75221.txt"  child_hash=0xf168d14a
    `-- #40 RET   d_lookup(parent,qstr) HIT  dentry=0xffff8ddc063cb3c0  inode=0x0  negative=1  unhashed=0  (proves global dentry_hashtable insert happened at fs/dcache.c:2489)

================================================================================
[EMBED] DLOOKUP_CRITICAL_BLOCK_NUMERIC.md (deep)
[SOURCE] kernel/user/stage3/case17_do_filp_open_deep_trace/DLOOKUP_CRITICAL_BLOCK_NUMERIC.md
================================================================================
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

================================================================================
[EMBED] LOOKUP_OPEN_PSEUDODEBUG_TRACE_MISSING_FILE.md (deep)
[SOURCE] kernel/user/stage3/case17_do_filp_open_deep_trace/LOOKUP_OPEN_PSEUDODEBUG_TRACE_MISSING_FILE.md
================================================================================
# lookup_open() Pseudo-Debug Trace (Case17 Missing File) (single caller, no race)
Data source (captured): `kernel/user/stage3/case17_do_filp_open_deep_trace/DLOOKUP_REPLAY_RUN_LOG.txt`
Kernel source anchors: `/usr/src/linux-hwe-6.17-6.17.0`

Target run (captured):
- pid=75221 tgid=75221 comm=`user_trigger`
- parent dentry (dir)=`0xffff8dda3ba6f0c0`
- parent inode (dir_inode)=`0xffff8ddb28e95d98`
- superblock (parent->d_sb)=`0xffff8dda0bce8000` magic=`0xef53` blocksize=`4096`
- last component (nd->last): name=`"missing_case17_filp_75221.txt"` len=`29` hash=`0xf168d14a`

Format per line:
`#N  FUNC  STATE  file:line  caller(file:line)  values  work  result`

1.  lookup_open  CALL    fs/namei.c:3618  open_last_lookups(fs/namei.c:3815)  dir=`0xffff8dda3ba6f0c0` dir_inode=`0xffff8ddb28e95d98` open_flag=`0x0` got_write=`0`  enter  ok
2.  lookup_open  DATA    fs/namei.c:3634  lookup_open(fs/namei.c:3618)        file->f_mode: (old)=?  work=`file->f_mode &= ~FMODE_CREATED`  file->f_mode (new)=old&~FMODE_CREATED
3.  d_lookup     CALL    fs/dcache.c:2332  lookup_open(fs/namei.c:3635)       parent=`0xffff8dda3ba6f0c0` qstr.name=`"missing_case17_filp_75221.txt"` qstr.len=`29` qstr.hash=`0xf168d14a`  begin  ->
4.  __d_lookup   CALL    fs/dcache.c:2362  d_lookup(fs/dcache.c:2339)         hash=`0xf168d14a` bucket=`d_hash(0xf168d14a)`  scan `dentry_hashtable` bucket-chain  found=`NULL`
5.  d_lookup     RET     fs/dcache.c:2332  lookup_open(fs/namei.c:3635)       ret=`NULL`  cache-miss  dentry=`NULL`
6.  lookup_open  BRANCH  fs/namei.c:3637  lookup_open(fs/namei.c:3636)       cond=`(!dentry)` -> TRUE  allocate candidate via d_alloc_parallel  ->
7.  d_alloc_parallel  CALL  fs/dcache.c:2542  lookup_open(fs/namei.c:3638)    parent=`0xffff8dda3ba6f0c0` name=`"missing_case17_filp_75221.txt"` len=`29` hash=`0xf168d14a` wq=`&wq(stack)`  allocate+publish(in-lookup)  ->
8.  __d_alloc    CALL    fs/dcache.c:1684  d_alloc_parallel(fs/dcache.c:2549) sb=`0xffff8dda0bce8000` qstr_ptr=`0xffffd0c941f33a80` name_ptr=`0xffff8dda082a8083` len=`29` hash=`0xf168d14a`  slab alloc (`kmem_cache_alloc_lru`) + init name fields  ->
9.  __d_alloc    RET     fs/dcache.c:1684  d_alloc_parallel(fs/dcache.c:2549) ret(new)=`0xffff8ddc063cb3c0` new->d_inode=`0x0` new unhashed=`1` new in_lookup=`0` name.hash=`0xf168d14a` name.len=`29` name_ptr_field_addr=`0xffff8ddc063cb3f8`  dentry object exists (negative, not hashed yet)  ok
10. d_alloc_parallel  DATA  fs/dcache.c:2556  d_alloc_parallel(fs/dcache.c:2542) new=`0xffff8ddc063cb3c0`  set `DCACHE_PAR_LOOKUP`  ok
11. d_alloc_parallel  DATA  fs/dcache.c:2558  d_alloc_parallel(fs/dcache.c:2542) new->d_parent=`dget_dlock(parent=0xffff8dda3ba6f0c0)`  attach to parent pointer  ok
12. d_alloc_parallel  DATA  fs/dcache.c:2559  d_alloc_parallel(fs/dcache.c:2542) link-list: `hlist_add_head(&new->d_sib,&parent->d_children)`  attach into parent child list  ok
13. d_alloc_parallel  DATA  fs/dcache.c:2647  d_alloc_parallel(fs/dcache.c:2542) new->d_wait=`&wq(stack)`  publish waiter queue pointer  ok
14. d_alloc_parallel  DATA  fs/dcache.c:2648  d_alloc_parallel(fs/dcache.c:2542) `hlist_bl_add_head(&new->d_u.d_in_lookup_hash, in_lookup_hash(parent,hash))`  publish “lookup-in-progress” node  ok
15. d_alloc_parallel  RET   fs/dcache.c:2650  lookup_open(fs/namei.c:3638)     ret=`0xffff8ddc063cb3c0`  return candidate dentry  dentry!=ERR
16. lookup_open  BRANCH  fs/namei.c:3642  lookup_open(fs/namei.c:3636)       cond=`d_in_lookup(dentry)` -> TRUE  break out of for(;;)  ->
17. lookup_open  BRANCH  fs/namei.c:3654  lookup_open(fs/namei.c:3618)       cond=`dentry->d_inode` -> FALSE (`0x0`)  continue (not cached positive)  ->
18. lookup_open  BRANCH  fs/namei.c:3686  lookup_open(fs/namei.c:3618)       cond=`dir_inode->i_op->atomic_open` -> FALSE in this run (path uses ->lookup)  ->
19. FS->lookup   CALL    fs/namei.c:3694  lookup_open(fs/namei.c:3693)       call=`dir_inode->i_op->lookup(dir_inode=0xffff8ddb28e95d98, dentry=0xffff8ddc063cb3c0, flags=nd->flags)`  ask FS “does this name exist?”  ->
20. ext4_lookup  CALL    fs/ext4/namei.c:1762  lookup_open(fs/namei.c:3694)   dentry=`0xffff8ddc063cb3c0`  directory search  ->
21. ext4_lookup  DATA    fs/ext4/namei.c:1774  ext4_lookup(fs/ext4/namei.c:1762) inode=`NULL` on miss  missing file confirmed by FS directory scan  inode=`0x0`
22. ext4_lookup  RET     fs/ext4/namei.c:1814  lookup_open(fs/namei.c:3694)   return=`d_splice_alias(inode=0x0,dentry=0xffff8ddc063cb3c0)`  FS hands result to VFS dcache  res=`dentry*` (usually same)
23. __d_add      CALL    fs/dcache.c:2692  (via d_splice_alias)               dentry=`0xffff8ddc063cb3c0` inode=`0x0` ops=`0x0`  finalize dentry + hash it  (NOT PROBED in this run)
24. __d_add      DATA    fs/dcache.c:2699  __d_add(fs/dcache.c:2692)          cond=`d_in_lookup(dentry)` -> TRUE  remove in-lookup state via `__d_lookup_unhash(dentry)`  (NOT PROBED)
25. __d_add      DATA    fs/dcache.c:2714  __d_add(fs/dcache.c:2692)          call=`__d_rehash(dentry)`  insert into global dentry_hashtable  (NOT PROBED)
26. __d_rehash   DATA    fs/dcache.c:2489  __d_rehash(fs/dcache.c:2484)       `hlist_bl_add_head_rcu(&dentry->d_hash, d_hash(dentry->d_name.hash=0xf168d14a))`  global-hash attach happens here  (NOT PROBED)
27. lookup_open  DATA    fs/namei.c:3696  lookup_open(fs/namei.c:3693)       `d_lookup_done(dentry)`  clear lookup-in-progress flag/wake waiters  (NOT PROBED)
28. lookup_open  BRANCH  fs/namei.c:3697  lookup_open(fs/namei.c:3693)       cond=`res` -> TRUE (ext4 returned non-NULL)  if(res==dentry) net effect is keep same pointer; code does `dput(dentry); dentry=res;`  (NOT PROBED)
29. lookup_open  BRANCH  fs/namei.c:3708  lookup_open(fs/namei.c:3618)       cond=`(!dentry->d_inode && (open_flag & O_CREAT))` -> FALSE (open_flag=`0x0`)  skip create  ->
30. lookup_open  RET     fs/namei.c:3725  open_last_lookups(fs/namei.c:3815)  ret=`0xffff8ddc063cb3c0` inode=`0x0`  negative dentry returned to caller  ok

Post-proof (captured separately, confirms step #26 happened):
31. d_lookup (replay)  RET  fs/dcache.c:2332  dlookup_replay_driver            HIT ret=`0xffff8ddc063cb3c0` inode=`0x0` negative=`1` unhashed=`0`  (means: global dentry_hashtable contains it)

Notes:
- Steps marked “NOT PROBED” are kernel-source steps that were *proven indirectly* by the replay HIT (`unhashed=0`) plus the captured pre/post pointers.
- If you want direct brute proof, add kprobe+kretprobe on: `__d_add`, `__d_rehash`, and `__d_lookup_unhash` and re-run the same trigger.
<!-- AUTO-EMBED END -->
