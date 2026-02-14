# Worksheet: case3_deep_hit

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case3_deep_hit/case3_deep_hit.c`
- Driver: `kernel/drivers/stage3/case3_deep_hit/trace_case3_deep_hit/trace_case3_deep_hit.c`
- Module: `trace_case3_deep_hit`
- Binary: `kernel/user/stage3/case3_deep_hit/case3_deep_hit.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 10
- `do_filp_open.ret`: 10
- `__d_alloc.entry`: 1
- `__d_alloc.ret`: 1
- `ERR_PTR(-ENOENT)` returns: 8
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53104.837112] [trace_case3_deep_hit] do_filp_open.entry pid=269988 comm=case3_deep_hit. dfd=4294967196 pathname=ffff898e8d73a000 op=ffffcc9700c7bbb4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53104.837125] [trace_case3_deep_hit] do_filp_open.ret pid=269988 comm=case3_deep_hit. ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53104.837131] [trace_case3_deep_hit] do_filp_open.entry pid=269988 comm=case3_deep_hit. dfd=4294967196 pathname=ffff898e8d73a000 op=ffffcc9700c7be74`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53104.837137] [trace_case3_deep_hit] do_filp_open.ret pid=269988 comm=case3_deep_hit. ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53104.837142] [trace_case3_deep_hit] do_filp_open.entry pid=269988 comm=case3_deep_hit. dfd=4294967196 pathname=ffff898e8d73a000 op=ffffcc9700c7bad4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53104.837147] [trace_case3_deep_hit] do_filp_open.ret pid=269988 comm=case3_deep_hit. ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53104.837154] [trace_case3_deep_hit] do_filp_open.entry pid=269988 comm=case3_deep_hit. dfd=4294967196 pathname=ffff898e8d73a000 op=ffffcc9700c7bd94`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53104.837158] [trace_case3_deep_hit] do_filp_open.ret pid=269988 comm=case3_deep_hit. ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53104.837161] [trace_case3_deep_hit] do_filp_open.entry pid=269988 comm=case3_deep_hit. dfd=4294967196 pathname=ffff898e8d73a000 op=ffffcc9700c7bd04`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53104.837165] [trace_case3_deep_hit] do_filp_open.ret pid=269988 comm=case3_deep_hit. ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53104.837168] [trace_case3_deep_hit] do_filp_open.entry pid=269988 comm=case3_deep_hit. dfd=4294967196 pathname=ffff898e8d73a000 op=ffffcc9700c7bcb4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53104.837171] [trace_case3_deep_hit] do_filp_open.ret pid=269988 comm=case3_deep_hit. ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53104.837175] [trace_case3_deep_hit] do_filp_open.entry pid=269988 comm=case3_deep_hit. dfd=4294967196 pathname=ffff898e8d73a000 op=ffffcc9700c7bdf4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53104.837180] [trace_case3_deep_hit] do_filp_open.ret pid=269988 comm=case3_deep_hit. ret=ffff898fee51a6c0`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53104.837198] [trace_case3_deep_hit] do_filp_open.entry pid=269988 comm=case3_deep_hit. dfd=4294967196 pathname=ffff898e8d73a000 op=ffffcc9700c7bb34`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53104.837203] [trace_case3_deep_hit] do_filp_open.ret pid=269988 comm=case3_deep_hit. ret=ffff898e9b44b900`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53104.837396] [trace_case3_deep_hit] do_filp_open.entry pid=269988 comm=case3_deep_hit. dfd=4294967196 pathname=ffff898e8d73a000 op=ffffcc9700c7bbf4`
- #18. call=`__d_alloc.entry` source_line=`dmesg:19` raw=`[53104.837402] [trace_case3_deep_hit] __d_alloc.entry pid=269988 comm=case3_deep_hit. sb=ffff898e906aa000 name_qstr=ffffcc9700c7bac0`
- #19. call=`__d_alloc.ret` source_line=`dmesg:20` raw=`[53104.837406] [trace_case3_deep_hit] __d_alloc.ret pid=269988 comm=case3_deep_hit. dentry=ffff89911c6d7c00`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53104.837417] [trace_case3_deep_hit] do_filp_open.ret pid=269988 comm=case3_deep_hit. ret=fffffffffffffffe`
- #21. call=`do_filp_open.entry` source_line=`dmesg:22` raw=`[53104.837434] [trace_case3_deep_hit] do_filp_open.entry pid=269988 comm=case3_deep_hit. dfd=4294967196 pathname=ffff898e8d73a000 op=ffffcc9700c7bba4`
- #22. call=`do_filp_open.ret` source_line=`dmesg:23` raw=`[53104.837438] [trace_case3_deep_hit] do_filp_open.ret pid=269988 comm=case3_deep_hit. ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=10 ret=10
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=1 ret=1

## Raw Artifacts
- report: `kernel/user/stage3/case3_deep_hit/reports/case3_deep_hit_trace_report.md`
- dmesg: `kernel/user/stage3/case3_deep_hit/reports/case3_deep_hit_dmesg.txt`
