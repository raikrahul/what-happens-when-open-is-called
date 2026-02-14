# Worksheet: case2_deep_miss

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case2_deep_miss/case2_deep_miss.c`
- Driver: `kernel/drivers/stage3/case2_deep_miss/trace_case2_deep_miss/trace_case2_deep_miss.c`
- Module: `trace_case2_deep_miss`
- Binary: `kernel/user/stage3/case2_deep_miss/case2_deep_miss.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 1
- `__d_alloc.ret`: 1
- `ERR_PTR(-ENOENT)` returns: 7
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53103.655448] [trace_case2_deep_miss] do_filp_open.entry pid=269729 comm=case2_deep_miss dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc9700fc7c14`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53103.655475] [trace_case2_deep_miss] do_filp_open.ret pid=269729 comm=case2_deep_miss ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53103.655493] [trace_case2_deep_miss] do_filp_open.entry pid=269729 comm=case2_deep_miss dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc9700fc7c04`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53103.655507] [trace_case2_deep_miss] do_filp_open.ret pid=269729 comm=case2_deep_miss ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53103.655522] [trace_case2_deep_miss] do_filp_open.entry pid=269729 comm=case2_deep_miss dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc9700fc7e44`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53103.655536] [trace_case2_deep_miss] do_filp_open.ret pid=269729 comm=case2_deep_miss ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53103.655554] [trace_case2_deep_miss] do_filp_open.entry pid=269729 comm=case2_deep_miss dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc9700fc7c84`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53103.655565] [trace_case2_deep_miss] do_filp_open.ret pid=269729 comm=case2_deep_miss ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53103.655573] [trace_case2_deep_miss] do_filp_open.entry pid=269729 comm=case2_deep_miss dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc9700fc7e14`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53103.655583] [trace_case2_deep_miss] do_filp_open.ret pid=269729 comm=case2_deep_miss ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53103.655591] [trace_case2_deep_miss] do_filp_open.entry pid=269729 comm=case2_deep_miss dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc9700fc7ca4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53103.655601] [trace_case2_deep_miss] do_filp_open.ret pid=269729 comm=case2_deep_miss ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53103.655610] [trace_case2_deep_miss] do_filp_open.entry pid=269729 comm=case2_deep_miss dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc9700fc7d34`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53103.655623] [trace_case2_deep_miss] do_filp_open.ret pid=269729 comm=case2_deep_miss ret=ffff898ea6d10e40`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53103.655665] [trace_case2_deep_miss] do_filp_open.entry pid=269729 comm=case2_deep_miss dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc9700fc7dc4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53103.655679] [trace_case2_deep_miss] do_filp_open.ret pid=269729 comm=case2_deep_miss ret=ffff898ea6d10240`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53103.656245] [trace_case2_deep_miss] do_filp_open.entry pid=269729 comm=case2_deep_miss dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc9700fc7d14`
- #18. call=`__d_alloc.entry` source_line=`dmesg:19` raw=`[53103.656264] [trace_case2_deep_miss] __d_alloc.entry pid=269729 comm=case2_deep_miss sb=ffff898e906aa000 name_qstr=ffffcc9700fc7be0`
- #19. call=`__d_alloc.ret` source_line=`dmesg:20` raw=`[53103.656274] [trace_case2_deep_miss] __d_alloc.ret pid=269729 comm=case2_deep_miss dentry=ffff8990e1427780`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53103.656295] [trace_case2_deep_miss] do_filp_open.ret pid=269729 comm=case2_deep_miss ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=1 ret=1

## Raw Artifacts
- report: `kernel/user/stage3/case2_deep_miss/reports/case2_deep_miss_trace_report.md`
- dmesg: `kernel/user/stage3/case2_deep_miss/reports/case2_deep_miss_dmesg.txt`
