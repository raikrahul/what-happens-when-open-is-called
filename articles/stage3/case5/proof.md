---
layout: default
title: "Stage 3 CASE5: Proof"
---
[PROOF CHECKLIST]
1. Claim -> Evidence line -> Pass/Fail.
2. Reproduction command list.
3. Counterexample path.
4. Closure check: no orphan claim.

[PRIMARY REPORT LINKS]
- [case5_mount_jump_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case5_mount_jump/reports/case5_mount_jump_trace_report.md)

[PRIMARY DMESG LINKS]
- [case5_mount_jump_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case5_mount_jump/reports/case5_mount_jump_dmesg.txt)

[SECONDARY PROOF INPUTS]
- worksheet index: [STAGE3_WORKSHEET_INDEX](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_WORKSHEET_INDEX.md)
- axiom index: [STAGE3_AXIOM_WORKSHEET_INDEX](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_AXIOM_WORKSHEET_INDEX.md)
- hard index: [STAGE3_AXIOM_HARD_WORKSHEET_INDEX](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_AXIOM_HARD_WORKSHEET_INDEX.md)

<!-- AUTO-EMBED START -->
[AUTO] case=case5

[USERDIR] kernel/user/stage3/case5_mount_jump

================================================================================
[EMBED] case5_mount_jump_trace_report.md
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
[EMBED] case5_mount_jump_dmesg.txt
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
