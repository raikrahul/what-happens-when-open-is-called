# Worksheet: case7_symlink_fast

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case1/case7_symlink_fast.c`
- Driver: `kernel/drivers/stage3/case1/trace_case7_symlink_fast/trace_case7_symlink_fast.c`
- Module: `trace_case7_symlink_fast`
- Binary: `kernel/user/stage3/case1/case7_symlink_fast.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 7
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53075.808065] [trace_case7_symlink_fast] do_filp_open.entry pid=263134 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97007a7da4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53075.808086] [trace_case7_symlink_fast] do_filp_open.ret pid=263134 comm=case7_symlink_f ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53075.808100] [trace_case7_symlink_fast] do_filp_open.entry pid=263134 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97007a7db4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53075.808111] [trace_case7_symlink_fast] do_filp_open.ret pid=263134 comm=case7_symlink_f ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53075.808123] [trace_case7_symlink_fast] do_filp_open.entry pid=263134 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97007a7de4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53075.808134] [trace_case7_symlink_fast] do_filp_open.ret pid=263134 comm=case7_symlink_f ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53075.808148] [trace_case7_symlink_fast] do_filp_open.entry pid=263134 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97007a7b24`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53075.808156] [trace_case7_symlink_fast] do_filp_open.ret pid=263134 comm=case7_symlink_f ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53075.808163] [trace_case7_symlink_fast] do_filp_open.entry pid=263134 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97007a7d94`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53075.808170] [trace_case7_symlink_fast] do_filp_open.ret pid=263134 comm=case7_symlink_f ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53075.808177] [trace_case7_symlink_fast] do_filp_open.entry pid=263134 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97007a7c44`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53075.808185] [trace_case7_symlink_fast] do_filp_open.ret pid=263134 comm=case7_symlink_f ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53075.808192] [trace_case7_symlink_fast] do_filp_open.entry pid=263134 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97007a7c84`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53075.808203] [trace_case7_symlink_fast] do_filp_open.ret pid=263134 comm=case7_symlink_f ret=ffff898ebd786c00`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53075.808240] [trace_case7_symlink_fast] do_filp_open.entry pid=263134 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97007a7de4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53075.808250] [trace_case7_symlink_fast] do_filp_open.ret pid=263134 comm=case7_symlink_f ret=ffff898ebd786300`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53075.808599] [trace_case7_symlink_fast] do_filp_open.entry pid=263134 comm=case7_symlink_f dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97007a7af4`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53075.808612] [trace_case7_symlink_fast] do_filp_open.ret pid=263134 comm=case7_symlink_f ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case1/reports/case7_symlink_fast_trace_report.md`
- dmesg: `kernel/user/stage3/case1/reports/case7_symlink_fast_dmesg.txt`
