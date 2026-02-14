# Worksheet: user_open_existing

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case8_creation_proof/user_open_existing.c`
- Driver: `kernel/drivers/stage3/case8_creation_proof/trace_user_open_existing/trace_user_open_existing.c`
- Module: `trace_user_open_existing`
- Binary: `kernel/user/stage3/case8_creation_proof/user_open_existing.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 7
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53121.047425] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfac4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53121.047437] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53121.047444] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfc34`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53121.047449] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53121.047454] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfb84`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53121.047459] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53121.047467] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfe84`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53121.047470] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53121.047473] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfdc4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53121.047476] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53121.047479] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfd64`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53121.047483] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53121.047486] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfc24`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53121.047491] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=ffff898fd33a1240`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53121.047509] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfd84`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53121.047514] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=ffff898fd33a1000`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53121.047696] [trace_user_open_existing] do_filp_open.entry pid=272602 comm=user_open_exist dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9700fcfe34`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53121.047701] [trace_user_open_existing] do_filp_open.ret pid=272602 comm=user_open_exist ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case8_creation_proof/reports/user_open_existing_trace_report.md`
- dmesg: `kernel/user/stage3/case8_creation_proof/reports/user_open_existing_dmesg.txt`
