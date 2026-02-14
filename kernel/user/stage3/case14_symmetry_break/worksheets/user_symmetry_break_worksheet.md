# Worksheet: user_symmetry_break

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case14_symmetry_break/user_symmetry_break.c`
- Driver: `kernel/drivers/stage3/case14_symmetry_break/trace_user_symmetry_break/trace_user_symmetry_break.c`
- Module: `trace_user_symmetry_break`
- Binary: `kernel/user/stage3/case14_symmetry_break/user_symmetry_break.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 10
- `do_filp_open.ret`: 10
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 4

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53094.747793] [trace_user_symmetry_break] do_filp_open.entry pid=267650 comm=user_symmetry_b dfd=4294967196 pathname=ffff898e8d738000 op=ffffcc9701f5bb84`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53094.747820] [trace_user_symmetry_break] do_filp_open.ret pid=267650 comm=user_symmetry_b ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53094.747837] [trace_user_symmetry_break] do_filp_open.entry pid=267650 comm=user_symmetry_b dfd=4294967196 pathname=ffff898e8d738000 op=ffffcc9701f5bc54`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53094.747851] [trace_user_symmetry_break] do_filp_open.ret pid=267650 comm=user_symmetry_b ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53094.747892] [trace_user_symmetry_break] do_filp_open.entry pid=267650 comm=user_symmetry_b dfd=4294967196 pathname=ffff898e8d738000 op=ffffcc9701f5be74`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53094.747907] [trace_user_symmetry_break] do_filp_open.ret pid=267650 comm=user_symmetry_b ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53094.747926] [trace_user_symmetry_break] do_filp_open.entry pid=267650 comm=user_symmetry_b dfd=4294967196 pathname=ffff898e8d738000 op=ffffcc9701f5bd54`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53094.747936] [trace_user_symmetry_break] do_filp_open.ret pid=267650 comm=user_symmetry_b ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53094.747944] [trace_user_symmetry_break] do_filp_open.entry pid=267650 comm=user_symmetry_b dfd=4294967196 pathname=ffff898e8d738000 op=ffffcc9701f5bc24`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53094.747954] [trace_user_symmetry_break] do_filp_open.ret pid=267650 comm=user_symmetry_b ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53094.747963] [trace_user_symmetry_break] do_filp_open.entry pid=267650 comm=user_symmetry_b dfd=4294967196 pathname=ffff898e8d738000 op=ffffcc9701f5bd34`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53094.747973] [trace_user_symmetry_break] do_filp_open.ret pid=267650 comm=user_symmetry_b ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53094.747983] [trace_user_symmetry_break] do_filp_open.entry pid=267650 comm=user_symmetry_b dfd=4294967196 pathname=ffff898e8d738000 op=ffffcc9701f5bcf4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53094.747996] [trace_user_symmetry_break] do_filp_open.ret pid=267650 comm=user_symmetry_b ret=ffff89901398b900`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53094.748040] [trace_user_symmetry_break] do_filp_open.entry pid=267650 comm=user_symmetry_b dfd=4294967196 pathname=ffff898e8d738000 op=ffffcc9701f5bad4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53094.748053] [trace_user_symmetry_break] do_filp_open.ret pid=267650 comm=user_symmetry_b ret=ffff89901398b480`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53094.748500] [trace_user_symmetry_break] do_filp_open.entry pid=267650 comm=user_symmetry_b dfd=4294967196 pathname=ffff898e8d738000 op=ffffcc9701f5bb84`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53094.748516] [trace_user_symmetry_break] do_filp_open.ret pid=267650 comm=user_symmetry_b ret=ffff89901398b900`
- #19. call=`do_filp_open.entry` source_line=`dmesg:20` raw=`[53094.748529] [trace_user_symmetry_break] do_filp_open.entry pid=267650 comm=user_symmetry_b dfd=4294967196 pathname=ffff898e8d738000 op=ffffcc9701f5bdb4`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53094.748541] [trace_user_symmetry_break] do_filp_open.ret pid=267650 comm=user_symmetry_b ret=ffff89901398b900`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=10 ret=10
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case14_symmetry_break/reports/user_symmetry_break_trace_report.md`
- dmesg: `kernel/user/stage3/case14_symmetry_break/reports/user_symmetry_break_dmesg.txt`
