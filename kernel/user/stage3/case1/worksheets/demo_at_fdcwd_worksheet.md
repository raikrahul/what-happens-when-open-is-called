# Worksheet: demo_at_fdcwd

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case1/demo_at_fdcwd/demo_at_fdcwd.c`
- Driver: `kernel/drivers/stage3/case1/trace_demo_at_fdcwd/trace_demo_at_fdcwd.c`
- Module: `trace_demo_at_fdcwd`
- Binary: `kernel/user/stage3/case1/demo_at_fdcwd/demo_at_fdcwd.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 11
- `do_filp_open.ret`: 11
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 5

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53078.062813] [trace_demo_at_fdcwd] do_filp_open.entry pid=263648 comm=demo_at_fdcwd.o dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc9701d8fb14`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53078.062834] [trace_demo_at_fdcwd] do_filp_open.ret pid=263648 comm=demo_at_fdcwd.o ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53078.062848] [trace_demo_at_fdcwd] do_filp_open.entry pid=263648 comm=demo_at_fdcwd.o dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc9701d8fb94`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53078.062859] [trace_demo_at_fdcwd] do_filp_open.ret pid=263648 comm=demo_at_fdcwd.o ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53078.062871] [trace_demo_at_fdcwd] do_filp_open.entry pid=263648 comm=demo_at_fdcwd.o dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc9701d8fad4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53078.062882] [trace_demo_at_fdcwd] do_filp_open.ret pid=263648 comm=demo_at_fdcwd.o ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53078.062896] [trace_demo_at_fdcwd] do_filp_open.entry pid=263648 comm=demo_at_fdcwd.o dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc9701d8fae4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53078.062904] [trace_demo_at_fdcwd] do_filp_open.ret pid=263648 comm=demo_at_fdcwd.o ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53078.062911] [trace_demo_at_fdcwd] do_filp_open.entry pid=263648 comm=demo_at_fdcwd.o dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc9701d8fde4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53078.062918] [trace_demo_at_fdcwd] do_filp_open.ret pid=263648 comm=demo_at_fdcwd.o ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53078.062925] [trace_demo_at_fdcwd] do_filp_open.entry pid=263648 comm=demo_at_fdcwd.o dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc9701d8fc24`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53078.062932] [trace_demo_at_fdcwd] do_filp_open.ret pid=263648 comm=demo_at_fdcwd.o ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53078.062940] [trace_demo_at_fdcwd] do_filp_open.entry pid=263648 comm=demo_at_fdcwd.o dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc9701d8fd74`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53078.062950] [trace_demo_at_fdcwd] do_filp_open.ret pid=263648 comm=demo_at_fdcwd.o ret=ffff898e98b3d180`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53078.062987] [trace_demo_at_fdcwd] do_filp_open.entry pid=263648 comm=demo_at_fdcwd.o dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc9701d8fb94`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53078.062998] [trace_demo_at_fdcwd] do_filp_open.ret pid=263648 comm=demo_at_fdcwd.o ret=ffff898e98b3d300`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53078.063387] [trace_demo_at_fdcwd] do_filp_open.entry pid=263648 comm=demo_at_fdcwd.o dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc9701d8fdc4`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53078.063474] [trace_demo_at_fdcwd] do_filp_open.ret pid=263648 comm=demo_at_fdcwd.o ret=ffff898e98b3d180`
- #19. call=`do_filp_open.entry` source_line=`dmesg:20` raw=`[53078.063490] [trace_demo_at_fdcwd] do_filp_open.entry pid=263648 comm=demo_at_fdcwd.o dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc9701d8fac4`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53078.063533] [trace_demo_at_fdcwd] do_filp_open.ret pid=263648 comm=demo_at_fdcwd.o ret=ffff898e98b3d240`
- #21. call=`do_filp_open.entry` source_line=`dmesg:22` raw=`[53078.063541] [trace_demo_at_fdcwd] do_filp_open.entry pid=263648 comm=demo_at_fdcwd.o dfd=4294967196 pathname=ffff898e8d77d000 op=ffffcc9701d8faf4`
- #22. call=`do_filp_open.ret` source_line=`dmesg:23` raw=`[53078.063629] [trace_demo_at_fdcwd] do_filp_open.ret pid=263648 comm=demo_at_fdcwd.o ret=ffff898e98b3d9c0`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=11 ret=11
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case1/reports/demo_at_fdcwd_trace_report.md`
- dmesg: `kernel/user/stage3/case1/reports/demo_at_fdcwd_dmesg.txt`
