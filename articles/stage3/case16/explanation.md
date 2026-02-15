---
layout: default
title: "Stage 3 CASE16: Explanation"
---
[CASE]
- id: case16
- title: filp_open + sys_openat2
- userspace root: [kernel/user/stage3/case16_do_filp_open_trace](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace)
- driver root: [kernel/drivers/stage3/case16_do_filp_open_trace](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case16_do_filp_open_trace)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for filp_open + sys_openat2.

[REPORT ARTIFACTS]
- [user_trigger_exists_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_trace_report.md)
- [user_trigger_missing_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_trace_report.md)

[RAW LOG ARTIFACTS]
- [user_trigger_exists_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_dmesg.txt)
- [user_trigger_missing_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_dmesg.txt)

<!-- AUTO-EMBED START -->
[AUTO] case=case16

[FOLDER] case16_do_filp_open_trace
[INTENT] do_filp_open focus
[BASELINE_PROBES] do_sys_openat2;do_filp_open;path_openat;lookup_open;__d_alloc
[EXTRA_PROBES] alloc_empty_file;path_openat;do_open;fput_close;do_filp_open
[EXPECTED_SIGNATURES] ERR_PTR on fail;fput_close on error

================================================================================
[EMBED] user_trigger_exists_trace_report.md (primary)
[SOURCE] kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_trace_report.md
================================================================================
# Trace Report: user_trigger_exists.c

- Userspace source: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists.c`
- Driver source: `kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_exists/trace_user_trigger_exists.c`
- Module: `trace_user_trigger_exists`
- Binary: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists`
- Run timestamp: `2026-02-15T23:32:13`
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
make -C kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_exists
kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_exists/trace_user_trigger_exists.ko target_comm="user_trigger_ex"
sudo rmmod trace_user_trigger_exists
```

## Dmesg
`kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_dmesg.txt`

================================================================================
[EMBED] user_trigger_exists_dmesg.txt (primary)
[SOURCE] kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_dmesg.txt
================================================================================
[38314.577865] [trace_user_trigger_exists] loaded target_comm=user_trigger_ex user=kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists.c
[38314.581402] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bcb4
[38314.581436] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=fffffffffffffffe
[38314.581454] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bd64
[38314.581468] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=fffffffffffffffe
[38314.581485] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bc24
[38314.581502] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=fffffffffffffffe
[38314.581524] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bbe4
[38314.581536] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=fffffffffffffffe
[38314.581546] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bb14
[38314.581557] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=fffffffffffffffe
[38314.581568] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bdb4
[38314.581579] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=fffffffffffffffe
[38314.581591] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bbe4
[38314.581605] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=ffff8ddc288733c0
[38314.581651] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bc14
[38314.581664] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=ffff8ddc28873d80
[38314.582117] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bd64
[38314.582136] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=ffff8ddc288733c0
[38314.582221] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bcd4
[38314.582233] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=ffff8ddc288733c0

[FOLDER] case16_do_sys_openat2_trace
[INTENT] syscall front-door focus
[BASELINE_PROBES] do_sys_openat2;do_filp_open;path_openat;lookup_open;__d_alloc
[EXTRA_PROBES] build_open_flags;getname;get_unused_fd_flags;do_filp_open;fd_install;putname
[EXPECTED_SIGNATURES] fd install only on success

================================================================================
[EMBED] user_trigger_trace_report.md (primary)
[SOURCE] kernel/user/stage3/case16_do_sys_openat2_trace/reports/user_trigger_trace_report.md
================================================================================
# Trace Report: user_trigger.c

- Userspace source: `kernel/user/stage3/case16_do_sys_openat2_trace/user_trigger.c`
- Driver source: `kernel/drivers/stage3/case16_do_sys_openat2_trace/trace_user_trigger/trace_user_trigger.c`
- Module: `trace_user_trigger`
- Binary: `kernel/user/stage3/case16_do_sys_openat2_trace/user_trigger`
- Run timestamp: `2026-02-15T23:32:15`
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
make -C kernel/drivers/stage3/case16_do_sys_openat2_trace/trace_user_trigger
kernel/user/stage3/case16_do_sys_openat2_trace/user_trigger
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case16_do_sys_openat2_trace/trace_user_trigger/trace_user_trigger.ko target_comm="user_trigger"
sudo rmmod trace_user_trigger
```

## Dmesg
`kernel/user/stage3/case16_do_sys_openat2_trace/reports/user_trigger_dmesg.txt`

================================================================================
[EMBED] user_trigger_dmesg.txt (primary)
[SOURCE] kernel/user/stage3/case16_do_sys_openat2_trace/reports/user_trigger_dmesg.txt
================================================================================
[38316.753785] [trace_user_trigger] loaded target_comm=user_trigger user=kernel/user/stage3/case16_do_sys_openat2_trace/user_trigger.c
[38316.756383] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3bba4
[38316.756396] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=fffffffffffffffe
[38316.756402] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3bdd4
[38316.756407] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=fffffffffffffffe
[38316.756413] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3bcf4
[38316.756418] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=fffffffffffffffe
[38316.756425] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3be34
[38316.756428] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=fffffffffffffffe
[38316.756431] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3bb34
[38316.756434] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=fffffffffffffffe
[38316.756437] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3bc44
[38316.756441] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=fffffffffffffffe
[38316.756444] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3be44
[38316.756449] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=ffff8ddc220af180
[38316.756467] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3bcc4
[38316.756472] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=ffff8ddc220afb40
[38316.756673] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3ba9c
[38316.756679] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=fffffffffffffffe
<!-- AUTO-EMBED END -->
