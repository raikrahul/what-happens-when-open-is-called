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
