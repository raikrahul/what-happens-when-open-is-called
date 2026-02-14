# Worksheet: demo_o_path

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case1/demo_o_path/demo_o_path.c`
- Driver: `kernel/drivers/stage3/case1/trace_demo_o_path/trace_demo_o_path.c`
- Module: `trace_demo_o_path`
- Binary: `kernel/user/stage3/case1/demo_o_path/demo_o_path.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 10
- `do_filp_open.ret`: 10
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 4

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53080.161836] [trace_demo_o_path] do_filp_open.entry pid=264166 comm=demo_o_path.out dfd=4294967196 pathname=ffff898e8f374000 op=ffffcc9700e3fb04`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53080.161863] [trace_demo_o_path] do_filp_open.ret pid=264166 comm=demo_o_path.out ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53080.161881] [trace_demo_o_path] do_filp_open.entry pid=264166 comm=demo_o_path.out dfd=4294967196 pathname=ffff898e8f374000 op=ffffcc9700e3fd64`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53080.161895] [trace_demo_o_path] do_filp_open.ret pid=264166 comm=demo_o_path.out ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53080.161910] [trace_demo_o_path] do_filp_open.entry pid=264166 comm=demo_o_path.out dfd=4294967196 pathname=ffff898e8f374000 op=ffffcc9700e3fe44`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53080.161924] [trace_demo_o_path] do_filp_open.ret pid=264166 comm=demo_o_path.out ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53080.161942] [trace_demo_o_path] do_filp_open.entry pid=264166 comm=demo_o_path.out dfd=4294967196 pathname=ffff898e8f374000 op=ffffcc9700e3fab4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53080.161952] [trace_demo_o_path] do_filp_open.ret pid=264166 comm=demo_o_path.out ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53080.161961] [trace_demo_o_path] do_filp_open.entry pid=264166 comm=demo_o_path.out dfd=4294967196 pathname=ffff898e8f374000 op=ffffcc9700e3fdc4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53080.161970] [trace_demo_o_path] do_filp_open.ret pid=264166 comm=demo_o_path.out ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53080.161978] [trace_demo_o_path] do_filp_open.entry pid=264166 comm=demo_o_path.out dfd=4294967196 pathname=ffff898e8f374000 op=ffffcc9700e3fc44`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53080.161988] [trace_demo_o_path] do_filp_open.ret pid=264166 comm=demo_o_path.out ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53080.161997] [trace_demo_o_path] do_filp_open.entry pid=264166 comm=demo_o_path.out dfd=4294967196 pathname=ffff898e8f374000 op=ffffcc9700e3fe04`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53080.162010] [trace_demo_o_path] do_filp_open.ret pid=264166 comm=demo_o_path.out ret=ffff898eb77dcb40`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53080.162058] [trace_demo_o_path] do_filp_open.entry pid=264166 comm=demo_o_path.out dfd=4294967196 pathname=ffff898e8f374000 op=ffffcc9700e3fbc4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53080.162071] [trace_demo_o_path] do_filp_open.ret pid=264166 comm=demo_o_path.out ret=ffff898f56ea4540`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53080.162599] [trace_demo_o_path] do_filp_open.entry pid=264166 comm=demo_o_path.out dfd=4294967196 pathname=ffff898e8f374000 op=ffffcc9700e3fc34`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53080.162703] [trace_demo_o_path] do_filp_open.ret pid=264166 comm=demo_o_path.out ret=ffff898eb77dcb40`
- #19. call=`do_filp_open.entry` source_line=`dmesg:20` raw=`[53080.162719] [trace_demo_o_path] do_filp_open.entry pid=264166 comm=demo_o_path.out dfd=4294967196 pathname=ffff898e8f374000 op=ffffcc9700e3fcf4`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53080.162730] [trace_demo_o_path] do_filp_open.ret pid=264166 comm=demo_o_path.out ret=ffff898eb77dcb40`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=10 ret=10
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case1/reports/demo_o_path_trace_report.md`
- dmesg: `kernel/user/stage3/case1/reports/demo_o_path_dmesg.txt`
