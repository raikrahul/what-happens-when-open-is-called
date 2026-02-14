---
layout: default
title: "Stage 3 Case 17: Worksheet (Lingering Negative Dentry Proof)"
---

This worksheet derives the proof chain for: missing file open fails, but dentry object exists and remains readable after userspace exits.

### [TRACE MAP]
**Target:** `do_filp_open` / `d_alloc_parallel` / `__d_alloc` / hardcoded pointer read
**Process:** fail open + capture dentry pointer + reload pointer-check module

1. **[entry]** `do_filp_open` (target filename)
2. **[step]** `d_alloc_parallel` (parent + sb)
3. **[step]** `__d_alloc` return (new dentry pointer)
4. **[exit]** `do_filp_open` return `-ENOENT`
5. **[post]** pointer-check driver reads dentry fields by hardcoded address

---

### [FILES YOU NEED]
- Trace driver: `kernel/user/stage3/case17_do_filp_open_deep_trace/driver.c`
- Pointer checker: `kernel/user/stage3/case17_do_filp_open_deep_trace/pointer_check_driver.c`
- Minimal userspace trigger: `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger_raw_openat.S`
- Run log: `kernel/user/stage3/case17_do_filp_open_deep_trace/DMESG_CAPTURE_2026-02-14_CASE17.txt`
- Pointer dmesg log: `kernel/user/stage3/case17_do_filp_open_deep_trace/POINTER_CHECK_DMESG_2026-02-14.txt`

---

### [WORKSHEET: RECORD RAW DATA]

1. `do_filp_open ENTRY` line
- pid = __________
- tgid = __________
- pathname = _______________________________________________

2. `d_alloc_parallel ENTRY` line
- parent dentry ptr = `0x________________`
- parent inode ptr = `0x________________`
- parent name = `________________________`
- parent sb ptr = `0x________________`
- sb_magic = `0x________________`
- sb_blocksize = `________________`

3. `__d_alloc ENTRY` line
- qstr ptr = `0x________________`
- name ptr = `0x________________`
- len = `________________`
- hash = `0x________________`
- name = `________________________`

4. `__d_alloc RET` line
- new dentry ptr = `0x________________`
- inode ptr = `0x________________`
- unhashed = `________________`
- in_lookup = `________________`
- name.hash = `0x________________`
- name.len = `________________`
- name_ptr = `0x________________`

5. `do_filp_open RET` line
- ret_ptr = `0x________________`
- is_err = `________________`
- err = `________________`

---

### [AXIOM CHECKS]

1. Missing-file failure check
- `err == 2` ? [YES / NO]

2. Dentry-created check
- `__d_alloc RET` present for same pid/tgid ? [YES / NO]

3. Negative-dentry check
- `inode ptr == 0x0` ? [YES / NO]

4. Name identity check
- `__d_alloc ENTRY hash == __d_alloc RET name.hash` ? [YES / NO]
- `__d_alloc ENTRY len == __d_alloc RET name.len` ? [YES / NO]

5. Parent + filesystem context check
- `sb_magic == 0xef53` ? [YES / NO]

---

### [POINTER LINGER CHECK AFTER USERSPACE EXIT]

Run pointer checker module after trace run and process exit.

Record from `[PTRCHK]` log:

1. hardcoded dentry addr
- target_dentry_addr = `0x________________`

2. pointer readable checks
- read qword0 rc = `________________`
- read d_parent rc = `________________`
- read d_inode rc = `________________`
- read d_name.len rc = `________________`
- read d_name.hash rc = `________________`
- read d_name.name rc = `________________`
- read name bytes rc = `________________`

3. reconstructed name proof
- text = `________________________`

4. lingering check
- pointer read rc all zero ? [YES / NO]
- text still matches target filename ? [YES / NO]
- d_inode still zero ? [YES / NO]

---

### [NUMERIC CONSISTENCY BLOCK]

1. len bytes copied check
- logged len = `________________`
- logged ncopy = `________________`
- expected relation: `ncopy = min(len, 63)`
- relation true ? [YES / NO]

2. hash consistency check
- trace hash = `0x________________`
- pointer-check hash = `0x________________`
- equal ? [YES / NO]

3. pointer continuity check
- trace dentry ptr = `0x________________`
- pointer-check target ptr = `0x________________`
- equal ? [YES / NO]

---

### [WHAT THIS PROVES]

Fill only after all checks are YES:

1. `do_filp_open` failed with `ENOENT`: [YES / NO]
2. dentry object was allocated for missing name: [YES / NO]
3. that dentry remained readable by address after userspace exit: [YES / NO]
4. stored name bytes still map to missing filename: [YES / NO]

---

### [FAILURE PREDICTIONS]

F1. No `__d_alloc` line
- cause: cache already had entry / wrong filter
- action: use unique filename and drop caches

F2. Pointer-check reads fail (`rc != 0`)
- cause: dentry reclaimed before second module load
- action: reduce delay, rerun trace then immediate pointer-check

F3. Hash mismatch
- cause: wrong hardcoded pointer
- action: recopy pointer from latest `__d_alloc RET`

F4. Name read fails but scalar fields read
- cause: name pointer became invalid/reclaimed
- action: rerun with immediate pointer-check

F5. `err != 2`
- cause: wrong open flags/path condition
- action: ensure file is missing and open is read-only

---

### [RUN ORDER (STRICT)]

1. unload modules
```bash
sudo rmmod driver || true
sudo rmmod pointer_check_driver || true
```

2. trace run
```bash
cd kernel/user/stage3/case17_do_filp_open_deep_trace
make
sudo sh -c 'echo 2 > /proc/sys/vm/drop_caches'
sudo dmesg -C
sudo insmod ./driver.ko target_comm=openat_raw target_name=missing_case17_raw_syscall
./openat_raw
sudo dmesg | tail -n 260
sudo rmmod driver
```

3. pointer lingering run
```bash
sudo dmesg -C
sudo insmod ./pointer_check_driver.ko
sudo dmesg | tail -n 120
sudo rmmod pointer_check_driver
```

