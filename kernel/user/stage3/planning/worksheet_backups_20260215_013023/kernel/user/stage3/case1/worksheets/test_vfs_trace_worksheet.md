# Worksheet: test_vfs_trace

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case1/test_vfs_trace.c`
- Driver: `kernel/drivers/stage3/case1/trace_test_vfs_trace/trace_test_vfs_trace.c`
- Module: `trace_test_vfs_trace`
- Binary: `kernel/user/stage3/case1/test_vfs_trace.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 12
- `do_filp_open.ret`: 12
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 8
- non-error pointer returns: 4

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53086.823880] [trace_test_vfs_trace] do_filp_open.entry pid=265729 comm=test_vfs_trace. dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc970254bd24`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53086.823907] [trace_test_vfs_trace] do_filp_open.ret pid=265729 comm=test_vfs_trace. ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53086.823925] [trace_test_vfs_trace] do_filp_open.entry pid=265729 comm=test_vfs_trace. dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc970254bdf4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53086.823939] [trace_test_vfs_trace] do_filp_open.ret pid=265729 comm=test_vfs_trace. ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53086.823954] [trace_test_vfs_trace] do_filp_open.entry pid=265729 comm=test_vfs_trace. dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc970254baf4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53086.823968] [trace_test_vfs_trace] do_filp_open.ret pid=265729 comm=test_vfs_trace. ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53086.823987] [trace_test_vfs_trace] do_filp_open.entry pid=265729 comm=test_vfs_trace. dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc970254bae4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53086.823997] [trace_test_vfs_trace] do_filp_open.ret pid=265729 comm=test_vfs_trace. ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53086.824005] [trace_test_vfs_trace] do_filp_open.entry pid=265729 comm=test_vfs_trace. dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc970254bc34`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53086.824015] [trace_test_vfs_trace] do_filp_open.ret pid=265729 comm=test_vfs_trace. ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53086.824023] [trace_test_vfs_trace] do_filp_open.entry pid=265729 comm=test_vfs_trace. dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc970254ba94`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53086.824033] [trace_test_vfs_trace] do_filp_open.ret pid=265729 comm=test_vfs_trace. ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53086.824042] [trace_test_vfs_trace] do_filp_open.entry pid=265729 comm=test_vfs_trace. dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc970254be44`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53086.824055] [trace_test_vfs_trace] do_filp_open.ret pid=265729 comm=test_vfs_trace. ret=ffff898da2b6e300`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53086.824104] [trace_test_vfs_trace] do_filp_open.entry pid=265729 comm=test_vfs_trace. dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc970254bab4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53086.824118] [trace_test_vfs_trace] do_filp_open.ret pid=265729 comm=test_vfs_trace. ret=ffff898da2b6ea80`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53086.824687] [trace_test_vfs_trace] do_filp_open.entry pid=265729 comm=test_vfs_trace. dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc970254be34`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53086.824708] [trace_test_vfs_trace] do_filp_open.ret pid=265729 comm=test_vfs_trace. ret=ffff898da2b6e300`
- #19. call=`do_filp_open.entry` source_line=`dmesg:20` raw=`[53086.824722] [trace_test_vfs_trace] do_filp_open.entry pid=265729 comm=test_vfs_trace. dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc970254bdc4`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53086.824734] [trace_test_vfs_trace] do_filp_open.ret pid=265729 comm=test_vfs_trace. ret=ffff898da2b6e300`
- #21. call=`do_filp_open.entry` source_line=`dmesg:22` raw=`[53086.824745] [trace_test_vfs_trace] do_filp_open.entry pid=265729 comm=test_vfs_trace. dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc970254be24`
- #22. call=`do_filp_open.ret` source_line=`dmesg:23` raw=`[53086.824756] [trace_test_vfs_trace] do_filp_open.ret pid=265729 comm=test_vfs_trace. ret=fffffffffffffffe`
- #23. call=`do_filp_open.entry` source_line=`dmesg:24` raw=`[53086.824797] [trace_test_vfs_trace] do_filp_open.entry pid=265729 comm=test_vfs_trace. dfd=4294967196 pathname=ffff898e8d73b000 op=ffffcc970254bc54`
- #24. call=`do_filp_open.ret` source_line=`dmesg:25` raw=`[53086.824810] [trace_test_vfs_trace] do_filp_open.ret pid=265729 comm=test_vfs_trace. ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=12 ret=12
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case1/reports/test_vfs_trace_trace_report.md`
- dmesg: `kernel/user/stage3/case1/reports/test_vfs_trace_dmesg.txt`
