# Worksheet: demo_thread_safety

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case1/demo_thread_safety/demo_thread_safety.c`
- Driver: `kernel/drivers/stage3/case1/trace_demo_thread_safety/trace_demo_thread_safety.c`
- Module: `trace_demo_thread_safety`
- Binary: `kernel/user/stage3/case1/demo_thread_safety/demo_thread_safety.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 13
- `do_filp_open.ret`: 13
- `__d_alloc.entry`: 5
- `__d_alloc.ret`: 5
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 7

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53083.228559] [trace_demo_thread_safety] do_filp_open.entry pid=264946 comm=demo_thread_saf dfd=4294967196 pathname=ffff898e819b0000 op=ffffcc9702433cd4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53083.228588] [trace_demo_thread_safety] do_filp_open.ret pid=264946 comm=demo_thread_saf ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53083.228609] [trace_demo_thread_safety] do_filp_open.entry pid=264946 comm=demo_thread_saf dfd=4294967196 pathname=ffff898e819b0000 op=ffffcc9702433da4`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53083.228625] [trace_demo_thread_safety] do_filp_open.ret pid=264946 comm=demo_thread_saf ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53083.228642] [trace_demo_thread_safety] do_filp_open.entry pid=264946 comm=demo_thread_saf dfd=4294967196 pathname=ffff898e819b0000 op=ffffcc9702433e84`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53083.228659] [trace_demo_thread_safety] do_filp_open.ret pid=264946 comm=demo_thread_saf ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53083.228680] [trace_demo_thread_safety] do_filp_open.entry pid=264946 comm=demo_thread_saf dfd=4294967196 pathname=ffff898e819b0000 op=ffffcc9702433c54`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53083.228691] [trace_demo_thread_safety] do_filp_open.ret pid=264946 comm=demo_thread_saf ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53083.228701] [trace_demo_thread_safety] do_filp_open.entry pid=264946 comm=demo_thread_saf dfd=4294967196 pathname=ffff898e819b0000 op=ffffcc9702433bb4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53083.228712] [trace_demo_thread_safety] do_filp_open.ret pid=264946 comm=demo_thread_saf ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53083.228722] [trace_demo_thread_safety] do_filp_open.entry pid=264946 comm=demo_thread_saf dfd=4294967196 pathname=ffff898e819b0000 op=ffffcc9702433de4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53083.228733] [trace_demo_thread_safety] do_filp_open.ret pid=264946 comm=demo_thread_saf ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53083.228744] [trace_demo_thread_safety] do_filp_open.entry pid=264946 comm=demo_thread_saf dfd=4294967196 pathname=ffff898e819b0000 op=ffffcc9702433e54`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53083.228758] [trace_demo_thread_safety] do_filp_open.ret pid=264946 comm=demo_thread_saf ret=ffff898fd24af3c0`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53083.228807] [trace_demo_thread_safety] do_filp_open.entry pid=264946 comm=demo_thread_saf dfd=4294967196 pathname=ffff898e819b0000 op=ffffcc9702433be4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53083.228821] [trace_demo_thread_safety] do_filp_open.ret pid=264946 comm=demo_thread_saf ret=ffff898fd24af780`
- #17. call=`__d_alloc.entry` source_line=`dmesg:18` raw=`[53083.229356] [trace_demo_thread_safety] __d_alloc.entry pid=264946 comm=demo_thread_saf sb=ffff898e906aa000 name_qstr=ffffcc9702433c10`
- #18. call=`__d_alloc.ret` source_line=`dmesg:19` raw=`[53083.229375] [trace_demo_thread_safety] __d_alloc.ret pid=264946 comm=demo_thread_saf dentry=ffff89914d1c8840`
- #19. call=`__d_alloc.entry` source_line=`dmesg:20` raw=`[53083.229530] [trace_demo_thread_safety] __d_alloc.entry pid=264946 comm=demo_thread_saf sb=ffff898e906aa000 name_qstr=ffffcc9702433cf0`
- #20. call=`__d_alloc.ret` source_line=`dmesg:21` raw=`[53083.229546] [trace_demo_thread_safety] __d_alloc.ret pid=264946 comm=demo_thread_saf dentry=ffff89914d1c8480`
- #21. call=`__d_alloc.entry` source_line=`dmesg:22` raw=`[53083.229624] [trace_demo_thread_safety] __d_alloc.entry pid=264946 comm=demo_thread_saf sb=ffff898e906aa000 name_qstr=ffffcc9702433cb0`
- #22. call=`__d_alloc.ret` source_line=`dmesg:23` raw=`[53083.229642] [trace_demo_thread_safety] __d_alloc.ret pid=264946 comm=demo_thread_saf dentry=ffff8990e1406240`
- #23. call=`do_filp_open.entry` source_line=`dmesg:24` raw=`[53083.229715] [trace_demo_thread_safety] do_filp_open.entry pid=264946 comm=demo_thread_saf dfd=4294967196 pathname=ffff898e819b0000 op=ffffcc9702433b64`
- #24. call=`__d_alloc.entry` source_line=`dmesg:25` raw=`[53083.229732] [trace_demo_thread_safety] __d_alloc.entry pid=264946 comm=demo_thread_saf sb=ffff898e906aa000 name_qstr=ffffcc9702433a30`
- #25. call=`__d_alloc.ret` source_line=`dmesg:26` raw=`[53083.229742] [trace_demo_thread_safety] __d_alloc.ret pid=264946 comm=demo_thread_saf dentry=ffff8990e1406540`
- #26. call=`do_filp_open.ret` source_line=`dmesg:27` raw=`[53083.229785] [trace_demo_thread_safety] do_filp_open.ret pid=264946 comm=demo_thread_saf ret=ffff898fd24af3c0`
- #27. call=`do_filp_open.entry` source_line=`dmesg:28` raw=`[53083.229830] [trace_demo_thread_safety] do_filp_open.entry pid=264946 comm=demo_thread_saf dfd=4294967196 pathname=ffff898e819b0000 op=ffffcc9702433cc4`
- #28. call=`__d_alloc.entry` source_line=`dmesg:29` raw=`[53083.229843] [trace_demo_thread_safety] __d_alloc.entry pid=264946 comm=demo_thread_saf sb=ffff898e906aa000 name_qstr=ffffcc9702433b90`
- #29. call=`__d_alloc.ret` source_line=`dmesg:30` raw=`[53083.229853] [trace_demo_thread_safety] __d_alloc.ret pid=264946 comm=demo_thread_saf dentry=ffff8990e1406480`
- #30. call=`do_filp_open.ret` source_line=`dmesg:31` raw=`[53083.229897] [trace_demo_thread_safety] do_filp_open.ret pid=264946 comm=demo_thread_saf ret=ffff898fd24af3c0`
- #31. call=`do_filp_open.entry` source_line=`dmesg:32` raw=`[53083.230021] [trace_demo_thread_safety] do_filp_open.entry pid=264946 comm=demo_thread_saf dfd=4294967196 pathname=ffff898e819b0000 op=ffffcc9702433d54`
- #32. call=`do_filp_open.ret` source_line=`dmesg:33` raw=`[53083.230063] [trace_demo_thread_safety] do_filp_open.ret pid=264946 comm=demo_thread_saf ret=ffff898fd24af3c0`
- #33. call=`do_filp_open.entry` source_line=`dmesg:34` raw=`[53083.430627] [trace_demo_thread_safety] do_filp_open.entry pid=264948 comm=demo_thread_saf dfd=3 pathname=ffff898e9961f000 op=ffffcc9700acba94`
- #34. call=`do_filp_open.entry` source_line=`dmesg:35` raw=`[53083.430648] [trace_demo_thread_safety] do_filp_open.entry pid=264949 comm=demo_thread_saf dfd=4294967196 pathname=ffff898e8c88d000 op=ffffcc97007bfde4`
- #35. call=`do_filp_open.ret` source_line=`dmesg:36` raw=`[53083.430667] [trace_demo_thread_safety] do_filp_open.ret pid=264948 comm=demo_thread_saf ret=ffff898f8a349480`
- #36. call=`do_filp_open.ret` source_line=`dmesg:37` raw=`[53083.430675] [trace_demo_thread_safety] do_filp_open.ret pid=264949 comm=demo_thread_saf ret=ffff898e9aba8d80`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=13 ret=13
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=5 ret=5

## Raw Artifacts
- report: `kernel/user/stage3/case1/reports/demo_thread_safety_trace_report.md`
- dmesg: `kernel/user/stage3/case1/reports/demo_thread_safety_dmesg.txt`
