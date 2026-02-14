# Worksheet: multi_path_open

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/multi_path_open.c`
- Driver: `kernel/drivers/stage3/stage3/trace_multi_path_open/trace_multi_path_open.c`
- Module: `trace_multi_path_open`
- Binary: `kernel/user/stage3/multi_path_open.auto.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 3

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53123.292010] [trace_multi_path_open] do_filp_open.entry pid=273124 comm=multi_path_open dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702453e54`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53123.292032] [trace_multi_path_open] do_filp_open.ret pid=273124 comm=multi_path_open ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53123.292047] [trace_multi_path_open] do_filp_open.entry pid=273124 comm=multi_path_open dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702453d24`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53123.292058] [trace_multi_path_open] do_filp_open.ret pid=273124 comm=multi_path_open ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53123.292070] [trace_multi_path_open] do_filp_open.entry pid=273124 comm=multi_path_open dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702453b14`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53123.292081] [trace_multi_path_open] do_filp_open.ret pid=273124 comm=multi_path_open ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53123.292096] [trace_multi_path_open] do_filp_open.entry pid=273124 comm=multi_path_open dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702453cc4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53123.292104] [trace_multi_path_open] do_filp_open.ret pid=273124 comm=multi_path_open ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53123.292110] [trace_multi_path_open] do_filp_open.entry pid=273124 comm=multi_path_open dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702453ca4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53123.292118] [trace_multi_path_open] do_filp_open.ret pid=273124 comm=multi_path_open ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53123.292124] [trace_multi_path_open] do_filp_open.entry pid=273124 comm=multi_path_open dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702453d54`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53123.292132] [trace_multi_path_open] do_filp_open.ret pid=273124 comm=multi_path_open ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53123.292139] [trace_multi_path_open] do_filp_open.entry pid=273124 comm=multi_path_open dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702453c54`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53123.292150] [trace_multi_path_open] do_filp_open.ret pid=273124 comm=multi_path_open ret=ffff898da2b6e600`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53123.292185] [trace_multi_path_open] do_filp_open.entry pid=273124 comm=multi_path_open dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702453d74`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53123.292195] [trace_multi_path_open] do_filp_open.ret pid=273124 comm=multi_path_open ret=ffff898da2b6e840`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53123.292542] [trace_multi_path_open] do_filp_open.entry pid=273124 comm=multi_path_open dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702453e14`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53123.292554] [trace_multi_path_open] do_filp_open.ret pid=273124 comm=multi_path_open ret=ffff898da2b6e600`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/stage3/reports/multi_path_open_trace_report.md`
- dmesg: `kernel/user/stage3/stage3/reports/multi_path_open_dmesg.txt`
