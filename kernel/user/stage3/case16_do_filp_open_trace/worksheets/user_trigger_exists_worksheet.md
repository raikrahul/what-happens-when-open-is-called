# Worksheet: user_trigger_exists

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists.c`
- Driver: `kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_exists/trace_user_trigger_exists.c`
- Module: `trace_user_trigger_exists`
- Binary: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 10
- `do_filp_open.ret`: 10
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 4

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53097.932232] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fb44`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53097.932245] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53097.932251] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fae4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53097.932256] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53097.932262] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fc74`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53097.932266] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53097.932273] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fdd4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53097.932277] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53097.932280] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fc44`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53097.932283] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53097.932286] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fb04`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53097.932290] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53097.932293] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fcf4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53097.932298] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=ffff898eb8d03a80`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53097.932315] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fbc4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53097.932320] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=ffff898eb8d03f00`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53097.932503] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fe64`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53097.932511] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=ffff898eb8d03a80`
- #19. call=`do_filp_open.entry` source_line=`dmesg:20` raw=`[53097.932558] [trace_user_trigger_exists] do_filp_open.entry pid=268423 comm=user_trigger_ex dfd=4294967196 pathname=ffff898e881d1000 op=ffffcc9701d8fbe4`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53097.932563] [trace_user_trigger_exists] do_filp_open.ret pid=268423 comm=user_trigger_ex ret=ffff898eb8d03a80`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=10 ret=10
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_trace_report.md`
- dmesg: `kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_dmesg.txt`
