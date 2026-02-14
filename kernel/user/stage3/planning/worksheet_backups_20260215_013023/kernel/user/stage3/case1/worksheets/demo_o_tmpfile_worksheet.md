# Worksheet: demo_o_tmpfile

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case1/demo_o_tmpfile/demo_o_tmpfile.c`
- Driver: `kernel/drivers/stage3/case1/trace_demo_o_tmpfile/trace_demo_o_tmpfile.c`
- Module: `trace_demo_o_tmpfile`
- Binary: `kernel/user/stage3/case1/demo_o_tmpfile/demo_o_tmpfile.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 11
- `do_filp_open.ret`: 11
- `__d_alloc.entry`: 1
- `__d_alloc.ret`: 1
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 5

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53082.148276] [trace_demo_o_tmpfile] do_filp_open.entry pid=264685 comm=demo_o_tmpfile. dfd=4294967196 pathname=ffff898e8d77e000 op=ffffcc9701f7bbd4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53082.148297] [trace_demo_o_tmpfile] do_filp_open.ret pid=264685 comm=demo_o_tmpfile. ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53082.148311] [trace_demo_o_tmpfile] do_filp_open.entry pid=264685 comm=demo_o_tmpfile. dfd=4294967196 pathname=ffff898e8d77e000 op=ffffcc9701f7bc74`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53082.148322] [trace_demo_o_tmpfile] do_filp_open.ret pid=264685 comm=demo_o_tmpfile. ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53082.148334] [trace_demo_o_tmpfile] do_filp_open.entry pid=264685 comm=demo_o_tmpfile. dfd=4294967196 pathname=ffff898e8d77e000 op=ffffcc9701f7bda4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53082.148345] [trace_demo_o_tmpfile] do_filp_open.ret pid=264685 comm=demo_o_tmpfile. ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53082.148359] [trace_demo_o_tmpfile] do_filp_open.entry pid=264685 comm=demo_o_tmpfile. dfd=4294967196 pathname=ffff898e8d77e000 op=ffffcc9701f7bdb4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53082.148367] [trace_demo_o_tmpfile] do_filp_open.ret pid=264685 comm=demo_o_tmpfile. ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53082.148374] [trace_demo_o_tmpfile] do_filp_open.entry pid=264685 comm=demo_o_tmpfile. dfd=4294967196 pathname=ffff898e8d77e000 op=ffffcc9701f7bb24`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53082.148381] [trace_demo_o_tmpfile] do_filp_open.ret pid=264685 comm=demo_o_tmpfile. ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53082.148388] [trace_demo_o_tmpfile] do_filp_open.entry pid=264685 comm=demo_o_tmpfile. dfd=4294967196 pathname=ffff898e8d77e000 op=ffffcc9701f7bc94`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53082.148395] [trace_demo_o_tmpfile] do_filp_open.ret pid=264685 comm=demo_o_tmpfile. ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53082.148403] [trace_demo_o_tmpfile] do_filp_open.entry pid=264685 comm=demo_o_tmpfile. dfd=4294967196 pathname=ffff898e8d77e000 op=ffffcc9701f7bb34`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53082.148413] [trace_demo_o_tmpfile] do_filp_open.ret pid=264685 comm=demo_o_tmpfile. ret=ffff898fd33a1e40`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53082.148458] [trace_demo_o_tmpfile] do_filp_open.entry pid=264685 comm=demo_o_tmpfile. dfd=4294967196 pathname=ffff898e8d77e000 op=ffffcc9701f7bba4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53082.148472] [trace_demo_o_tmpfile] do_filp_open.ret pid=264685 comm=demo_o_tmpfile. ret=ffff898fd33a1000`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53082.148958] [trace_demo_o_tmpfile] do_filp_open.entry pid=264685 comm=demo_o_tmpfile. dfd=4294967196 pathname=ffff898e8d77e000 op=ffffcc9701f7be24`
- #18. call=`__d_alloc.entry` source_line=`dmesg:19` raw=`[53082.148973] [trace_demo_o_tmpfile] __d_alloc.entry pid=264685 comm=demo_o_tmpfile. sb=ffff898e906aa000 name_qstr=ffffffffb9e50400`
- #19. call=`__d_alloc.ret` source_line=`dmesg:20` raw=`[53082.148982] [trace_demo_o_tmpfile] __d_alloc.ret pid=264685 comm=demo_o_tmpfile. dentry=ffff8990110a9300`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53082.149043] [trace_demo_o_tmpfile] do_filp_open.ret pid=264685 comm=demo_o_tmpfile. ret=ffff898fd33a1e40`
- #21. call=`do_filp_open.entry` source_line=`dmesg:22` raw=`[53082.149282] [trace_demo_o_tmpfile] do_filp_open.entry pid=264686 comm=demo_o_tmpfile. dfd=4294967196 pathname=ffff898e8f371000 op=ffffcc9702707b50`
- #22. call=`do_filp_open.ret` source_line=`dmesg:23` raw=`[53082.149307] [trace_demo_o_tmpfile] do_filp_open.ret pid=264686 comm=demo_o_tmpfile. ret=ffff898ea6d10300`
- #23. call=`do_filp_open.entry` source_line=`dmesg:24` raw=`[53082.149539] [trace_demo_o_tmpfile] do_filp_open.entry pid=264686 comm=demo_o_tmpfile. dfd=4294967196 pathname=ffff898e8f373000 op=ffffcc97027079e8`
- #24. call=`do_filp_open.ret` source_line=`dmesg:25` raw=`[53082.149556] [trace_demo_o_tmpfile] do_filp_open.ret pid=264686 comm=demo_o_tmpfile. ret=ffff898ea6d103c0`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=11 ret=11
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=1 ret=1

## Raw Artifacts
- report: `kernel/user/stage3/case1/reports/demo_o_tmpfile_trace_report.md`
- dmesg: `kernel/user/stage3/case1/reports/demo_o_tmpfile_dmesg.txt`
