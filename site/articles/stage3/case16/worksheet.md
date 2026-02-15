---
layout: default
title: "Stage 3 CASE16: Worksheet"
---
[WORKSHEET BASE]
- [user_trigger_exists_worksheet.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/worksheets/user_trigger_exists_worksheet.md)
- [user_trigger_missing_worksheet.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/worksheets/user_trigger_missing_worksheet.md)

[WORKSHEET AXIOM]
- [user_trigger_exists_worksheet_axiom.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/worksheets/user_trigger_exists_worksheet_axiom.md)
- [user_trigger_missing_worksheet_axiom.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/worksheets/user_trigger_missing_worksheet_axiom.md)

[WORKSHEET AXIOM HARD]
- [user_trigger_exists_worksheet_axiom_hard.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/worksheets/user_trigger_exists_worksheet_axiom_hard.md)
- [user_trigger_missing_worksheet_axiom_hard.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/worksheets/user_trigger_missing_worksheet_axiom_hard.md)

[REQUIRED HAND TASKS]
1. Verify entry/ret pair counts.
2. Verify pointer class counts.
3. Record contradiction lines and expected fixes.
4. Cross-compare with one adjacent case.

<!-- AUTO-EMBED START -->
[AUTO] case=case16

[USERDIR] kernel/user/stage3/case16_do_filp_open_trace

================================================================================
[EMBED] user_trigger_exists_worksheet.md
[SOURCE] kernel/user/stage3/case16_do_filp_open_trace/worksheets/user_trigger_exists_worksheet.md
================================================================================
# Worksheet: user_trigger_exists

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists.c`
- Driver: `kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_exists/trace_user_trigger_exists.c`
- Module: `trace_user_trigger_exists`
- Binary: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 10
- `do_filp_open.ret`: 10
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 4

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53097.932232] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fb44`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53097.932245] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53097.932251] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fae4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53097.932256] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53097.932262] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fc74`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53097.932266] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53097.932273] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fdd4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53097.932277] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53097.932280] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fc44`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53097.932283] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53097.932286] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fb04`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53097.932290] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53097.932293] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fcf4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53097.932298] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=ffff898eb8d03a80`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53097.932315] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fbc4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53097.932320] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=ffff898eb8d03f00`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53097.932503] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fe64`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53097.932511] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=ffff898eb8d03a80`
- #19. call=`do_filp_open.entry` source_line=`dmesg:20` raw=`[53097.932558] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fbe4`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53097.932563] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=ffff898eb8d03a80`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=10 ret=10
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_trace_report.md`
- dmesg: `kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_dmesg.txt`

================================================================================
[EMBED] user_trigger_missing_worksheet.md
[SOURCE] kernel/user/stage3/case16_do_filp_open_trace/worksheets/user_trigger_missing_worksheet.md
================================================================================
# Worksheet: user_trigger_missing

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_missing.c`
- Driver: `kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_missing/trace_user_trigger_missing.c`
- Module: `trace_user_trigger_missing`
- Binary: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_missing`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 7
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53099.124978] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783bf4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53099.125000] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53099.125013] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783da4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53099.125025] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53099.125037] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783d14`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53099.125048] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53099.125062] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783c54`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53099.125070] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53099.125077] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783b84`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53099.125084] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53099.125091] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783db4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53099.125099] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53099.125106] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783e54`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53099.125121] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=ffff898ea5f3d600`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53099.125160] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783b84`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53099.125171] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=ffff898ea5f3dc00`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53099.125809] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783cf4`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53099.125832] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_trace_report.md`
- dmesg: `kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_dmesg.txt`

[USERDIR] kernel/user/stage3/case16_do_sys_openat2_trace

================================================================================
[EMBED] user_trigger_worksheet.md
[SOURCE] kernel/user/stage3/case16_do_sys_openat2_trace/worksheets/user_trigger_worksheet.md
================================================================================
# Worksheet: user_trigger

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case16_do_sys_openat2_trace/user_trigger.c`
- Driver: `kernel/drivers/stage3/case16_do_sys_openat2_trace/trace_user_trigger/trace_user_trigger.c`
- Module: `trace_user_trigger`
- Binary: `kernel/user/stage3/case16_do_sys_openat2_trace/user_trigger`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 7
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53100.273583] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3c04`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53100.273604] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53100.273618] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3be4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53100.273629] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53100.273641] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3bf4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53100.273652] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53100.273666] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3af4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53100.273674] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53100.273681] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3da4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53100.273688] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53100.273695] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3c94`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53100.273702] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53100.273709] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3e24`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53100.273719] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=ffff89901398b000`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53100.273758] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3d94`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53100.273769] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=ffff89901398b900`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53100.274160] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3b5c`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53100.274170] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case16_do_sys_openat2_trace/reports/user_trigger_trace_report.md`
- dmesg: `kernel/user/stage3/case16_do_sys_openat2_trace/reports/user_trigger_dmesg.txt`
<!-- AUTO-EMBED END -->
