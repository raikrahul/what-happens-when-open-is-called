# Worksheet: case6_symlink_loop

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case6_symlink_loop/case6_symlink_loop.c`
- Driver: `kernel/drivers/stage3/case6_symlink_loop/trace_case6_symlink_loop/trace_case6_symlink_loop.c`
- Module: `trace_case6_symlink_loop`
- Binary: `kernel/user/stage3/case6_symlink_loop/case6_symlink_loop.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 7
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53113.166487] [trace_case6_symlink_loop] do_filp_open.entry pid=270783 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc970246bd24`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53113.166500] [trace_case6_symlink_loop] do_filp_open.ret pid=270783 comm=case6_symlink_l ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53113.166506] [trace_case6_symlink_loop] do_filp_open.entry pid=270783 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc970246be74`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53113.166511] [trace_case6_symlink_loop] do_filp_open.ret pid=270783 comm=case6_symlink_l ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53113.166516] [trace_case6_symlink_loop] do_filp_open.entry pid=270783 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc970246bdd4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53113.166521] [trace_case6_symlink_loop] do_filp_open.ret pid=270783 comm=case6_symlink_l ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53113.166528] [trace_case6_symlink_loop] do_filp_open.entry pid=270783 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc970246bb14`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53113.166531] [trace_case6_symlink_loop] do_filp_open.ret pid=270783 comm=case6_symlink_l ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53113.166534] [trace_case6_symlink_loop] do_filp_open.entry pid=270783 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc970246bdc4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53113.166538] [trace_case6_symlink_loop] do_filp_open.ret pid=270783 comm=case6_symlink_l ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53113.166541] [trace_case6_symlink_loop] do_filp_open.entry pid=270783 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc970246bb94`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53113.166544] [trace_case6_symlink_loop] do_filp_open.ret pid=270783 comm=case6_symlink_l ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53113.166548] [trace_case6_symlink_loop] do_filp_open.entry pid=270783 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc970246bab4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53113.166553] [trace_case6_symlink_loop] do_filp_open.ret pid=270783 comm=case6_symlink_l ret=ffff89909a505600`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53113.166570] [trace_case6_symlink_loop] do_filp_open.entry pid=270783 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc970246bce4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53113.166575] [trace_case6_symlink_loop] do_filp_open.ret pid=270783 comm=case6_symlink_l ret=ffff89909a505540`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53113.166784] [trace_case6_symlink_loop] do_filp_open.entry pid=270783 comm=case6_symlink_l dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc970246bd84`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53113.166789] [trace_case6_symlink_loop] do_filp_open.ret pid=270783 comm=case6_symlink_l ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case6_symlink_loop/reports/case6_symlink_loop_trace_report.md`
- dmesg: `kernel/user/stage3/case6_symlink_loop/reports/case6_symlink_loop_dmesg.txt`
