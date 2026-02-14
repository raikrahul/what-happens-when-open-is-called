# Worksheet: case6_symlink_loop

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case1/case6_symlink_loop.c`
- Driver: `kernel/drivers/stage3/case1/trace_case6_symlink_loop/trace_case6_symlink_loop.c`
- Module: `trace_case6_symlink_loop`
- Binary: `kernel/user/stage3/case1/case6_symlink_loop.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 7
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53074.698944] [trace_case6_symlink_loop] do_filp_open.entry pid=262876 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc970241be54`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53074.698966] [trace_case6_symlink_loop] do_filp_open.ret pid=262876 comm=case6_symlink_l ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53074.698980] [trace_case6_symlink_loop] do_filp_open.entry pid=262876 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc970241bae4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53074.698991] [trace_case6_symlink_loop] do_filp_open.ret pid=262876 comm=case6_symlink_l ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53074.699003] [trace_case6_symlink_loop] do_filp_open.entry pid=262876 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc970241bc64`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53074.699014] [trace_case6_symlink_loop] do_filp_open.ret pid=262876 comm=case6_symlink_l ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53074.699029] [trace_case6_symlink_loop] do_filp_open.entry pid=262876 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc970241bb04`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53074.699037] [trace_case6_symlink_loop] do_filp_open.ret pid=262876 comm=case6_symlink_l ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53074.699044] [trace_case6_symlink_loop] do_filp_open.entry pid=262876 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc970241bb24`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53074.699051] [trace_case6_symlink_loop] do_filp_open.ret pid=262876 comm=case6_symlink_l ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53074.699058] [trace_case6_symlink_loop] do_filp_open.entry pid=262876 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc970241bd84`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53074.699065] [trace_case6_symlink_loop] do_filp_open.ret pid=262876 comm=case6_symlink_l ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53074.699072] [trace_case6_symlink_loop] do_filp_open.entry pid=262876 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc970241bae4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53074.699083] [trace_case6_symlink_loop] do_filp_open.ret pid=262876 comm=case6_symlink_l ret=ffff898e840cacc0`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53074.699122] [trace_case6_symlink_loop] do_filp_open.entry pid=262876 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc970241bd14`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53074.699133] [trace_case6_symlink_loop] do_filp_open.ret pid=262876 comm=case6_symlink_l ret=ffff89913780dcc0`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53074.699467] [trace_case6_symlink_loop] do_filp_open.entry pid=262876 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e819b1000 op=ffffcc970241baa4`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53074.699480] [trace_case6_symlink_loop] do_filp_open.ret pid=262876 comm=case6_symlink_l ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case1/reports/case6_symlink_loop_trace_report.md`
- dmesg: `kernel/user/stage3/case1/reports/case6_symlink_loop_dmesg.txt`
