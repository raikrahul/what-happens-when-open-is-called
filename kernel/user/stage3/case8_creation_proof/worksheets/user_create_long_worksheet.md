# Worksheet: user_create_long

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case8_creation_proof/user_create_long.c`
- Driver: `kernel/drivers/stage3/case8_creation_proof/trace_user_create_long/trace_user_create_long.c`
- Module: `trace_user_create_long`
- Binary: `kernel/user/stage3/case8_creation_proof/user_create_long.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 3

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53117.685041] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07d84`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53117.685067] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53117.685085] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07de4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53117.685099] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53117.685114] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07ba4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53117.685128] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53117.685147] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07d74`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53117.685157] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53117.685165] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07df4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53117.685175] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53117.685183] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07c64`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53117.685193] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53117.685202] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07c44`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53117.685214] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=ffff898fee51a6c0`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53117.685264] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07c04`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53117.685278] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=ffff898e93581600`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53117.685752] [trace_user_create_long] do_filp_open.entry pid=271817 comm=user_create_lon dfd=4294967196 pathname=ffff898e8d73f000 op=ffffcc9701f07e24`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53117.685769] [trace_user_create_long] do_filp_open.ret pid=271817 comm=user_create_lon ret=ffffffffffffffef`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case8_creation_proof/reports/user_create_long_trace_report.md`
- dmesg: `kernel/user/stage3/case8_creation_proof/reports/user_create_long_dmesg.txt`
