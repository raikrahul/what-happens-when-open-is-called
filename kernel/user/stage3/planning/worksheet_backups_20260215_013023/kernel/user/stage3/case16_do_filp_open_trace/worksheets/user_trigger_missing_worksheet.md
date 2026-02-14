# Worksheet: user_trigger_missing

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_missing.c`
- Driver: `kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_missing/trace_user_trigger_missing.c`
- Module: `trace_user_trigger_missing`
- Binary: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_missing`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 7
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53099.124978] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783bf4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53099.125000] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53099.125013] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783da4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53099.125025] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53099.125037] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783d14`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53099.125048] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53099.125062] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783c54`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53099.125070] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53099.125077] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783b84`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53099.125084] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53099.125091] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783db4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53099.125099] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53099.125106] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783e54`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53099.125121] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=ffff898ea5f3d600`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53099.125160] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783b84`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53099.125171] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=ffff898ea5f3dc00`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53099.125809] [trace_user_trigger_missing] do_filp_open.entry pid=268681 comm=user_trigger_mi dfd=4294967196 pathname=ffff898e8d779000 op=ffffcc9700783cf4`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53099.125832] [trace_user_trigger_missing] do_filp_open.ret pid=268681 comm=user_trigger_mi ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_trace_report.md`
- dmesg: `kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_dmesg.txt`
