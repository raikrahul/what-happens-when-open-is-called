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
