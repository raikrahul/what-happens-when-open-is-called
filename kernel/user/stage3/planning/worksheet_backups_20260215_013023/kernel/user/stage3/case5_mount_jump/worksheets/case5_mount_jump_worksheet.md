# Worksheet: case5_mount_jump

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case5_mount_jump/case5_mount_jump.c`
- Driver: `kernel/drivers/stage3/case5_mount_jump/trace_case5_mount_jump/trace_case5_mount_jump.c`
- Module: `trace_case5_mount_jump`
- Binary: `kernel/user/stage3/case5_mount_jump/case5_mount_jump.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 7
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53112.110737] [trace_case5_mount_jump] do_filp_open.entry pid=270526 comm=case5_mount_jum dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700763de4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53112.110759] [trace_case5_mount_jump] do_filp_open.ret pid=270526 comm=case5_mount_jum ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53112.110773] [trace_case5_mount_jump] do_filp_open.entry pid=270526 comm=case5_mount_jum dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700763e44`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53112.110784] [trace_case5_mount_jump] do_filp_open.ret pid=270526 comm=case5_mount_jum ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53112.110796] [trace_case5_mount_jump] do_filp_open.entry pid=270526 comm=case5_mount_jum dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700763d84`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53112.110807] [trace_case5_mount_jump] do_filp_open.ret pid=270526 comm=case5_mount_jum ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53112.110822] [trace_case5_mount_jump] do_filp_open.entry pid=270526 comm=case5_mount_jum dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700763af4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53112.110829] [trace_case5_mount_jump] do_filp_open.ret pid=270526 comm=case5_mount_jum ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53112.110836] [trace_case5_mount_jump] do_filp_open.entry pid=270526 comm=case5_mount_jum dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700763da4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53112.110843] [trace_case5_mount_jump] do_filp_open.ret pid=270526 comm=case5_mount_jum ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53112.110850] [trace_case5_mount_jump] do_filp_open.entry pid=270526 comm=case5_mount_jum dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700763dd4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53112.110858] [trace_case5_mount_jump] do_filp_open.ret pid=270526 comm=case5_mount_jum ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53112.110865] [trace_case5_mount_jump] do_filp_open.entry pid=270526 comm=case5_mount_jum dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700763e54`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53112.110880] [trace_case5_mount_jump] do_filp_open.ret pid=270526 comm=case5_mount_jum ret=ffff898f8b10ae40`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53112.110912] [trace_case5_mount_jump] do_filp_open.entry pid=270526 comm=case5_mount_jum dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700763b04`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53112.110922] [trace_case5_mount_jump] do_filp_open.ret pid=270526 comm=case5_mount_jum ret=ffff898f8b10a9c0`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53112.111330] [trace_case5_mount_jump] do_filp_open.entry pid=270526 comm=case5_mount_jum dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700763d84`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53112.111341] [trace_case5_mount_jump] do_filp_open.ret pid=270526 comm=case5_mount_jum ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case5_mount_jump/reports/case5_mount_jump_trace_report.md`
- dmesg: `kernel/user/stage3/case5_mount_jump/reports/case5_mount_jump_dmesg.txt`
