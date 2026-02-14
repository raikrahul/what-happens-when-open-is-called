# Worksheet: user_hash_collision

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case8_creation_proof/user_hash_collision.c`
- Driver: `kernel/drivers/stage3/case8_creation_proof/trace_user_hash_collision/trace_user_hash_collision.c`
- Module: `trace_user_hash_collision`
- Binary: `kernel/user/stage3/case8_creation_proof/user_hash_collision.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 11
- `do_filp_open.ret`: 11
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 5

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53119.951055] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebcc4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53119.951068] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53119.951074] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebcf4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53119.951079] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53119.951085] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebb54`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53119.951090] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53119.951096] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebad4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53119.951100] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53119.951103] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebbd4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53119.951106] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53119.951109] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebc84`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53119.951113] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53119.951116] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebbc4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53119.951121] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=ffff898fe24fd9c0`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53119.951138] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebbf4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53119.951143] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=ffff898fe24fd3c0`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53119.951331] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebd14`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53119.951338] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=ffffffffffffffef`
- #19. call=`do_filp_open.entry` source_line=`dmesg:20` raw=`[53119.951342] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebd94`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53119.951346] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=ffffffffffffffef`
- #21. call=`do_filp_open.entry` source_line=`dmesg:22` raw=`[53119.951349] [trace_user_hash_collision] do_filp_open.entry pid=272345 comm=user_hash_colli dfd=4294967196 pathname=ffff898e99619000 op=ffffcc97007ebb34`
- #22. call=`do_filp_open.ret` source_line=`dmesg:23` raw=`[53119.951353] [trace_user_hash_collision] do_filp_open.ret pid=272345 comm=user_hash_colli ret=ffffffffffffffef`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=11 ret=11
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case8_creation_proof/reports/user_hash_collision_trace_report.md`
- dmesg: `kernel/user/stage3/case8_creation_proof/reports/user_hash_collision_dmesg.txt`
