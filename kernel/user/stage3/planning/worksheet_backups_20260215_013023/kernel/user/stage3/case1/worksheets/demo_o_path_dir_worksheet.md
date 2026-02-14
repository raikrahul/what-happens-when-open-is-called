# Worksheet: demo_o_path_dir

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case1/demo_o_path/demo_o_path_dir.c`
- Driver: `kernel/drivers/stage3/case1/trace_demo_o_path_dir/trace_demo_o_path_dir.c`
- Module: `trace_demo_o_path_dir`
- Binary: `kernel/user/stage3/case1/demo_o_path/demo_o_path_dir.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 11
- `do_filp_open.ret`: 11
- `__d_alloc.entry`: 1
- `__d_alloc.ret`: 1
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 5

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53081.179539] [trace_demo_o_path_dir] do_filp_open.entry pid=264427 comm=demo_o_path_dir dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc970256fc74`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53081.179560] [trace_demo_o_path_dir] do_filp_open.ret pid=264427 comm=demo_o_path_dir ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53081.179574] [trace_demo_o_path_dir] do_filp_open.entry pid=264427 comm=demo_o_path_dir dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc970256fb74`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53081.179585] [trace_demo_o_path_dir] do_filp_open.ret pid=264427 comm=demo_o_path_dir ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53081.179597] [trace_demo_o_path_dir] do_filp_open.entry pid=264427 comm=demo_o_path_dir dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc970256fab4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53081.179609] [trace_demo_o_path_dir] do_filp_open.ret pid=264427 comm=demo_o_path_dir ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53081.179624] [trace_demo_o_path_dir] do_filp_open.entry pid=264427 comm=demo_o_path_dir dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc970256fcc4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53081.179632] [trace_demo_o_path_dir] do_filp_open.ret pid=264427 comm=demo_o_path_dir ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53081.179638] [trace_demo_o_path_dir] do_filp_open.entry pid=264427 comm=demo_o_path_dir dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc970256faf4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53081.179646] [trace_demo_o_path_dir] do_filp_open.ret pid=264427 comm=demo_o_path_dir ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53081.179653] [trace_demo_o_path_dir] do_filp_open.entry pid=264427 comm=demo_o_path_dir dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc970256fcb4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53081.179660] [trace_demo_o_path_dir] do_filp_open.ret pid=264427 comm=demo_o_path_dir ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53081.179667] [trace_demo_o_path_dir] do_filp_open.entry pid=264427 comm=demo_o_path_dir dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc970256faa4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53081.179677] [trace_demo_o_path_dir] do_filp_open.ret pid=264427 comm=demo_o_path_dir ret=ffff898fd33a19c0`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53081.179711] [trace_demo_o_path_dir] do_filp_open.entry pid=264427 comm=demo_o_path_dir dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc970256fda4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53081.179721] [trace_demo_o_path_dir] do_filp_open.ret pid=264427 comm=demo_o_path_dir ret=ffff898fd33a16c0`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53081.180171] [trace_demo_o_path_dir] do_filp_open.entry pid=264427 comm=demo_o_path_dir dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc970256fb94`
- #18. call=`__d_alloc.entry` source_line=`dmesg:19` raw=`[53081.180183] [trace_demo_o_path_dir] __d_alloc.entry pid=264427 comm=demo_o_path_dir sb=ffff898e906aa000 name_qstr=ffffcc970256fa60`
- #19. call=`__d_alloc.ret` source_line=`dmesg:20` raw=`[53081.180190] [trace_demo_o_path_dir] __d_alloc.ret pid=264427 comm=demo_o_path_dir dentry=ffff8990110a5e40`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53081.180222] [trace_demo_o_path_dir] do_filp_open.ret pid=264427 comm=demo_o_path_dir ret=ffff898fd33a19c0`
- #21. call=`do_filp_open.entry` source_line=`dmesg:22` raw=`[53081.180302] [trace_demo_o_path_dir] do_filp_open.entry pid=264427 comm=demo_o_path_dir dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc970256fe24`
- #22. call=`do_filp_open.ret` source_line=`dmesg:23` raw=`[53081.180313] [trace_demo_o_path_dir] do_filp_open.ret pid=264427 comm=demo_o_path_dir ret=ffff898fd33a19c0`
- #23. call=`do_filp_open.entry` source_line=`dmesg:24` raw=`[53081.180370] [trace_demo_o_path_dir] do_filp_open.entry pid=264427 comm=demo_o_path_dir dfd=3 pathname=ffff898e8d77d000 op=ffffcc970256fca4`
- #24. call=`do_filp_open.ret` source_line=`dmesg:25` raw=`[53081.180384] [trace_demo_o_path_dir] do_filp_open.ret pid=264427 comm=demo_o_path_dir ret=ffff898fd33a1c00`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=11 ret=11
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=1 ret=1

## Raw Artifacts
- report: `kernel/user/stage3/case1/reports/demo_o_path_dir_trace_report.md`
- dmesg: `kernel/user/stage3/case1/reports/demo_o_path_dir_dmesg.txt`
