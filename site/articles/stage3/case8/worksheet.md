---
layout: default
title: "Stage 3 CASE8: Worksheet"
---
[WORKSHEET BASE]
- [derive_hash_worksheet.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/derive_hash_worksheet.md)
- [user_create_deep_worksheet.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_create_deep_worksheet.md)
- [user_create_long_worksheet.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_create_long_worksheet.md)
- [user_create_simple_worksheet.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_create_simple_worksheet.md)
- [user_hash_collision_worksheet.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_hash_collision_worksheet.md)
- [user_open_existing_worksheet.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_open_existing_worksheet.md)
- [user_rename_worksheet.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_rename_worksheet.md)

[WORKSHEET AXIOM]
- [derive_hash_worksheet_axiom.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/derive_hash_worksheet_axiom.md)
- [user_create_deep_worksheet_axiom.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_create_deep_worksheet_axiom.md)
- [user_create_long_worksheet_axiom.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_create_long_worksheet_axiom.md)
- [user_create_simple_worksheet_axiom.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_create_simple_worksheet_axiom.md)
- [user_hash_collision_worksheet_axiom.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_hash_collision_worksheet_axiom.md)
- [user_open_existing_worksheet_axiom.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_open_existing_worksheet_axiom.md)
- [user_rename_worksheet_axiom.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_rename_worksheet_axiom.md)

[WORKSHEET AXIOM HARD]
- [derive_hash_worksheet_axiom_hard.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/derive_hash_worksheet_axiom_hard.md)
- [user_create_deep_worksheet_axiom_hard.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_create_deep_worksheet_axiom_hard.md)
- [user_create_long_worksheet_axiom_hard.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_create_long_worksheet_axiom_hard.md)
- [user_create_simple_worksheet_axiom_hard.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_create_simple_worksheet_axiom_hard.md)
- [user_hash_collision_worksheet_axiom_hard.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_hash_collision_worksheet_axiom_hard.md)
- [user_open_existing_worksheet_axiom_hard.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_open_existing_worksheet_axiom_hard.md)
- [user_rename_worksheet_axiom_hard.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/worksheets/user_rename_worksheet_axiom_hard.md)

[REQUIRED HAND TASKS]
1. Verify entry/ret pair counts.
2. Verify pointer class counts.
3. Record contradiction lines and expected fixes.
4. Cross-compare with one adjacent case.

<!-- AUTO-EMBED START -->
[AUTO] case=case8

[USERDIR] kernel/user/stage3/case8_creation_proof

================================================================================
[EMBED] derive_hash_worksheet.md
[SOURCE] kernel/user/stage3/case8_creation_proof/worksheets/derive_hash_worksheet.md
================================================================================
# Worksheet: derive_hash

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case8_creation_proof/derive_hash.c`
- Driver: `kernel/drivers/stage3/case8_creation_proof/trace_derive_hash/trace_derive_hash.c`
- Module: `trace_derive_hash`
- Binary: `kernel/user/stage3/case8_creation_proof/derive_hash.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 8
- `do_filp_open.ret`: 8
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53115.394038] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77c64`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53115.394059] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53115.394073] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77b74`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53115.394084] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53115.394096] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77ab4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53115.394107] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53115.394121] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77e64`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53115.394129] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53115.394136] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77e44`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53115.394143] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53115.394150] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77dd4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53115.394158] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53115.394165] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77b64`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53115.394176] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=ffff898e8d448240`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53115.394209] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77ac4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53115.394219] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=ffff898e8d448900`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=8 ret=8
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case8_creation_proof/reports/derive_hash_trace_report.md`
- dmesg: `kernel/user/stage3/case8_creation_proof/reports/derive_hash_dmesg.txt`

