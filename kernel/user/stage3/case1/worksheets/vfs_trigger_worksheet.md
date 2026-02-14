# Worksheet: vfs_trigger

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case1/vfs_trigger.c`
- Driver: `kernel/drivers/stage3/case1/trace_vfs_trigger/trace_vfs_trigger.c`
- Module: `trace_vfs_trigger`
- Binary: `kernel/user/stage3/case1/vfs_trigger.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 10
- `do_filp_open.ret`: 10
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 4

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53087.885183] [trace_vfs_trigger] do_filp_open.entry pid=265987 comm=vfs_trigger.out dfd=4294967196 pathname=ffff898e8c9e4000 op=ffffcc9702303bb4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53087.885205] [trace_vfs_trigger] do_filp_open.ret pid=265987 comm=vfs_trigger.out ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53087.885218] [trace_vfs_trigger] do_filp_open.entry pid=265987 comm=vfs_trigger.out dfd=4294967196 pathname=ffff898e8c9e4000 op=ffffcc9702303e14`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53087.885229] [trace_vfs_trigger] do_filp_open.ret pid=265987 comm=vfs_trigger.out ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53087.885241] [trace_vfs_trigger] do_filp_open.entry pid=265987 comm=vfs_trigger.out dfd=4294967196 pathname=ffff898e8c9e4000 op=ffffcc9702303c94`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53087.885252] [trace_vfs_trigger] do_filp_open.ret pid=265987 comm=vfs_trigger.out ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53087.885266] [trace_vfs_trigger] do_filp_open.entry pid=265987 comm=vfs_trigger.out dfd=4294967196 pathname=ffff898e8c9e4000 op=ffffcc9702303df4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53087.885274] [trace_vfs_trigger] do_filp_open.ret pid=265987 comm=vfs_trigger.out ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53087.885281] [trace_vfs_trigger] do_filp_open.entry pid=265987 comm=vfs_trigger.out dfd=4294967196 pathname=ffff898e8c9e4000 op=ffffcc9702303ca4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53087.885288] [trace_vfs_trigger] do_filp_open.ret pid=265987 comm=vfs_trigger.out ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53087.885295] [trace_vfs_trigger] do_filp_open.entry pid=265987 comm=vfs_trigger.out dfd=4294967196 pathname=ffff898e8c9e4000 op=ffffcc9702303cc4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53087.885303] [trace_vfs_trigger] do_filp_open.ret pid=265987 comm=vfs_trigger.out ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53087.885310] [trace_vfs_trigger] do_filp_open.entry pid=265987 comm=vfs_trigger.out dfd=4294967196 pathname=ffff898e8c9e4000 op=ffffcc9702303db4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53087.885321] [trace_vfs_trigger] do_filp_open.ret pid=265987 comm=vfs_trigger.out ret=ffff898eb832a540`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53087.885358] [trace_vfs_trigger] do_filp_open.entry pid=265987 comm=vfs_trigger.out dfd=4294967196 pathname=ffff898e8c9e4000 op=ffffcc9702303de4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53087.885369] [trace_vfs_trigger] do_filp_open.ret pid=265987 comm=vfs_trigger.out ret=ffff898fee51a6c0`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53087.885730] [trace_vfs_trigger] do_filp_open.entry pid=265987 comm=vfs_trigger.out dfd=4294967196 pathname=ffff898e8c9e4000 op=ffffcc9702303e44`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53087.885745] [trace_vfs_trigger] do_filp_open.ret pid=265987 comm=vfs_trigger.out ret=ffff898eb832a540`
- #19. call=`do_filp_open.entry` source_line=`dmesg:20` raw=`[53087.885798] [trace_vfs_trigger] do_filp_open.entry pid=265987 comm=vfs_trigger.out dfd=3 pathname=ffff898e8c9e4000 op=ffffcc9702303ad4`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53087.885809] [trace_vfs_trigger] do_filp_open.ret pid=265987 comm=vfs_trigger.out ret=ffff89911fbd3e40`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=10 ret=10
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case1/reports/vfs_trigger_trace_report.md`
- dmesg: `kernel/user/stage3/case1/reports/vfs_trigger_dmesg.txt`
