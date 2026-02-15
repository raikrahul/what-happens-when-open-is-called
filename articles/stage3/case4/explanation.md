---
layout: default
title: "Stage 3 CASE4: Explanation"
---
[CASE]
- id: case4
- title: Create Flow
- userspace root: [kernel/user/stage3/case4_create_flow](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case4_create_flow)
- driver root: [kernel/drivers/stage3/case4_create_flow](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case4_create_flow)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Create Flow.

[REPORT ARTIFACTS]
- [case4_create_flow_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case4_create_flow/reports/case4_create_flow_trace_report.md)

[RAW LOG ARTIFACTS]
- [case4_create_flow_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case4_create_flow/reports/case4_create_flow_dmesg.txt)

<!-- AUTO-EMBED START -->
[AUTO] case=case4

[FOLDER] case4_create_flow
[INTENT] create-if-missing
[BASELINE_PROBES] do_sys_openat2;do_filp_open;path_openat;lookup_open;__d_alloc
[EXTRA_PROBES] lookup_open;atomic_open;vfs_create;may_open
[EXPECTED_SIGNATURES] FMODE_CREATED path;create success/permission error

================================================================================
[EMBED] case4_create_flow_trace_report.md (primary)
[SOURCE] kernel/user/stage3/case4_create_flow/reports/case4_create_flow_trace_report.md
================================================================================
# Trace Report: case4_create_flow.c

- Userspace source: `kernel/user/stage3/case4_create_flow/case4_create_flow.c`
- Driver source: `kernel/drivers/stage3/case4_create_flow/trace_case4_create_flow/trace_case4_create_flow.c`
- Module: `trace_case4_create_flow`
- Binary: `kernel/user/stage3/case4_create_flow/case4_create_flow`
- Run timestamp: `2026-02-15T23:32:21`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 10
- do_filp_open.ret: 10
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 4

## Commands
```bash
make -C kernel/drivers/stage3/case4_create_flow/trace_case4_create_flow
kernel/user/stage3/case4_create_flow/case4_create_flow
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case4_create_flow/trace_case4_create_flow/trace_case4_create_flow.ko target_comm="case4_create_fl"
sudo rmmod trace_case4_create_flow
```

## Dmesg
`kernel/user/stage3/case4_create_flow/reports/case4_create_flow_dmesg.txt`

================================================================================
[EMBED] case4_create_flow_dmesg.txt (primary)
[SOURCE] kernel/user/stage3/case4_create_flow/reports/case4_create_flow_dmesg.txt
================================================================================
[38322.495731] [trace_case4_create_flow] loaded target_comm=case4_create_fl user=kernel/user/stage3/case4_create_flow/case4_create_flow.c
[38322.498933] [trace_case4_create_flow] do_filp_open.entry pid=182858 comm=case4_create_fl dfd=4294967196 pathname=ffff8dda0c847000 op=ffffd0c9407c7d44
[38322.498947] [trace_case4_create_flow] do_filp_open.ret pid=182858 comm=case4_create_fl ret=fffffffffffffffe
[38322.498954] [trace_case4_create_flow] do_filp_open.entry pid=182858 comm=case4_create_fl dfd=4294967196 pathname=ffff8dda0c847000 op=ffffd0c9407c7be4
[38322.498959] [trace_case4_create_flow] do_filp_open.ret pid=182858 comm=case4_create_fl ret=fffffffffffffffe
[38322.498964] [trace_case4_create_flow] do_filp_open.entry pid=182858 comm=case4_create_fl dfd=4294967196 pathname=ffff8dda0c847000 op=ffffd0c9407c7d74
[38322.498970] [trace_case4_create_flow] do_filp_open.ret pid=182858 comm=case4_create_fl ret=fffffffffffffffe
[38322.498976] [trace_case4_create_flow] do_filp_open.entry pid=182858 comm=case4_create_fl dfd=4294967196 pathname=ffff8dda0c847000 op=ffffd0c9407c7dd4
[38322.498980] [trace_case4_create_flow] do_filp_open.ret pid=182858 comm=case4_create_fl ret=fffffffffffffffe
[38322.498983] [trace_case4_create_flow] do_filp_open.entry pid=182858 comm=case4_create_fl dfd=4294967196 pathname=ffff8dda0c847000 op=ffffd0c9407c7c04
[38322.498987] [trace_case4_create_flow] do_filp_open.ret pid=182858 comm=case4_create_fl ret=fffffffffffffffe
[38322.498990] [trace_case4_create_flow] do_filp_open.entry pid=182858 comm=case4_create_fl dfd=4294967196 pathname=ffff8dda0c847000 op=ffffd0c9407c7c74
[38322.498994] [trace_case4_create_flow] do_filp_open.ret pid=182858 comm=case4_create_fl ret=fffffffffffffffe
[38322.498997] [trace_case4_create_flow] do_filp_open.entry pid=182858 comm=case4_create_fl dfd=4294967196 pathname=ffff8dda0c847000 op=ffffd0c9407c7e84
[38322.499002] [trace_case4_create_flow] do_filp_open.ret pid=182858 comm=case4_create_fl ret=ffff8dda03bdd480
[38322.499023] [trace_case4_create_flow] do_filp_open.entry pid=182858 comm=case4_create_fl dfd=4294967196 pathname=ffff8dda0c847000 op=ffffd0c9407c7b44
[38322.499029] [trace_case4_create_flow] do_filp_open.ret pid=182858 comm=case4_create_fl ret=ffff8dda03bdd300
[38322.499245] [trace_case4_create_flow] do_filp_open.entry pid=182858 comm=case4_create_fl dfd=4294967196 pathname=ffff8dda0c847000 op=ffffd0c9407c7da4
[38322.499252] [trace_case4_create_flow] do_filp_open.ret pid=182858 comm=case4_create_fl ret=ffff8dda03bdd480
[38327.498985] [trace_case4_create_flow] do_filp_open.entry pid=182858 comm=case4_create_fl dfd=4294967196 pathname=ffff8dda0c847000 op=ffffd0c9407c7b14
[38327.499018] [trace_case4_create_flow] do_filp_open.ret pid=182858 comm=case4_create_fl ret=ffff8dda08458780
<!-- AUTO-EMBED END -->
