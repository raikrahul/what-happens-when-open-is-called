---
layout: default
title: "Stage 3 CASE7: Worksheet"
---
[WORKSHEET BASE]
- [case7_symlink_fast_worksheet.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case7_symlink_fast/worksheets/case7_symlink_fast_worksheet.md)

[WORKSHEET AXIOM]
- [case7_symlink_fast_worksheet_axiom.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case7_symlink_fast/worksheets/case7_symlink_fast_worksheet_axiom.md)

[WORKSHEET AXIOM HARD]
- [case7_symlink_fast_worksheet_axiom_hard.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case7_symlink_fast/worksheets/case7_symlink_fast_worksheet_axiom_hard.md)

[REQUIRED HAND TASKS]
1. Verify entry/ret pair counts.
2. Verify pointer class counts.
3. Record contradiction lines and expected fixes.
4. Cross-compare with one adjacent case.

<!-- AUTO-EMBED START -->
[AUTO] case=case7

[USERDIR] kernel/user/stage3/case7_symlink_fast

================================================================================
[EMBED] case7_symlink_fast_worksheet.md
[SOURCE] kernel/user/stage3/case7_symlink_fast/worksheets/case7_symlink_fast_worksheet.md
================================================================================
# Worksheet: case7_symlink_fast

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case7_symlink_fast/case7_symlink_fast.c`
- Driver: `kernel/drivers/stage3/case7_symlink_fast/trace_case7_symlink_fast/trace_case7_symlink_fast.c`
- Module: `trace_case7_symlink_fast`
- Binary: `kernel/user/stage3/case7_symlink_fast/case7_symlink_fast.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 7
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53114.346712] [trace_case7_symlink_fast] do_filp_open.entry pid=271044 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9702433ba4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53114.346734] [trace_case7_symlink_fast] do_filp_open.ret pid=271044 comm=case7_symlink_f ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53114.346749] [trace_case7_symlink_fast] do_filp_open.entry pid=271044 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9702433e14`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53114.346760] [trace_case7_symlink_fast] do_filp_open.ret pid=271044 comm=case7_symlink_f ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53114.346773] [trace_case7_symlink_fast] do_filp_open.entry pid=271044 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9702433a94`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53114.346784] [trace_case7_symlink_fast] do_filp_open.ret pid=271044 comm=case7_symlink_f ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53114.346800] [trace_case7_symlink_fast] do_filp_open.entry pid=271044 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9702433d94`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53114.346808] [trace_case7_symlink_fast] do_filp_open.ret pid=271044 comm=case7_symlink_f ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53114.346815] [trace_case7_symlink_fast] do_filp_open.entry pid=271044 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9702433ab4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53114.346823] [trace_case7_symlink_fast] do_filp_open.ret pid=271044 comm=case7_symlink_f ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53114.346830] [trace_case7_symlink_fast] do_filp_open.entry pid=271044 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9702433c64`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53114.346838] [trace_case7_symlink_fast] do_filp_open.ret pid=271044 comm=case7_symlink_f ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53114.346845] [trace_case7_symlink_fast] do_filp_open.entry pid=271044 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9702433d84`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53114.346856] [trace_case7_symlink_fast] do_filp_open.ret pid=271044 comm=case7_symlink_f ret=ffff898fe26d33c0`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53114.346937] [trace_case7_symlink_fast] do_filp_open.entry pid=271044 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9702433dc4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53114.346952] [trace_case7_symlink_fast] do_filp_open.ret pid=271044 comm=case7_symlink_f ret=ffff898ebe5ddcc0`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53114.347484] [trace_case7_symlink_fast] do_filp_open.entry pid=271044 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9702433ad4`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53114.347500] [trace_case7_symlink_fast] do_filp_open.ret pid=271044 comm=case7_symlink_f ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case7_symlink_fast/reports/case7_symlink_fast_trace_report.md`
- dmesg: `kernel/user/stage3/case7_symlink_fast/reports/case7_symlink_fast_dmesg.txt`
<!-- AUTO-EMBED END -->
