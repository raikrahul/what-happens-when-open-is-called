---
layout: default
title: "Stage 3 CASE10: Worksheet"
---
[WORKSHEET BASE]
- [user_dir_rename_worksheet.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case10_rename_investigation/worksheets/user_dir_rename_worksheet.md)

[WORKSHEET AXIOM]
- [user_dir_rename_worksheet_axiom.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case10_rename_investigation/worksheets/user_dir_rename_worksheet_axiom.md)

[WORKSHEET AXIOM HARD]
- [user_dir_rename_worksheet_axiom_hard.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case10_rename_investigation/worksheets/user_dir_rename_worksheet_axiom_hard.md)

[REQUIRED HAND TASKS]
1. Verify entry/ret pair counts.
2. Verify pointer class counts.
3. Record contradiction lines and expected fixes.
4. Cross-compare with one adjacent case.

<!-- AUTO-EMBED START -->
[AUTO] case=case10

[USERDIR] kernel/user/stage3/case10_rename_investigation

================================================================================
[EMBED] user_dir_rename_worksheet.md
[SOURCE] kernel/user/stage3/case10_rename_investigation/worksheets/user_dir_rename_worksheet.md
================================================================================
# Worksheet: user_dir_rename

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case10_rename_investigation/user_dir_rename.c`
- Driver: `kernel/drivers/stage3/case10_rename_investigation/trace_user_dir_rename/trace_user_dir_rename.c`
- Module: `trace_user_dir_rename`
- Binary: `kernel/user/stage3/case10_rename_investigation/user_dir_rename.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 8
- `do_filp_open.ret`: 8
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53089.005184] [trace_user_dir_rename] do_filp_open.entry pid=266248 comm=user_dir_rename dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc970235fb94`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53089.005206] [trace_user_dir_rename] do_filp_open.ret pid=266248 comm=user_dir_rename ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53089.005213] [trace_user_dir_rename] do_filp_open.entry pid=266248 comm=user_dir_rename dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc970235fac4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53089.005218] [trace_user_dir_rename] do_filp_open.ret pid=266248 comm=user_dir_rename ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53089.005223] [trace_user_dir_rename] do_filp_open.entry pid=266248 comm=user_dir_rename dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc970235fdc4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53089.005228] [trace_user_dir_rename] do_filp_open.ret pid=266248 comm=user_dir_rename ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53089.005236] [trace_user_dir_rename] do_filp_open.entry pid=266248 comm=user_dir_rename dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc970235fc94`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53089.005240] [trace_user_dir_rename] do_filp_open.ret pid=266248 comm=user_dir_rename ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53089.005243] [trace_user_dir_rename] do_filp_open.entry pid=266248 comm=user_dir_rename dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc970235fd34`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53089.005246] [trace_user_dir_rename] do_filp_open.ret pid=266248 comm=user_dir_rename ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53089.005249] [trace_user_dir_rename] do_filp_open.entry pid=266248 comm=user_dir_rename dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc970235fc54`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53089.005253] [trace_user_dir_rename] do_filp_open.ret pid=266248 comm=user_dir_rename ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53089.005257] [trace_user_dir_rename] do_filp_open.entry pid=266248 comm=user_dir_rename dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc970235fe34`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53089.005262] [trace_user_dir_rename] do_filp_open.ret pid=266248 comm=user_dir_rename ret=ffff898ebd38e540`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53089.005286] [trace_user_dir_rename] do_filp_open.entry pid=266248 comm=user_dir_rename dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc970235fac4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53089.005292] [trace_user_dir_rename] do_filp_open.ret pid=266248 comm=user_dir_rename ret=ffff898ebd38e840`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=8 ret=8
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case10_rename_investigation/reports/user_dir_rename_trace_report.md`
- dmesg: `kernel/user/stage3/case10_rename_investigation/reports/user_dir_rename_dmesg.txt`
<!-- AUTO-EMBED END -->
