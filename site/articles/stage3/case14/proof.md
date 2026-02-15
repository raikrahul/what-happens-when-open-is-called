---
layout: default
title: "Stage 3 CASE14: Proof"
---
[PROOF CHECKLIST]
1. Claim -> Evidence line -> Pass/Fail.
2. Reproduction command list.
3. Counterexample path.
4. Closure check: no orphan claim.

[PRIMARY REPORT LINKS]
- [user_symmetry_break_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case14_symmetry_break/reports/user_symmetry_break_trace_report.md)

[PRIMARY DMESG LINKS]
- [user_symmetry_break_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case14_symmetry_break/reports/user_symmetry_break_dmesg.txt)

[SECONDARY PROOF INPUTS]
- worksheet index: [STAGE3_WORKSHEET_INDEX](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_WORKSHEET_INDEX.md)
- axiom index: [STAGE3_AXIOM_WORKSHEET_INDEX](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_AXIOM_WORKSHEET_INDEX.md)
- hard index: [STAGE3_AXIOM_HARD_WORKSHEET_INDEX](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_AXIOM_HARD_WORKSHEET_INDEX.md)

<!-- AUTO-EMBED START -->
[AUTO] case=case14

[USERDIR] kernel/user/stage3/case14_symmetry_break

================================================================================
[EMBED] user_symmetry_break_trace_report.md
[SOURCE] kernel/user/stage3/case14_symmetry_break/reports/user_symmetry_break_trace_report.md
================================================================================
# Trace Report: user_symmetry_break.c

- Userspace source: `kernel/user/stage3/case14_symmetry_break/user_symmetry_break.c`
- Driver source: `kernel/drivers/stage3/case14_symmetry_break/trace_user_symmetry_break/trace_user_symmetry_break.c`
- Module: `trace_user_symmetry_break`
- Binary: `kernel/user/stage3/case14_symmetry_break/user_symmetry_break`
- Run timestamp: `2026-02-15T23:32:10`
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
make -C kernel/drivers/stage3/case14_symmetry_break/trace_user_symmetry_break
kernel/user/stage3/case14_symmetry_break/user_symmetry_break
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case14_symmetry_break/trace_user_symmetry_break/trace_user_symmetry_break.ko target_comm="user_symmetry_b"
sudo rmmod trace_user_symmetry_break
```

## Dmesg
`kernel/user/stage3/case14_symmetry_break/reports/user_symmetry_break_dmesg.txt`

================================================================================
[EMBED] user_symmetry_break_dmesg.txt
[SOURCE] kernel/user/stage3/case14_symmetry_break/reports/user_symmetry_break_dmesg.txt
================================================================================
[38311.131346] [trace_user_symmetry_break] loaded target_comm=user_symmetry_b user=kernel/user/stage3/case14_symmetry_break/user_symmetry_break.c
[38311.134777] [trace_user_symmetry_break] do_filp_open.entry pid=180304 comm=user_symmetry_b dfd=4294967196 pathname=ffff8dda294d3000 op=ffffd0c9407a3c24
[38311.134790] [trace_user_symmetry_break] do_filp_open.ret pid=180304 comm=user_symmetry_b ret=fffffffffffffffe
[38311.134796] [trace_user_symmetry_break] do_filp_open.entry pid=180304 comm=user_symmetry_b dfd=4294967196 pathname=ffff8dda294d3000 op=ffffd0c9407a3af4
[38311.134801] [trace_user_symmetry_break] do_filp_open.ret pid=180304 comm=user_symmetry_b ret=fffffffffffffffe
[38311.134806] [trace_user_symmetry_break] do_filp_open.entry pid=180304 comm=user_symmetry_b dfd=4294967196 pathname=ffff8dda294d3000 op=ffffd0c9407a3ca4
[38311.134811] [trace_user_symmetry_break] do_filp_open.ret pid=180304 comm=user_symmetry_b ret=fffffffffffffffe
[38311.134818] [trace_user_symmetry_break] do_filp_open.entry pid=180304 comm=user_symmetry_b dfd=4294967196 pathname=ffff8dda294d3000 op=ffffd0c9407a3ba4
[38311.134822] [trace_user_symmetry_break] do_filp_open.ret pid=180304 comm=user_symmetry_b ret=fffffffffffffffe
[38311.134825] [trace_user_symmetry_break] do_filp_open.entry pid=180304 comm=user_symmetry_b dfd=4294967196 pathname=ffff8dda294d3000 op=ffffd0c9407a3e64
[38311.134828] [trace_user_symmetry_break] do_filp_open.ret pid=180304 comm=user_symmetry_b ret=fffffffffffffffe
[38311.134831] [trace_user_symmetry_break] do_filp_open.entry pid=180304 comm=user_symmetry_b dfd=4294967196 pathname=ffff8dda294d3000 op=ffffd0c9407a3cb4
[38311.134834] [trace_user_symmetry_break] do_filp_open.ret pid=180304 comm=user_symmetry_b ret=fffffffffffffffe
[38311.134838] [trace_user_symmetry_break] do_filp_open.entry pid=180304 comm=user_symmetry_b dfd=4294967196 pathname=ffff8dda294d3000 op=ffffd0c9407a3ae4
[38311.134842] [trace_user_symmetry_break] do_filp_open.ret pid=180304 comm=user_symmetry_b ret=ffff8dda04ae9480
[38311.134862] [trace_user_symmetry_break] do_filp_open.entry pid=180304 comm=user_symmetry_b dfd=4294967196 pathname=ffff8dda294d3000 op=ffffd0c9407a3cb4
[38311.134866] [trace_user_symmetry_break] do_filp_open.ret pid=180304 comm=user_symmetry_b ret=ffff8dda04ae9540
[38311.135057] [trace_user_symmetry_break] do_filp_open.entry pid=180304 comm=user_symmetry_b dfd=4294967196 pathname=ffff8dda294d3000 op=ffffd0c9407a3b44
[38311.135064] [trace_user_symmetry_break] do_filp_open.ret pid=180304 comm=user_symmetry_b ret=ffff8dda04ae9480
[38311.135069] [trace_user_symmetry_break] do_filp_open.entry pid=180304 comm=user_symmetry_b dfd=4294967196 pathname=ffff8dda294d3000 op=ffffd0c9407a3d44
[38311.135073] [trace_user_symmetry_break] do_filp_open.ret pid=180304 comm=user_symmetry_b ret=ffff8dda04ae9480
<!-- AUTO-EMBED END -->
