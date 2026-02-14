# Worksheet: case1_relative

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case1/case1_relative/case1_relative.c`
- Driver: `kernel/drivers/stage3/case1/trace_case1_relative/trace_case1_relative.c`
- Module: `trace_case1_relative`
- Binary: `kernel/user/stage3/case1/case1_relative/case1_relative.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 3

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53073.614222] [trace_case1_relative] do_filp_open.entry pid=262617 comm=case1_relative. dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97025cbe24`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53073.614245] [trace_case1_relative] do_filp_open.ret pid=262617 comm=case1_relative. ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53073.614259] [trace_case1_relative] do_filp_open.entry pid=262617 comm=case1_relative. dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97025cbc54`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53073.614270] [trace_case1_relative] do_filp_open.ret pid=262617 comm=case1_relative. ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53073.614282] [trace_case1_relative] do_filp_open.entry pid=262617 comm=case1_relative. dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97025cbb14`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53073.614293] [trace_case1_relative] do_filp_open.ret pid=262617 comm=case1_relative. ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53073.614307] [trace_case1_relative] do_filp_open.entry pid=262617 comm=case1_relative. dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97025cbc04`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53073.614315] [trace_case1_relative] do_filp_open.ret pid=262617 comm=case1_relative. ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53073.614322] [trace_case1_relative] do_filp_open.entry pid=262617 comm=case1_relative. dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97025cbd14`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53073.614329] [trace_case1_relative] do_filp_open.ret pid=262617 comm=case1_relative. ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53073.614336] [trace_case1_relative] do_filp_open.entry pid=262617 comm=case1_relative. dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97025cbda4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53073.614343] [trace_case1_relative] do_filp_open.ret pid=262617 comm=case1_relative. ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53073.614351] [trace_case1_relative] do_filp_open.entry pid=262617 comm=case1_relative. dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97025cbba4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53073.614361] [trace_case1_relative] do_filp_open.ret pid=262617 comm=case1_relative. ret=ffff898e8397e300`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53073.614400] [trace_case1_relative] do_filp_open.entry pid=262617 comm=case1_relative. dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97025cbaf4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53073.614410] [trace_case1_relative] do_filp_open.ret pid=262617 comm=case1_relative. ret=ffff898e8397ec00`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53073.614773] [trace_case1_relative] do_filp_open.entry pid=262617 comm=case1_relative. dfd=4294967196 pathname=ffff898e8d700000 op=ffffcc97025cbab4`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53073.614786] [trace_case1_relative] do_filp_open.ret pid=262617 comm=case1_relative. ret=ffff898e8397e300`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case1/reports/case1_relative_trace_report.md`
- dmesg: `kernel/user/stage3/case1/reports/case1_relative_dmesg.txt`
