# Worksheet: user_trigger

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger.c`
- Driver: `kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger/trace_user_trigger.c`
- Module: `trace_user_trigger`
- Binary: `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 1
- `__d_alloc.ret`: 1
- `ERR_PTR(-ENOENT)` returns: 7
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53101.428112] [trace_user_trigger] do_filp_open.entry pid=269196 comm=user_trigger.ou dfd=4294967196 pathname=ffff898e8c9e7000 op=ffffcc9700737cc4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53101.428124] [trace_user_trigger] do_filp_open.ret pid=269196 comm=user_trigger.ou ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53101.428131] [trace_user_trigger] do_filp_open.entry pid=269196 comm=user_trigger.ou dfd=4294967196 pathname=ffff898e8c9e7000 op=ffffcc9700737e34`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53101.428136] [trace_user_trigger] do_filp_open.ret pid=269196 comm=user_trigger.ou ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53101.428141] [trace_user_trigger] do_filp_open.entry pid=269196 comm=user_trigger.ou dfd=4294967196 pathname=ffff898e8c9e7000 op=ffffcc9700737bb4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53101.428146] [trace_user_trigger] do_filp_open.ret pid=269196 comm=user_trigger.ou ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53101.428153] [trace_user_trigger] do_filp_open.entry pid=269196 comm=user_trigger.ou dfd=4294967196 pathname=ffff898e8c9e7000 op=ffffcc9700737d44`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53101.428157] [trace_user_trigger] do_filp_open.ret pid=269196 comm=user_trigger.ou ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53101.428160] [trace_user_trigger] do_filp_open.entry pid=269196 comm=user_trigger.ou dfd=4294967196 pathname=ffff898e8c9e7000 op=ffffcc9700737b04`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53101.428163] [trace_user_trigger] do_filp_open.ret pid=269196 comm=user_trigger.ou ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53101.428166] [trace_user_trigger] do_filp_open.entry pid=269196 comm=user_trigger.ou dfd=4294967196 pathname=ffff898e8c9e7000 op=ffffcc9700737c94`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53101.428170] [trace_user_trigger] do_filp_open.ret pid=269196 comm=user_trigger.ou ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53101.428173] [trace_user_trigger] do_filp_open.entry pid=269196 comm=user_trigger.ou dfd=4294967196 pathname=ffff898e8c9e7000 op=ffffcc9700737de4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53101.428178] [trace_user_trigger] do_filp_open.ret pid=269196 comm=user_trigger.ou ret=ffff898ea659ef00`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53101.428209] [trace_user_trigger] do_filp_open.entry pid=269196 comm=user_trigger.ou dfd=4294967196 pathname=ffff898e8c9e7000 op=ffffcc9700737ce4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53101.428216] [trace_user_trigger] do_filp_open.ret pid=269196 comm=user_trigger.ou ret=ffff898e87ef03c0`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53101.428474] [trace_user_trigger] do_filp_open.entry pid=269196 comm=user_trigger.ou dfd=4294967196 pathname=ffff898e8c9e7000 op=ffffcc9700737b14`
- #18. call=`__d_alloc.entry` source_line=`dmesg:19` raw=`[53101.428483] [trace_user_trigger] __d_alloc.entry pid=269196 comm=user_trigger.ou sb=ffff898e906aa000 name_qstr=ffffcc97007379e0`
- #19. call=`__d_alloc.ret` source_line=`dmesg:20` raw=`[53101.428488] [trace_user_trigger] __d_alloc.ret pid=269196 comm=user_trigger.ou dentry=ffff899011174180`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53101.428501] [trace_user_trigger] do_filp_open.ret pid=269196 comm=user_trigger.ou ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=1 ret=1

## Raw Artifacts
- report: `kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_trace_report.md`
- dmesg: `kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_dmesg.txt`
