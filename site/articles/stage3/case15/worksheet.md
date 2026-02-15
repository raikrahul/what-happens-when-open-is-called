---
layout: default
title: "Stage 3 CASE15: Worksheet"
---
[WORKSHEET BASE]
- [user_deep_create_worksheet.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace/worksheets/user_deep_create_worksheet.md)
- [user_deep_open_worksheet.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace/worksheets/user_deep_open_worksheet.md)

[WORKSHEET AXIOM]
- [user_deep_create_worksheet_axiom.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace/worksheets/user_deep_create_worksheet_axiom.md)
- [user_deep_open_worksheet_axiom.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace/worksheets/user_deep_open_worksheet_axiom.md)

[WORKSHEET AXIOM HARD]
- [user_deep_create_worksheet_axiom_hard.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace/worksheets/user_deep_create_worksheet_axiom_hard.md)
- [user_deep_open_worksheet_axiom_hard.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace/worksheets/user_deep_open_worksheet_axiom_hard.md)

[REQUIRED HAND TASKS]
1. Verify entry/ret pair counts.
2. Verify pointer class counts.
3. Record contradiction lines and expected fixes.
4. Cross-compare with one adjacent case.

<!-- AUTO-EMBED START -->
[AUTO] case=case15

[USERDIR] kernel/user/stage3/case15_deep_trace

================================================================================
[EMBED] user_deep_create_worksheet.md
[SOURCE] kernel/user/stage3/case15_deep_trace/worksheets/user_deep_create_worksheet.md
================================================================================
# Worksheet: user_deep_create

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case15_deep_trace/user_deep_create.c`
- Driver: `kernel/drivers/stage3/case15_deep_trace/trace_user_deep_create/trace_user_deep_create.c`
- Module: `trace_user_deep_create`
- Binary: `kernel/user/stage3/case15_deep_trace/user_deep_create.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 3

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53095.763894] [trace_user_deep_create] do_filp_open.entry pid=267907 comm=user_deep_creat dfd=4294967196 pathname=ffff898e8d73d000 op=ffffcc97025b3b84`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53095.763906] [trace_user_deep_create] do_filp_open.ret pid=267907 comm=user_deep_creat ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53095.763913] [trace_user_deep_create] do_filp_open.entry pid=267907 comm=user_deep_creat dfd=4294967196 pathname=ffff898e8d73d000 op=ffffcc97025b3b14`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53095.763918] [trace_user_deep_create] do_filp_open.ret pid=267907 comm=user_deep_creat ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53095.763923] [trace_user_deep_create] do_filp_open.entry pid=267907 comm=user_deep_creat dfd=4294967196 pathname=ffff898e8d73d000 op=ffffcc97025b3c04`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53095.763928] [trace_user_deep_create] do_filp_open.ret pid=267907 comm=user_deep_creat ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53095.763935] [trace_user_deep_create] do_filp_open.entry pid=267907 comm=user_deep_creat dfd=4294967196 pathname=ffff898e8d73d000 op=ffffcc97025b3b94`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53095.763938] [trace_user_deep_create] do_filp_open.ret pid=267907 comm=user_deep_creat ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53095.763941] [trace_user_deep_create] do_filp_open.entry pid=267907 comm=user_deep_creat dfd=4294967196 pathname=ffff898e8d73d000 op=ffffcc97025b3e24`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53095.763944] [trace_user_deep_create] do_filp_open.ret pid=267907 comm=user_deep_creat ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53095.763948] [trace_user_deep_create] do_filp_open.entry pid=267907 comm=user_deep_creat dfd=4294967196 pathname=ffff898e8d73d000 op=ffffcc97025b3de4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53095.763951] [trace_user_deep_create] do_filp_open.ret pid=267907 comm=user_deep_creat ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53095.763955] [trace_user_deep_create] do_filp_open.entry pid=267907 comm=user_deep_creat dfd=4294967196 pathname=ffff898e8d73d000 op=ffffcc97025b3b34`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53095.763960] [trace_user_deep_create] do_filp_open.ret pid=267907 comm=user_deep_creat ret=ffff898eb832af00`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53095.763980] [trace_user_deep_create] do_filp_open.entry pid=267907 comm=user_deep_creat dfd=4294967196 pathname=ffff898e8d73d000 op=ffffcc97025b3bc4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53095.763985] [trace_user_deep_create] do_filp_open.ret pid=267907 comm=user_deep_creat ret=ffff898eb832a540`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53095.764231] [trace_user_deep_create] do_filp_open.entry pid=267907 comm=user_deep_creat dfd=4294967196 pathname=ffff898e8d73d000 op=ffffcc97025b3a94`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53095.764259] [trace_user_deep_create] do_filp_open.ret pid=267907 comm=user_deep_creat ret=ffff898eb832af00`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case15_deep_trace/reports/user_deep_create_trace_report.md`
- dmesg: `kernel/user/stage3/case15_deep_trace/reports/user_deep_create_dmesg.txt`

================================================================================
[EMBED] user_deep_open_worksheet.md
[SOURCE] kernel/user/stage3/case15_deep_trace/worksheets/user_deep_open_worksheet.md
================================================================================
# Worksheet: user_deep_open

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case15_deep_trace/user_deep_open.c`
- Driver: `kernel/drivers/stage3/case15_deep_trace/trace_user_deep_open/trace_user_deep_open.c`
- Module: `trace_user_deep_open`
- Binary: `kernel/user/stage3/case15_deep_trace/user_deep_open.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 3

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53096.833441] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3bf4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53096.833466] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53096.833484] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3c04`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53096.833498] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53096.833513] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3bb4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53096.833527] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53096.833545] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3d94`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53096.833555] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53096.833563] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3aa4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53096.833573] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53096.833581] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3c44`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53096.833591] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53096.833600] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3b74`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53096.833613] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=ffff898eaaa05e40`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53096.833697] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3ac4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53096.833715] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=ffff898eaaa05000`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53096.834346] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3e04`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53096.834368] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=ffff898eaaa05e40`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case15_deep_trace/reports/user_deep_open_trace_report.md`
- dmesg: `kernel/user/stage3/case15_deep_trace/reports/user_deep_open_dmesg.txt`
<!-- AUTO-EMBED END -->
