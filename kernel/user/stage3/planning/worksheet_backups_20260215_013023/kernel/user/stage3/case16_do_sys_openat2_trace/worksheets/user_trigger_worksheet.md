# Worksheet: user_trigger

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case16_do_sys_openat2_trace/user_trigger.c`
- Driver: `kernel/drivers/stage3/case16_do_sys_openat2_trace/trace_user_trigger/trace_user_trigger.c`
- Module: `trace_user_trigger`
- Binary: `kernel/user/stage3/case16_do_sys_openat2_trace/user_trigger`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 7
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53100.273583] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3c04`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53100.273604] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53100.273618] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3be4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53100.273629] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53100.273641] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3bf4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53100.273652] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53100.273666] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3af4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53100.273674] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53100.273681] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3da4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53100.273688] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53100.273695] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3c94`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53100.273702] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53100.273709] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3e24`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53100.273719] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=ffff89901398b000`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53100.273758] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3d94`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53100.273769] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=ffff89901398b900`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53100.274160] [trace_user_trigger] do_filp_open.entry pid=268938 comm=user_trigger dfd=4294967196 pathname=ffff898e8c9a4000 op=ffffcc97023d3b5c`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53100.274170] [trace_user_trigger] do_filp_open.ret pid=268938 comm=user_trigger ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case16_do_sys_openat2_trace/reports/user_trigger_trace_report.md`
- dmesg: `kernel/user/stage3/case16_do_sys_openat2_trace/reports/user_trigger_dmesg.txt`
