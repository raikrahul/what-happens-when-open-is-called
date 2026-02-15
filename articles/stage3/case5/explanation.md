---
layout: default
title: "Stage 3 CASE5: Explanation"
---
[CASE]
- id: case5
- title: Mount Jump
- userspace root: [kernel/user/stage3/case5_mount_jump](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case5_mount_jump)
- driver root: [kernel/drivers/stage3/case5_mount_jump](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case5_mount_jump)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Mount Jump.

[REPORT ARTIFACTS]
- [case5_mount_jump_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case5_mount_jump/reports/case5_mount_jump_trace_report.md)

[RAW LOG ARTIFACTS]
- [case5_mount_jump_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case5_mount_jump/reports/case5_mount_jump_dmesg.txt)

<!-- AUTO-EMBED START -->
[AUTO] case=case5

[FOLDER] case5_mount_jump
[INTENT] mount traversal
[BASELINE_PROBES] do_sys_openat2;do_filp_open;path_openat;lookup_open;__d_alloc
[EXTRA_PROBES] follow_managed;handle_mounts;path_lookupat;link_path_walk
[EXPECTED_SIGNATURES] mount crossing observed

================================================================================
[EMBED] case5_mount_jump_trace_report.md (primary)
[SOURCE] kernel/user/stage3/case5_mount_jump/reports/case5_mount_jump_trace_report.md
================================================================================
# Trace Report: case5_mount_jump.c

- Userspace source: `kernel/user/stage3/case5_mount_jump/case5_mount_jump.c`
- Driver source: `kernel/drivers/stage3/case5_mount_jump/trace_case5_mount_jump/trace_case5_mount_jump.c`
- Module: `trace_case5_mount_jump`
- Binary: `kernel/user/stage3/case5_mount_jump/case5_mount_jump`
- Run timestamp: `2026-02-15T23:32:27`
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
make -C kernel/drivers/stage3/case5_mount_jump/trace_case5_mount_jump
kernel/user/stage3/case5_mount_jump/case5_mount_jump
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case5_mount_jump/trace_case5_mount_jump/trace_case5_mount_jump.ko target_comm="case5_mount_jum"
sudo rmmod trace_case5_mount_jump
```

## Dmesg
`kernel/user/stage3/case5_mount_jump/reports/case5_mount_jump_dmesg.txt`

================================================================================
[EMBED] case5_mount_jump_dmesg.txt (primary)
[SOURCE] kernel/user/stage3/case5_mount_jump/reports/case5_mount_jump_dmesg.txt
================================================================================
[38328.727418] [trace_case5_mount_jump] loaded target_comm=case5_mount_jum user=kernel/user/stage3/case5_mount_jump/case5_mount_jump.c
[38328.731477] [trace_case5_mount_jump] do_filp_open.entry pid=183149 comm=case5_mount_jum dfd=4294967196 pathname=ffff8dda0a2d0000 op=ffffd0c941e13bd4
[38328.731503] [trace_case5_mount_jump] do_filp_open.ret pid=183149 comm=case5_mount_jum ret=fffffffffffffffe
[38328.731521] [trace_case5_mount_jump] do_filp_open.entry pid=183149 comm=case5_mount_jum dfd=4294967196 pathname=ffff8dda0a2d0000 op=ffffd0c941e13e54
[38328.731535] [trace_case5_mount_jump] do_filp_open.ret pid=183149 comm=case5_mount_jum ret=fffffffffffffffe
[38328.731550] [trace_case5_mount_jump] do_filp_open.entry pid=183149 comm=case5_mount_jum dfd=4294967196 pathname=ffff8dda0a2d0000 op=ffffd0c941e13ab4
[38328.731564] [trace_case5_mount_jump] do_filp_open.ret pid=183149 comm=case5_mount_jum ret=fffffffffffffffe
[38328.731605] [trace_case5_mount_jump] do_filp_open.entry pid=183149 comm=case5_mount_jum dfd=4294967196 pathname=ffff8dda0a2d0000 op=ffffd0c941e13e74
[38328.731617] [trace_case5_mount_jump] do_filp_open.ret pid=183149 comm=case5_mount_jum ret=fffffffffffffffe
[38328.731627] [trace_case5_mount_jump] do_filp_open.entry pid=183149 comm=case5_mount_jum dfd=4294967196 pathname=ffff8dda0a2d0000 op=ffffd0c941e13e34
[38328.731637] [trace_case5_mount_jump] do_filp_open.ret pid=183149 comm=case5_mount_jum ret=fffffffffffffffe
[38328.731645] [trace_case5_mount_jump] do_filp_open.entry pid=183149 comm=case5_mount_jum dfd=4294967196 pathname=ffff8dda0a2d0000 op=ffffd0c941e13dd4
[38328.731655] [trace_case5_mount_jump] do_filp_open.ret pid=183149 comm=case5_mount_jum ret=fffffffffffffffe
[38328.731665] [trace_case5_mount_jump] do_filp_open.entry pid=183149 comm=case5_mount_jum dfd=4294967196 pathname=ffff8dda0a2d0000 op=ffffd0c941e13e74
[38328.731678] [trace_case5_mount_jump] do_filp_open.ret pid=183149 comm=case5_mount_jum ret=ffff8dd904158b40
[38328.731727] [trace_case5_mount_jump] do_filp_open.entry pid=183149 comm=case5_mount_jum dfd=4294967196 pathname=ffff8dda0a2d0000 op=ffffd0c941e13b44
[38328.731740] [trace_case5_mount_jump] do_filp_open.ret pid=183149 comm=case5_mount_jum ret=ffff8dd904158300
[38328.732221] [trace_case5_mount_jump] do_filp_open.entry pid=183149 comm=case5_mount_jum dfd=4294967196 pathname=ffff8dda0a2d0000 op=ffffd0c941e13c54
[38328.732235] [trace_case5_mount_jump] do_filp_open.ret pid=183149 comm=case5_mount_jum ret=fffffffffffffffe
<!-- AUTO-EMBED END -->
