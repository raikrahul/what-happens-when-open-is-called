# Worksheet: user_rename

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case8_creation_proof/user_rename.c`
- Driver: `kernel/drivers/stage3/case8_creation_proof/trace_user_rename/trace_user_rename.c`
- Module: `trace_user_rename`
- Binary: `kernel/user/stage3/case8_creation_proof/user_rename.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 9
- `do_filp_open.ret`: 9
- `__d_alloc.entry`: 1
- `__d_alloc.ret`: 1
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 3

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53122.153426] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203c74`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53122.153440] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53122.153446] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203e04`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53122.153451] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53122.153456] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203b94`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53122.153461] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53122.153468] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203dd4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53122.153472] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53122.153475] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203e24`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53122.153478] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53122.153481] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203ae4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53122.153485] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53122.153488] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203b74`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53122.153493] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=ffff898fe2998300`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53122.153511] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203e34`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53122.153517] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=ffff898da2b6ee40`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53122.153695] [trace_user_rename] do_filp_open.entry pid=272859 comm=user_rename.out dfd=4294967196 pathname=ffff898e8c9e2000 op=ffffcc9702203b14`
- #18. call=`__d_alloc.entry` source_line=`dmesg:19` raw=`[53122.153700] [trace_user_rename] __d_alloc.entry pid=272859 comm=user_rename.out sb=ffff898e906aa000 name_qstr=ffffcc97022039e0`
- #19. call=`__d_alloc.ret` source_line=`dmesg:20` raw=`[53122.153704] [trace_user_rename] __d_alloc.ret pid=272859 comm=user_rename.out dentry=ffff89914d1233c0`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53122.153753] [trace_user_rename] do_filp_open.ret pid=272859 comm=user_rename.out ret=ffff898da2b6ef00`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=9 ret=9
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=1 ret=1

## Raw Artifacts
- report: `kernel/user/stage3/case8_creation_proof/reports/user_rename_trace_report.md`
- dmesg: `kernel/user/stage3/case8_creation_proof/reports/user_rename_dmesg.txt`
