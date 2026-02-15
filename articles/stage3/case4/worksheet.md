---
layout: default
title: "Stage 3 CASE4: Worksheet"
---
[WORKSHEET BASE]
- [case4_create_flow_worksheet.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case4_create_flow/worksheets/case4_create_flow_worksheet.md)

[WORKSHEET AXIOM]
- [case4_create_flow_worksheet_axiom.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case4_create_flow/worksheets/case4_create_flow_worksheet_axiom.md)

[WORKSHEET AXIOM HARD]
- [case4_create_flow_worksheet_axiom_hard.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case4_create_flow/worksheets/case4_create_flow_worksheet_axiom_hard.md)

[REQUIRED HAND TASKS]
1. Verify entry/ret pair counts.
2. Verify pointer class counts.
3. Record contradiction lines and expected fixes.
4. Cross-compare with one adjacent case.

<!-- AUTO-EMBED START -->
[AUTO] case=case4

[USERDIR] kernel/user/stage3/case4_create_flow

================================================================================
[EMBED] case4_create_flow_worksheet.md
[SOURCE] kernel/user/stage3/case4_create_flow/worksheets/case4_create_flow_worksheet.md
================================================================================
# Worksheet: case4_create_flow

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case4_create_flow/case4_create_flow.c`
- Driver: `kernel/drivers/stage3/case4_create_flow/trace_case4_create_flow/trace_case4_create_flow.c`
- Module: `trace_case4_create_flow`
- Binary: `kernel/user/stage3/case4_create_flow/case4_create_flow.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 10
- `do_filp_open.ret`: 10
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 4

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53106.007206] [trace_case4_create_flow] do_filp_open.entry pid=270261 comm=case4_create_fl dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc9700fcfc74`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53106.007221] [trace_case4_create_flow] do_filp_open.ret pid=270261 comm=case4_create_fl ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53106.007228] [trace_case4_create_flow] do_filp_open.entry pid=270261 comm=case4_create_fl dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc9700fcfc04`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53106.007233] [trace_case4_create_flow] do_filp_open.ret pid=270261 comm=case4_create_fl ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53106.007238] [trace_case4_create_flow] do_filp_open.entry pid=270261 comm=case4_create_fl dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc9700fcfbf4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53106.007243] [trace_case4_create_flow] do_filp_open.ret pid=270261 comm=case4_create_fl ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53106.007250] [trace_case4_create_flow] do_filp_open.entry pid=270261 comm=case4_create_fl dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc9700fcfb04`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53106.007254] [trace_case4_create_flow] do_filp_open.ret pid=270261 comm=case4_create_fl ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53106.007257] [trace_case4_create_flow] do_filp_open.entry pid=270261 comm=case4_create_fl dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc9700fcfcf4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53106.007260] [trace_case4_create_flow] do_filp_open.ret pid=270261 comm=case4_create_fl ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53106.007263] [trace_case4_create_flow] do_filp_open.entry pid=270261 comm=case4_create_fl dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc9700fcfbe4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53106.007266] [trace_case4_create_flow] do_filp_open.ret pid=270261 comm=case4_create_fl ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53106.007270] [trace_case4_create_flow] do_filp_open.entry pid=270261 comm=case4_create_fl dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc9700fcfe34`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53106.007274] [trace_case4_create_flow] do_filp_open.ret pid=270261 comm=case4_create_fl ret=ffff89909a505300`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53106.007293] [trace_case4_create_flow] do_filp_open.entry pid=270261 comm=case4_create_fl dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc9700fcfac4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53106.007298] [trace_case4_create_flow] do_filp_open.ret pid=270261 comm=case4_create_fl ret=ffff89909a505b40`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53106.007487] [trace_case4_create_flow] do_filp_open.entry pid=270261 comm=case4_create_fl dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc9700fcfc24`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53106.007493] [trace_case4_create_flow] do_filp_open.ret pid=270261 comm=case4_create_fl ret=ffff89909a505300`
- #19. call=`do_filp_open.entry` source_line=`dmesg:20` raw=`[53111.007343] [trace_case4_create_flow] do_filp_open.entry pid=270261 comm=case4_create_fl dfd=4294967196 pathname=ffff898e8d73d000 op=ffffcc9700fcfde4`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53111.007377] [trace_case4_create_flow] do_filp_open.ret pid=270261 comm=case4_create_fl ret=ffff8990cd5619c0`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=10 ret=10
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case4_create_flow/reports/case4_create_flow_trace_report.md`
- dmesg: `kernel/user/stage3/case4_create_flow/reports/case4_create_flow_dmesg.txt`
<!-- AUTO-EMBED END -->
