# Worksheet: manual_dentry_check

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case1/manual_dentry_check.c`
- Driver: `kernel/drivers/stage3/case1/trace_manual_dentry_check/trace_manual_dentry_check.c`
- Module: `trace_manual_dentry_check`
- Binary: `kernel/user/stage3/case1/manual_dentry_check.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 8
- `do_filp_open.ret`: 8
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53085.650013] [trace_manual_dentry_check] do_filp_open.entry pid=265472 comm=manual_dentry_c dfd=4294967196 pathname=ffff898e8c88b000 op=ffffcc9702657c04`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53085.650025] [trace_manual_dentry_check] do_filp_open.ret pid=265472 comm=manual_dentry_c ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53085.650031] [trace_manual_dentry_check] do_filp_open.entry pid=265472 comm=manual_dentry_c dfd=4294967196 pathname=ffff898e8c88b000 op=ffffcc9702657ce4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53085.650036] [trace_manual_dentry_check] do_filp_open.ret pid=265472 comm=manual_dentry_c ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53085.650042] [trace_manual_dentry_check] do_filp_open.entry pid=265472 comm=manual_dentry_c dfd=4294967196 pathname=ffff898e8c88b000 op=ffffcc9702657d74`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53085.650047] [trace_manual_dentry_check] do_filp_open.ret pid=265472 comm=manual_dentry_c ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53085.650054] [trace_manual_dentry_check] do_filp_open.entry pid=265472 comm=manual_dentry_c dfd=4294967196 pathname=ffff898e8c88b000 op=ffffcc9702657cb4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53085.650057] [trace_manual_dentry_check] do_filp_open.ret pid=265472 comm=manual_dentry_c ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53085.650060] [trace_manual_dentry_check] do_filp_open.entry pid=265472 comm=manual_dentry_c dfd=4294967196 pathname=ffff898e8c88b000 op=ffffcc9702657c14`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53085.650064] [trace_manual_dentry_check] do_filp_open.ret pid=265472 comm=manual_dentry_c ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53085.650067] [trace_manual_dentry_check] do_filp_open.entry pid=265472 comm=manual_dentry_c dfd=4294967196 pathname=ffff898e8c88b000 op=ffffcc9702657e14`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53085.650070] [trace_manual_dentry_check] do_filp_open.ret pid=265472 comm=manual_dentry_c ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53085.650074] [trace_manual_dentry_check] do_filp_open.entry pid=265472 comm=manual_dentry_c dfd=4294967196 pathname=ffff898e8c88b000 op=ffffcc9702657db4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53085.650078] [trace_manual_dentry_check] do_filp_open.ret pid=265472 comm=manual_dentry_c ret=ffff898e90e94f00`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53085.650098] [trace_manual_dentry_check] do_filp_open.entry pid=265472 comm=manual_dentry_c dfd=4294967196 pathname=ffff898e8c88b000 op=ffffcc9702657af4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53085.650102] [trace_manual_dentry_check] do_filp_open.ret pid=265472 comm=manual_dentry_c ret=ffff898e90e94c00`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=8 ret=8
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case1/reports/manual_dentry_check_trace_report.md`
- dmesg: `kernel/user/stage3/case1/reports/manual_dentry_check_dmesg.txt`