================================================================================
[EMBED] user_create_deep_worksheet.md
[SOURCE] kernel/user/stage3/case8_creation_proof/worksheets/user_create_deep_worksheet.md
================================================================================
# Worksheet: user_create_deep

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case8_creation_proof/user_create_deep.c`
- Driver: `kernel/drivers/stage3/case8_creation_proof/trace_user_create_deep/trace_user_create_deep.c`
- Module: `trace_user_create_deep`
- Binary: `kernel/user/stage3/case8_creation_proof/user_create_deep.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 3

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53116.497540] [trace_user_create_deep] do_filp_open.entry pid=271559 comm=user_create_dee dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970070fdb4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53116.497553] [trace_user_create_deep] do_filp_open.ret pid=271559 comm=user_create_dee ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53116.497560] [trace_user_create_deep] do_filp_open.entry pid=271559 comm=user_create_dee dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970070fb44`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53116.497565] [trace_user_create_deep] do_filp_open.ret pid=271559 comm=user_create_dee ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53116.497571] [trace_user_create_deep] do_filp_open.entry pid=271559 comm=user_create_dee dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970070fcc4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53116.497577] [trace_user_create_deep] do_filp_open.ret pid=271559 comm=user_create_dee ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53116.497584] [trace_user_create_deep] do_filp_open.entry pid=271559 comm=user_create_dee dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970070fe04`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53116.497587] [trace_user_create_deep] do_filp_open.ret pid=271559 comm=user_create_dee ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53116.497590] [trace_user_create_deep] do_filp_open.entry pid=271559 comm=user_create_dee dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970070faa4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53116.497593] [trace_user_create_deep] do_filp_open.ret pid=271559 comm=user_create_dee ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53116.497596] [trace_user_create_deep] do_filp_open.entry pid=271559 comm=user_create_dee dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970070fc94`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53116.497600] [trace_user_create_deep] do_filp_open.ret pid=271559 comm=user_create_dee ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53116.497603] [trace_user_create_deep] do_filp_open.entry pid=271559 comm=user_create_dee dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970070fcc4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53116.497608] [trace_user_create_deep] do_filp_open.ret pid=271559 comm=user_create_dee ret=ffff898fd33a1f00`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53116.497629] [trace_user_create_deep] do_filp_open.entry pid=271559 comm=user_create_dee dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970070fe24`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53116.497634] [trace_user_create_deep] do_filp_open.ret pid=271559 comm=user_create_dee ret=ffff898fd33a1180`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53116.497841] [trace_user_create_deep] do_filp_open.entry pid=271559 comm=user_create_dee dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970070fcc4`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53116.497848] [trace_user_create_deep] do_filp_open.ret pid=271559 comm=user_create_dee ret=ffffffffffffffef`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case8_creation_proof/reports/user_create_deep_trace_report.md`
- dmesg: `kernel/user/stage3/case8_creation_proof/reports/user_create_deep_dmesg.txt`

================================================================================
[EMBED] user_create_long_worksheet.md
[SOURCE] kernel/user/stage3/case8_creation_proof/worksheets/user_create_long_worksheet.md
================================================================================
# Worksheet: user_create_long

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case8_creation_proof/user_create_long.c`
- Driver: `kernel/drivers/stage3/case8_creation_proof/trace_user_create_long/trace_user_create_long.c`
- Module: `trace_user_create_long`
- Binary: `kernel/user/stage3/case8_creation_proof/user_create_long.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 3

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53117.685041] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07d84`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53117.685067] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53117.685085] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07de4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53117.685099] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53117.685114] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07ba4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53117.685128] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53117.685147] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07d74`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53117.685157] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53117.685165] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07df4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53117.685175] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53117.685183] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07c64`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53117.685193] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53117.685202] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07c44`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53117.685214] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=ffff898fee51a6c0`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53117.685264] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07c04`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53117.685278] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=ffff898e93581600`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53117.685752] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07e24`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53117.685769] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=ffffffffffffffef`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case8_creation_proof/reports/user_create_long_trace_report.md`
- dmesg: `kernel/user/stage3/case8_creation_proof/reports/user_create_long_dmesg.txt`

================================================================================
[EMBED] user_create_simple_worksheet.md
[SOURCE] kernel/user/stage3/case8_creation_proof/worksheets/user_create_simple_worksheet.md
================================================================================
# Worksheet: user_create_simple

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case8_creation_proof/user_create_simple.c`
- Driver: `kernel/drivers/stage3/case8_creation_proof/trace_user_create_simple/trace_user_create_simple.c`
- Module: `trace_user_create_simple`
- Binary: `kernel/user/stage3/case8_creation_proof/user_create_simple.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 1
- `__d_alloc.ret`: 1
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 3

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53118.764421] [trace_user_create_simple] do_filp_open.entry pid=272074 comm=user_create_sim dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007dbbb4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53118.764458] [trace_user_create_simple] do_filp_open.ret pid=272074 comm=user_create_sim ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53118.764466] [trace_user_create_simple] do_filp_open.entry pid=272074 comm=user_create_sim dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007dbac4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53118.764471] [trace_user_create_simple] do_filp_open.ret pid=272074 comm=user_create_sim ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53118.764476] [trace_user_create_simple] do_filp_open.entry pid=272074 comm=user_create_sim dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007dbd54`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53118.764481] [trace_user_create_simple] do_filp_open.ret pid=272074 comm=user_create_sim ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53118.764488] [trace_user_create_simple] do_filp_open.entry pid=272074 comm=user_create_sim dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007dbcd4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53118.764492] [trace_user_create_simple] do_filp_open.ret pid=272074 comm=user_create_sim ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53118.764495] [trace_user_create_simple] do_filp_open.entry pid=272074 comm=user_create_sim dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007dbba4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53118.764498] [trace_user_create_simple] do_filp_open.ret pid=272074 comm=user_create_sim ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53118.764501] [trace_user_create_simple] do_filp_open.entry pid=272074 comm=user_create_sim dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007dbad4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53118.764504] [trace_user_create_simple] do_filp_open.ret pid=272074 comm=user_create_sim ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53118.764508] [trace_user_create_simple] do_filp_open.entry pid=272074 comm=user_create_sim dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007dbaf4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53118.764512] [trace_user_create_simple] do_filp_open.ret pid=272074 comm=user_create_sim ret=ffff898f8a349180`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53118.764531] [trace_user_create_simple] do_filp_open.entry pid=272074 comm=user_create_sim dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007dbc84`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53118.764536] [trace_user_create_simple] do_filp_open.ret pid=272074 comm=user_create_sim ret=ffff898f8a3493c0`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53118.764724] [trace_user_create_simple] do_filp_open.entry pid=272074 comm=user_create_sim dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007dbc64`
- #18. call=`__d_alloc.entry` source_line=`dmesg:19` raw=`[53118.764730] [trace_user_create_simple] __d_alloc.entry pid=272074 comm=user_create_sim sb=ffff898e906aa000 name_qstr=ffffcc97007dbb30`
- #19. call=`__d_alloc.ret` source_line=`dmesg:20` raw=`[53118.764734] [trace_user_create_simple] __d_alloc.ret pid=272074 comm=user_create_sim dentry=ffff899145f55c00`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53118.764786] [trace_user_create_simple] do_filp_open.ret pid=272074 comm=user_create_sim ret=ffff898f8a349180`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=1 ret=1

