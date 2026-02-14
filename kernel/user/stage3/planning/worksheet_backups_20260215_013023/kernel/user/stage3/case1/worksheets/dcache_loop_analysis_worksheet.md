# Worksheet: dcache_loop_analysis

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case1/dcache_loop_analysis.c`
- Driver: `kernel/drivers/stage3/case1/trace_dcache_loop_analysis/trace_dcache_loop_analysis.c`
- Module: `trace_dcache_loop_analysis`
- Binary: `kernel/user/stage3/case1/dcache_loop_analysis.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 8
- `do_filp_open.ret`: 8
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53076.967078] [trace_dcache_loop_analysis] do_filp_open.entry pid=263391 comm=dcache_loop_ana dfd=4294967196 pathname=ffff898e8f377000 op=ffffcc9701e8fc84`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53076.967091] [trace_dcache_loop_analysis] do_filp_open.ret pid=263391 comm=dcache_loop_ana ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53076.967098] [trace_dcache_loop_analysis] do_filp_open.entry pid=263391 comm=dcache_loop_ana dfd=4294967196 pathname=ffff898e8f377000 op=ffffcc9701e8fce4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53076.967103] [trace_dcache_loop_analysis] do_filp_open.ret pid=263391 comm=dcache_loop_ana ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53076.967108] [trace_dcache_loop_analysis] do_filp_open.entry pid=263391 comm=dcache_loop_ana dfd=4294967196 pathname=ffff898e8f377000 op=ffffcc9701e8fc04`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53076.967113] [trace_dcache_loop_analysis] do_filp_open.ret pid=263391 comm=dcache_loop_ana ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53076.967120] [trace_dcache_loop_analysis] do_filp_open.entry pid=263391 comm=dcache_loop_ana dfd=4294967196 pathname=ffff898e8f377000 op=ffffcc9701e8fe54`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53076.967124] [trace_dcache_loop_analysis] do_filp_open.ret pid=263391 comm=dcache_loop_ana ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53076.967127] [trace_dcache_loop_analysis] do_filp_open.entry pid=263391 comm=dcache_loop_ana dfd=4294967196 pathname=ffff898e8f377000 op=ffffcc9701e8fd84`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53076.967130] [trace_dcache_loop_analysis] do_filp_open.ret pid=263391 comm=dcache_loop_ana ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53076.967133] [trace_dcache_loop_analysis] do_filp_open.entry pid=263391 comm=dcache_loop_ana dfd=4294967196 pathname=ffff898e8f377000 op=ffffcc9701e8fb44`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53076.967137] [trace_dcache_loop_analysis] do_filp_open.ret pid=263391 comm=dcache_loop_ana ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53076.967140] [trace_dcache_loop_analysis] do_filp_open.entry pid=263391 comm=dcache_loop_ana dfd=4294967196 pathname=ffff898e8f377000 op=ffffcc9701e8fd14`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53076.967145] [trace_dcache_loop_analysis] do_filp_open.ret pid=263391 comm=dcache_loop_ana ret=ffff898eb832a6c0`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53076.967161] [trace_dcache_loop_analysis] do_filp_open.entry pid=263391 comm=dcache_loop_ana dfd=4294967196 pathname=ffff898e8f377000 op=ffffcc9701e8fb94`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53076.967167] [trace_dcache_loop_analysis] do_filp_open.ret pid=263391 comm=dcache_loop_ana ret=ffff898e8e00ef00`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=8 ret=8
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case1/reports/dcache_loop_analysis_trace_report.md`
- dmesg: `kernel/user/stage3/case1/reports/dcache_loop_analysis_dmesg.txt`
