---
layout: default
title: "Stage 3 CASE7: Explanation"
---
[CASE]
- id: case7
- title: Symlink Follow
- userspace root: [kernel/user/stage3/case7_symlink_fast](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case7_symlink_fast)
- driver root: [kernel/drivers/stage3/case7_symlink_fast](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case7_symlink_fast)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Symlink Follow.

[REPORT ARTIFACTS]
- [case7_symlink_fast_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case7_symlink_fast/reports/case7_symlink_fast_trace_report.md)

[RAW LOG ARTIFACTS]
- [case7_symlink_fast_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case7_symlink_fast/reports/case7_symlink_fast_dmesg.txt)

<!-- AUTO-EMBED START -->
[AUTO] case=case7

[FOLDER] case7_symlink_fast
[INTENT] symlink resolved quickly
[BASELINE_PROBES] do_sys_openat2;do_filp_open;path_openat;lookup_open;__d_alloc
[EXTRA_PROBES] pick_link;step_into;link_path_walk
[EXPECTED_SIGNATURES] symlink resolution success

================================================================================
[EMBED] case7_symlink_fast_trace_report.md (primary)
[SOURCE] kernel/user/stage3/case7_symlink_fast/reports/case7_symlink_fast_trace_report.md
================================================================================
# Trace Report: case7_symlink_fast.c

- Userspace source: `kernel/user/stage3/case7_symlink_fast/case7_symlink_fast.c`
- Driver source: `kernel/drivers/stage3/case7_symlink_fast/trace_case7_symlink_fast/trace_case7_symlink_fast.c`
- Module: `trace_case7_symlink_fast`
- Binary: `kernel/user/stage3/case7_symlink_fast/case7_symlink_fast`
- Run timestamp: `2026-02-15T23:32:30`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 9
- do_filp_open.ret: 9
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 7
- Non-error pointer returns observed: 2

## Commands
```bash
make -C kernel/drivers/stage3/case7_symlink_fast/trace_case7_symlink_fast
kernel/user/stage3/case7_symlink_fast/case7_symlink_fast
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case7_symlink_fast/trace_case7_symlink_fast/trace_case7_symlink_fast.ko target_comm="case7_symlink_f"
sudo rmmod trace_case7_symlink_fast
```

## Dmesg
`kernel/user/stage3/case7_symlink_fast/reports/case7_symlink_fast_dmesg.txt`

================================================================================
[EMBED] case7_symlink_fast_dmesg.txt (primary)
[SOURCE] kernel/user/stage3/case7_symlink_fast/reports/case7_symlink_fast_dmesg.txt
================================================================================
[38331.135080] [trace_case7_symlink_fast] loaded target_comm=case7_symlink_f user=kernel/user/stage3/case7_symlink_fast/case7_symlink_fast.c
[38331.137554] [trace_case7_symlink_fast] do_filp_open.entry pid=183660 comm=case7_symlink_f dfd=4294967196 pathname=ffff8dda082af000 op=ffffd0c941c53cf4
[38331.137566] [trace_case7_symlink_fast] do_filp_open.ret pid=183660 comm=case7_symlink_f ret=fffffffffffffffe
[38331.137573] [trace_case7_symlink_fast] do_filp_open.entry pid=183660 comm=case7_symlink_f dfd=4294967196 pathname=ffff8dda082af000 op=ffffd0c941c53ba4
[38331.137578] [trace_case7_symlink_fast] do_filp_open.ret pid=183660 comm=case7_symlink_f ret=fffffffffffffffe
[38331.137583] [trace_case7_symlink_fast] do_filp_open.entry pid=183660 comm=case7_symlink_f dfd=4294967196 pathname=ffff8dda082af000 op=ffffd0c941c53b44
[38331.137588] [trace_case7_symlink_fast] do_filp_open.ret pid=183660 comm=case7_symlink_f ret=fffffffffffffffe
[38331.137594] [trace_case7_symlink_fast] do_filp_open.entry pid=183660 comm=case7_symlink_f dfd=4294967196 pathname=ffff8dda082af000 op=ffffd0c941c53c94
[38331.137598] [trace_case7_symlink_fast] do_filp_open.ret pid=183660 comm=case7_symlink_f ret=fffffffffffffffe
[38331.137601] [trace_case7_symlink_fast] do_filp_open.entry pid=183660 comm=case7_symlink_f dfd=4294967196 pathname=ffff8dda082af000 op=ffffd0c941c53af4
[38331.137604] [trace_case7_symlink_fast] do_filp_open.ret pid=183660 comm=case7_symlink_f ret=fffffffffffffffe
[38331.137607] [trace_case7_symlink_fast] do_filp_open.entry pid=183660 comm=case7_symlink_f dfd=4294967196 pathname=ffff8dda082af000 op=ffffd0c941c53cc4
[38331.137611] [trace_case7_symlink_fast] do_filp_open.ret pid=183660 comm=case7_symlink_f ret=fffffffffffffffe
[38331.137614] [trace_case7_symlink_fast] do_filp_open.entry pid=183660 comm=case7_symlink_f dfd=4294967196 pathname=ffff8dda082af000 op=ffffd0c941c53ae4
[38331.137619] [trace_case7_symlink_fast] do_filp_open.ret pid=183660 comm=case7_symlink_f ret=ffff8dda05063000
[38331.137637] [trace_case7_symlink_fast] do_filp_open.entry pid=183660 comm=case7_symlink_f dfd=4294967196 pathname=ffff8dda082af000 op=ffffd0c941c53c34
[38331.137642] [trace_case7_symlink_fast] do_filp_open.ret pid=183660 comm=case7_symlink_f ret=ffff8dda05063c00
[38331.137842] [trace_case7_symlink_fast] do_filp_open.entry pid=183660 comm=case7_symlink_f dfd=4294967196 pathname=ffff8dda082af000 op=ffffd0c941c53be4
[38331.137848] [trace_case7_symlink_fast] do_filp_open.ret pid=183660 comm=case7_symlink_f ret=fffffffffffffffe
<!-- AUTO-EMBED END -->