## Raw Artifacts
- report: `kernel/user/stage3/case8_creation_proof/reports/user_create_simple_trace_report.md`
- dmesg: `kernel/user/stage3/case8_creation_proof/reports/user_create_simple_dmesg.txt`

================================================================================
[EMBED] user_hash_collision_worksheet.md
[SOURCE] kernel/user/stage3/case8_creation_proof/worksheets/user_hash_collision_worksheet.md
================================================================================
# Worksheet: user_hash_collision

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case8_creation_proof/user_hash_collision.c`
- Driver: `kernel/drivers/stage3/case8_creation_proof/trace_user_hash_collision/trace_user_hash_collision.c`
- Module: `trace_user_hash_collision`
- Binary: `kernel/user/stage3/case8_creation_proof/user_hash_collision.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 11
- `do_filp_open.ret`: 11
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 5

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53119.951055] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebcc4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53119.951068] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53119.951074] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebcf4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53119.951079] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53119.951085] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebb54`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53119.951090] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53119.951096] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebad4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53119.951100] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53119.951103] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebbd4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53119.951106] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53119.951109] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebc84`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53119.951113] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53119.951116] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebbc4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53119.951121] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=ffff898fe24fd9c0`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53119.951138] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebbf4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53119.951143] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=ffff898fe24fd3c0`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53119.951331] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebd14`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53119.951338] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=ffffffffffffffef`
- #19. call=`do_filp_open.entry` source_line=`dmesg:20` raw=`[53119.951342] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebd94`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53119.951346] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=ffffffffffffffef`
- #21. call=`do_filp_open.entry` source_line=`dmesg:22` raw=`[53119.951349] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebb34`
- #22. call=`do_filp_open.ret` source_line=`dmesg:23` raw=`[53119.951353] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=ffffffffffffffef`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=11 ret=11
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case8_creation_proof/reports/user_hash_collision_trace_report.md`
- dmesg: `kernel/user/stage3/case8_creation_proof/reports/user_hash_collision_dmesg.txt`

================================================================================
[EMBED] user_open_existing_worksheet.md
[SOURCE] kernel/user/stage3/case8_creation_proof/worksheets/user_open_existing_worksheet.md
================================================================================
# Worksheet: user_open_existing

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case8_creation_proof/user_open_existing.c`
- Driver: `kernel/drivers/stage3/case8_creation_proof/trace_user_open_existing/trace_user_open_existing.c`
- Module: `trace_user_open_existing`
- Binary: `kernel/user/stage3/case8_creation_proof/user_open_existing.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 7
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53121.047425] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfac4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53121.047437] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53121.047444] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfc34`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53121.047449] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53121.047454] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfb84`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53121.047459] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53121.047467] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfe84`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53121.047470] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53121.047473] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfdc4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53121.047476] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53121.047479] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfd64`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53121.047483] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53121.047486] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfc24`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53121.047491] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=ffff898fd33a1240`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53121.047509] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfd84`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53121.047514] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=ffff898fd33a1000`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53121.047696] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfe34`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53121.047701] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case8_creation_proof/reports/user_open_existing_trace_report.md`
- dmesg: `kernel/user/stage3/case8_creation_proof/reports/user_open_existing_dmesg.txt`

================================================================================
[EMBED] user_rename_worksheet.md
[SOURCE] kernel/user/stage3/case8_creation_proof/worksheets/user_rename_worksheet.md
================================================================================
# Worksheet: user_rename

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case8_creation_proof/user_rename.c`
- Driver: `kernel/drivers/stage3/case8_creation_proof/trace_user_rename/trace_user_rename.c`
- Module: `trace_user_rename`
- Binary: `kernel/user/stage3/case8_creation_proof/user_rename.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 1
- `__d_alloc.ret`: 1
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 3

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53122.153426] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203c74`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53122.153440] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53122.153446] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203e04`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53122.153451] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53122.153456] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203b94`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53122.153461] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53122.153468] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203dd4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53122.153472] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53122.153475] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203e24`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53122.153478] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53122.153481] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203ae4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53122.153485] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53122.153488] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203b74`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53122.153493] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=ffff898fe2998300`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53122.153511] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203e34`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53122.153517] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=ffff898da2b6ee40`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53122.153695] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203b14`
- #18. call=`__d_alloc.entry` source_line=`dmesg:19` raw=`[53122.153700] [trace_user_rename] __d_alloc.entry pid=272859 comm=user_rename.out sb=ffff898e906aa000 name_qstr=ffffcc97022039e0`
- #19. call=`__d_alloc.ret` source_line=`dmesg:20` raw=`[53122.153704] [trace_user_rename] __d_alloc.ret pid=272859 comm=user_rename.out dentry=ffff89914d1233c0`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53122.153753] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=ffff898da2b6ef00`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=1 ret=1

## Raw Artifacts
- report: `kernel/user/stage3/case8_creation_proof/reports/user_rename_trace_report.md`
- dmesg: `kernel/user/stage3/case8_creation_proof/reports/user_rename_dmesg.txt`
<!-- AUTO-EMBED END -->
