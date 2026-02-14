# Worksheet: user_salt_avalanche

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case13_salt_avalanche/user_salt_avalanche.c`
- Driver: `kernel/drivers/stage3/case13_salt_avalanche/trace_user_salt_avalanche/trace_user_salt_avalanche.c`
- Module: `trace_user_salt_avalanche`
- Binary: `kernel/user/stage3/case13_salt_avalanche/user_salt_avalanche.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 10
- `do_filp_open.ret`: 10
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 4

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53093.565867] [trace_user_salt_avalanche] do_filp_open.entry pid=267391 comm=user_salt_avala dfd=4294967196 pathname=ffff898e9961e000 op=ffffcc970255bb14`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53093.565889] [trace_user_salt_avalanche] do_filp_open.ret pid=267391 comm=user_salt_avala ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53093.565904] [trace_user_salt_avalanche] do_filp_open.entry pid=267391 comm=user_salt_avala dfd=4294967196 pathname=ffff898e9961e000 op=ffffcc970255bb84`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53093.565916] [trace_user_salt_avalanche] do_filp_open.ret pid=267391 comm=user_salt_avala ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53093.565928] [trace_user_salt_avalanche] do_filp_open.entry pid=267391 comm=user_salt_avala dfd=4294967196 pathname=ffff898e9961e000 op=ffffcc970255baa4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53093.565940] [trace_user_salt_avalanche] do_filp_open.ret pid=267391 comm=user_salt_avala ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53093.565955] [trace_user_salt_avalanche] do_filp_open.entry pid=267391 comm=user_salt_avala dfd=4294967196 pathname=ffff898e9961e000 op=ffffcc970255bc34`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53093.565963] [trace_user_salt_avalanche] do_filp_open.ret pid=267391 comm=user_salt_avala ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53093.565971] [trace_user_salt_avalanche] do_filp_open.entry pid=267391 comm=user_salt_avala dfd=4294967196 pathname=ffff898e9961e000 op=ffffcc970255bc94`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53093.566005] [trace_user_salt_avalanche] do_filp_open.ret pid=267391 comm=user_salt_avala ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53093.566015] [trace_user_salt_avalanche] do_filp_open.entry pid=267391 comm=user_salt_avala dfd=4294967196 pathname=ffff898e9961e000 op=ffffcc970255bae4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53093.566026] [trace_user_salt_avalanche] do_filp_open.ret pid=267391 comm=user_salt_avala ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53093.566035] [trace_user_salt_avalanche] do_filp_open.entry pid=267391 comm=user_salt_avala dfd=4294967196 pathname=ffff898e9961e000 op=ffffcc970255bb24`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53093.566049] [trace_user_salt_avalanche] do_filp_open.ret pid=267391 comm=user_salt_avala ret=ffff898ebeaa7840`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53093.566102] [trace_user_salt_avalanche] do_filp_open.entry pid=267391 comm=user_salt_avala dfd=4294967196 pathname=ffff898e9961e000 op=ffffcc970255bae4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53093.566118] [trace_user_salt_avalanche] do_filp_open.ret pid=267391 comm=user_salt_avala ret=ffff898e89d91f00`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53093.566501] [trace_user_salt_avalanche] do_filp_open.entry pid=267391 comm=user_salt_avala dfd=4294967196 pathname=ffff898e9961e000 op=ffffcc970255bde4`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53093.566516] [trace_user_salt_avalanche] do_filp_open.ret pid=267391 comm=user_salt_avala ret=ffff898e89d91c00`
- #19. call=`do_filp_open.entry` source_line=`dmesg:20` raw=`[53093.566527] [trace_user_salt_avalanche] do_filp_open.entry pid=267391 comm=user_salt_avala dfd=4294967196 pathname=ffff898e9961e000 op=ffffcc970255bca4`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53093.566538] [trace_user_salt_avalanche] do_filp_open.ret pid=267391 comm=user_salt_avala ret=ffff898e89d91c00`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=10 ret=10
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case13_salt_avalanche/reports/user_salt_avalanche_trace_report.md`
- dmesg: `kernel/user/stage3/case13_salt_avalanche/reports/user_salt_avalanche_dmesg.txt`
