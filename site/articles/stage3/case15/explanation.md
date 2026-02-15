---
layout: default
title: "Stage 3 CASE15: Explanation"
---
[CASE]
- id: case15
- title: Deep Trace
- userspace root: [kernel/user/stage3/case15_deep_trace](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace)
- driver root: [kernel/drivers/stage3/case15_deep_trace](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case15_deep_trace)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Deep Trace.

[REPORT ARTIFACTS]
- [user_deep_create_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace/reports/user_deep_create_trace_report.md)
- [user_deep_open_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace/reports/user_deep_open_trace_report.md)

[RAW LOG ARTIFACTS]
- [user_deep_create_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace/reports/user_deep_create_dmesg.txt)
- [user_deep_open_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace/reports/user_deep_open_dmesg.txt)

<!-- AUTO-EMBED START -->
[AUTO] case=case15

[FOLDER] case15_deep_trace
[INTENT] deep path traversal
[BASELINE_PROBES] do_sys_openat2;do_filp_open;path_openat;lookup_open;__d_alloc
[EXTRA_PROBES] path_init;link_path_walk;open_last_lookups;do_open;lookup_open
[EXPECTED_SIGNATURES] deep walk timing

================================================================================
[EMBED] user_deep_create_trace_report.md (primary)
[SOURCE] kernel/user/stage3/case15_deep_trace/reports/user_deep_create_trace_report.md
================================================================================
# Trace Report: user_deep_create.c

- Userspace source: `kernel/user/stage3/case15_deep_trace/user_deep_create.c`
- Driver source: `kernel/drivers/stage3/case15_deep_trace/trace_user_deep_create/trace_user_deep_create.c`
- Module: `trace_user_deep_create`
- Binary: `kernel/user/stage3/case15_deep_trace/user_deep_create`
- Run timestamp: `2026-02-15T23:32:11`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 9
- do_filp_open.ret: 9
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 3

## Commands
```bash
make -C kernel/drivers/stage3/case15_deep_trace/trace_user_deep_create
kernel/user/stage3/case15_deep_trace/user_deep_create
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case15_deep_trace/trace_user_deep_create/trace_user_deep_create.ko target_comm="user_deep_creat"
sudo rmmod trace_user_deep_create
```

## Dmesg
`kernel/user/stage3/case15_deep_trace/reports/user_deep_create_dmesg.txt`

================================================================================
[EMBED] user_deep_create_dmesg.txt (primary)
[SOURCE] kernel/user/stage3/case15_deep_trace/reports/user_deep_create_dmesg.txt
================================================================================
[38312.303621] [trace_user_deep_create] loaded target_comm=user_deep_creat user=kernel/user/stage3/case15_deep_trace/user_deep_create.c
[38312.307327] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823d44
[38312.307340] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=fffffffffffffffe
[38312.307346] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823c84
[38312.307351] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=fffffffffffffffe
[38312.307356] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823be4
[38312.307361] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=fffffffffffffffe
[38312.307368] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823ab4
[38312.307371] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=fffffffffffffffe
[38312.307374] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823b74
[38312.307377] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=fffffffffffffffe
[38312.307380] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823e54
[38312.307384] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=fffffffffffffffe
[38312.307387] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823c44
[38312.307392] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=ffff8dda39edf780
[38312.307411] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823cb4
[38312.307416] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=ffff8dda39edff00
[38312.307661] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823c44
[38312.307688] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=ffff8dda39edf780
<!-- AUTO-EMBED END -->
