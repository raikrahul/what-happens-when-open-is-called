# Worksheet: demo_dup_names

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case1/demo_dup_names.c`
- Driver: `kernel/drivers/stage3/case1/trace_demo_dup_names/trace_demo_dup_names.c`
- Module: `trace_demo_dup_names`
- Binary: `kernel/user/stage3/case1/demo_dup_names.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 10
- `do_filp_open.ret`: 10
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 4

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53079.044970] [trace_demo_dup_names] do_filp_open.entry pid=263907 comm=demo_dup_names. dfd=4294967196 pathname=ffff898e8c88f000 op=ffffcc9700ae3df4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53079.044984] [trace_demo_dup_names] do_filp_open.ret pid=263907 comm=demo_dup_names. ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53079.044991] [trace_demo_dup_names] do_filp_open.entry pid=263907 comm=demo_dup_names. dfd=4294967196 pathname=ffff898e8c88f000 op=ffffcc9700ae3c24`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53079.044996] [trace_demo_dup_names] do_filp_open.ret pid=263907 comm=demo_dup_names. ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53079.045001] [trace_demo_dup_names] do_filp_open.entry pid=263907 comm=demo_dup_names. dfd=4294967196 pathname=ffff898e8c88f000 op=ffffcc9700ae3b74`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53079.045006] [trace_demo_dup_names] do_filp_open.ret pid=263907 comm=demo_dup_names. ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53079.045013] [trace_demo_dup_names] do_filp_open.entry pid=263907 comm=demo_dup_names. dfd=4294967196 pathname=ffff898e8c88f000 op=ffffcc9700ae3b14`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53079.045017] [trace_demo_dup_names] do_filp_open.ret pid=263907 comm=demo_dup_names. ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53079.045020] [trace_demo_dup_names] do_filp_open.entry pid=263907 comm=demo_dup_names. dfd=4294967196 pathname=ffff898e8c88f000 op=ffffcc9700ae3bb4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53079.045023] [trace_demo_dup_names] do_filp_open.ret pid=263907 comm=demo_dup_names. ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53079.045026] [trace_demo_dup_names] do_filp_open.entry pid=263907 comm=demo_dup_names. dfd=4294967196 pathname=ffff898e8c88f000 op=ffffcc9700ae3cc4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53079.045029] [trace_demo_dup_names] do_filp_open.ret pid=263907 comm=demo_dup_names. ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53079.045033] [trace_demo_dup_names] do_filp_open.entry pid=263907 comm=demo_dup_names. dfd=4294967196 pathname=ffff898e8c88f000 op=ffffcc9700ae3db4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53079.045037] [trace_demo_dup_names] do_filp_open.ret pid=263907 comm=demo_dup_names. ret=ffff898ebd8cd240`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53079.045057] [trace_demo_dup_names] do_filp_open.entry pid=263907 comm=demo_dup_names. dfd=4294967196 pathname=ffff898e8c88f000 op=ffffcc9700ae3d54`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53079.045062] [trace_demo_dup_names] do_filp_open.ret pid=263907 comm=demo_dup_names. ret=ffff898ebd8cde40`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53079.045267] [trace_demo_dup_names] do_filp_open.entry pid=263907 comm=demo_dup_names. dfd=4294967196 pathname=ffff898e8c88f000 op=ffffcc9700ae3c84`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53079.045273] [trace_demo_dup_names] do_filp_open.ret pid=263907 comm=demo_dup_names. ret=ffff898ebd8cd240`
- #19. call=`do_filp_open.entry` source_line=`dmesg:20` raw=`[53079.045279] [trace_demo_dup_names] do_filp_open.entry pid=263907 comm=demo_dup_names. dfd=4294967196 pathname=ffff898e8c88f000 op=ffffcc9700ae3ba4`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53079.045283] [trace_demo_dup_names] do_filp_open.ret pid=263907 comm=demo_dup_names. ret=ffff898ebd8cd240`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=10 ret=10
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case1/reports/demo_dup_names_trace_report.md`
- dmesg: `kernel/user/stage3/case1/reports/demo_dup_names_dmesg.txt`
