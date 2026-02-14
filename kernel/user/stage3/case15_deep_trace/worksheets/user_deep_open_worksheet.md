# Worksheet: user_deep_open

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case15_deep_trace/user_deep_open.c`
- Driver: `kernel/drivers/stage3/case15_deep_trace/trace_user_deep_open/trace_user_deep_open.c`
- Module: `trace_user_deep_open`
- Binary: `kernel/user/stage3/case15_deep_trace/user_deep_open.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 3

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53096.833441] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3bf4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53096.833466] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53096.833484] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3c04`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53096.833498] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53096.833513] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3bb4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53096.833527] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53096.833545] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3d94`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53096.833555] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53096.833563] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3aa4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53096.833573] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53096.833581] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3c44`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53096.833591] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53096.833600] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3b74`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53096.833613] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=ffff898eaaa05e40`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53096.833697] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3ac4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53096.833715] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=ffff898eaaa05000`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53096.834346] [trace_user_deep_open] do_filp_open.entry pid=268165 comm=user_deep_open. dfd=4294967196 pathname=ffff898e8c888000 op=ffffcc9700ae3e04`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53096.834368] [trace_user_deep_open] do_filp_open.ret pid=268165 comm=user_deep_open. ret=ffff898eaaa05e40`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case15_deep_trace/reports/user_deep_open_trace_report.md`
- dmesg: `kernel/user/stage3/case15_deep_trace/reports/user_deep_open_dmesg.txt`
