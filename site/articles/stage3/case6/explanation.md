---
layout: default
title: "Stage 3 CASE6: Explanation"
---
[CASE]
- id: case6
- title: Symlink Loop
- userspace root: [kernel/user/stage3/case6_symlink_loop](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case6_symlink_loop)
- driver root: [kernel/drivers/stage3/case6_symlink_loop](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case6_symlink_loop)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Symlink Loop.

[REPORT ARTIFACTS]
- [case6_symlink_loop_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case6_symlink_loop/reports/case6_symlink_loop_trace_report.md)

[RAW LOG ARTIFACTS]
- [case6_symlink_loop_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case6_symlink_loop/reports/case6_symlink_loop_dmesg.txt)

<!-- AUTO-EMBED START -->
[AUTO] case=case6

[FOLDER] case6_symlink_loop
[INTENT] symlink loop error
[BASELINE_PROBES] do_sys_openat2;do_filp_open;path_openat;lookup_open;__d_alloc
[EXTRA_PROBES] pick_link;trailing_symlink;link_path_walk
[EXPECTED_SIGNATURES] ELOOP

================================================================================
[EMBED] case6_symlink_loop_trace_report.md (primary)
[SOURCE] kernel/user/stage3/case6_symlink_loop/reports/case6_symlink_loop_trace_report.md
================================================================================
# Trace Report: case6_symlink_loop.c

- Userspace source: `kernel/user/stage3/case6_symlink_loop/case6_symlink_loop.c`
- Driver source: `kernel/drivers/stage3/case6_symlink_loop/trace_case6_symlink_loop/trace_case6_symlink_loop.c`
- Module: `trace_case6_symlink_loop`
- Binary: `kernel/user/stage3/case6_symlink_loop/case6_symlink_loop`
- Run timestamp: `2026-02-15T23:32:28`
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
make -C kernel/drivers/stage3/case6_symlink_loop/trace_case6_symlink_loop
kernel/user/stage3/case6_symlink_loop/case6_symlink_loop
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case6_symlink_loop/trace_case6_symlink_loop/trace_case6_symlink_loop.ko target_comm="case6_symlink_l"
sudo rmmod trace_case6_symlink_loop
```

## Dmesg
`kernel/user/stage3/case6_symlink_loop/reports/case6_symlink_loop_dmesg.txt`

================================================================================
[EMBED] case6_symlink_loop_dmesg.txt (primary)
[SOURCE] kernel/user/stage3/case6_symlink_loop/reports/case6_symlink_loop_dmesg.txt
================================================================================
[38329.942543] [trace_case6_symlink_loop] loaded target_comm=case6_symlink_l user=kernel/user/stage3/case6_symlink_loop/case6_symlink_loop.c
[38329.946161] [trace_case6_symlink_loop] do_filp_open.entry pid=183405 comm=case6_symlink_l dfd=4294967196 pathname=ffff8dda0fe6d000 op=ffffd0c9407c7dd4
[38329.946183] [trace_case6_symlink_loop] do_filp_open.ret pid=183405 comm=case6_symlink_l ret=fffffffffffffffe
[38329.946197] [trace_case6_symlink_loop] do_filp_open.entry pid=183405 comm=case6_symlink_l dfd=4294967196 pathname=ffff8dda0fe6d000 op=ffffd0c9407c7d84
[38329.946208] [trace_case6_symlink_loop] do_filp_open.ret pid=183405 comm=case6_symlink_l ret=fffffffffffffffe
[38329.946220] [trace_case6_symlink_loop] do_filp_open.entry pid=183405 comm=case6_symlink_l dfd=4294967196 pathname=ffff8dda0fe6d000 op=ffffd0c9407c7c74
[38329.946231] [trace_case6_symlink_loop] do_filp_open.ret pid=183405 comm=case6_symlink_l ret=fffffffffffffffe
[38329.946246] [trace_case6_symlink_loop] do_filp_open.entry pid=183405 comm=case6_symlink_l dfd=4294967196 pathname=ffff8dda0fe6d000 op=ffffd0c9407c7c74
[38329.946253] [trace_case6_symlink_loop] do_filp_open.ret pid=183405 comm=case6_symlink_l ret=fffffffffffffffe
[38329.946260] [trace_case6_symlink_loop] do_filp_open.entry pid=183405 comm=case6_symlink_l dfd=4294967196 pathname=ffff8dda0fe6d000 op=ffffd0c9407c7cc4
[38329.946268] [trace_case6_symlink_loop] do_filp_open.ret pid=183405 comm=case6_symlink_l ret=fffffffffffffffe
[38329.946274] [trace_case6_symlink_loop] do_filp_open.entry pid=183405 comm=case6_symlink_l dfd=4294967196 pathname=ffff8dda0fe6d000 op=ffffd0c9407c7d34
[38329.946282] [trace_case6_symlink_loop] do_filp_open.ret pid=183405 comm=case6_symlink_l ret=fffffffffffffffe
[38329.946289] [trace_case6_symlink_loop] do_filp_open.entry pid=183405 comm=case6_symlink_l dfd=4294967196 pathname=ffff8dda0fe6d000 op=ffffd0c9407c7b94
[38329.946299] [trace_case6_symlink_loop] do_filp_open.ret pid=183405 comm=case6_symlink_l ret=ffff8dda38037240
[38329.946336] [trace_case6_symlink_loop] do_filp_open.entry pid=183405 comm=case6_symlink_l dfd=4294967196 pathname=ffff8dda0fe6d000 op=ffffd0c9407c7cf4
[38329.946346] [trace_case6_symlink_loop] do_filp_open.ret pid=183405 comm=case6_symlink_l ret=ffff8dda38037f00
[38329.946803] [trace_case6_symlink_loop] do_filp_open.entry pid=183405 comm=case6_symlink_l dfd=4294967196 pathname=ffff8dda0fe6d000 op=ffffd0c9407c7d24
[38329.946819] [trace_case6_symlink_loop] do_filp_open.ret pid=183405 comm=case6_symlink_l ret=fffffffffffffffe
<!-- AUTO-EMBED END -->
