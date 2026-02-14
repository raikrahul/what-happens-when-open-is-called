# Worksheet: demo_toctou

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case1/demo_toctou/demo_toctou.c`
- Driver: `kernel/drivers/stage3/case1/trace_demo_toctou/trace_demo_toctou.c`
- Module: `trace_demo_toctou`
- Binary: `kernel/user/stage3/case1/demo_toctou/demo_toctou.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 21
- `do_filp_open.ret`: 21
- `__d_alloc.entry`: 12
- `__d_alloc.ret`: 12
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 15

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53084.475925] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8c9a5000 op=ffffcc9702267b94`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53084.475937] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53084.475943] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8c9a5000 op=ffffcc9702267e74`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53084.475948] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53084.475954] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8c9a5000 op=ffffcc9702267cc4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53084.475959] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53084.475965] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8c9a5000 op=ffffcc9702267c54`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53084.475969] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53084.475972] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8c9a5000 op=ffffcc9702267e74`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53084.475975] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53084.475979] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8c9a5000 op=ffffcc9702267cf4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53084.475982] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53084.475986] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8c9a5000 op=ffffcc9702267bf4`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53084.475990] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=ffff898e85196840`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53084.476008] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8c9a5000 op=ffffcc9702267e44`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53084.476014] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=ffff898e85196c00`
- #17. call=`do_filp_open.entry` source_line=`dmesg:18` raw=`[53084.476289] [trace_demo_toctou] do_filp_open.entry pid=265210 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8d707000 op=ffffcc97007dbd90`
- #18. call=`do_filp_open.ret` source_line=`dmesg:19` raw=`[53084.476315] [trace_demo_toctou] do_filp_open.ret pid=265210 comm=demo_toctou.out ret=ffff898ebd8cd540`
- #19. call=`do_filp_open.entry` source_line=`dmesg:20` raw=`[53084.476485] [trace_demo_toctou] do_filp_open.entry pid=265210 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8d702000 op=ffffcc97007dbc28`
- #20. call=`do_filp_open.ret` source_line=`dmesg:21` raw=`[53084.476498] [trace_demo_toctou] do_filp_open.ret pid=265210 comm=demo_toctou.out ret=ffff898ebd8cd6c0`
- #21. call=`__d_alloc.entry` source_line=`dmesg:22` raw=`[53084.478699] [trace_demo_toctou] __d_alloc.entry pid=265209 comm=demo_toctou.out sb=ffff898e906aa000 name_qstr=ffffcc9702267b70`
- #22. call=`__d_alloc.ret` source_line=`dmesg:23` raw=`[53084.478706] [trace_demo_toctou] __d_alloc.ret pid=265209 comm=demo_toctou.out dentry=ffff8990112e4f00`
- #23. call=`__d_alloc.entry` source_line=`dmesg:24` raw=`[53084.478733] [trace_demo_toctou] __d_alloc.entry pid=265209 comm=demo_toctou.out sb=ffff898e906aa000 name_qstr=ffffcc9702267c10`
- #24. call=`__d_alloc.ret` source_line=`dmesg:25` raw=`[53084.478736] [trace_demo_toctou] __d_alloc.ret pid=265209 comm=demo_toctou.out dentry=ffff899130665a80`
- #25. call=`do_filp_open.entry` source_line=`dmesg:26` raw=`[53084.478759] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8c9a5000 op=ffffcc9702267e64`
- #26. call=`__d_alloc.entry` source_line=`dmesg:27` raw=`[53084.478764] [trace_demo_toctou] __d_alloc.entry pid=265209 comm=demo_toctou.out sb=ffff898e906aa000 name_qstr=ffffcc9702267d30`
- #27. call=`__d_alloc.ret` source_line=`dmesg:28` raw=`[53084.478767] [trace_demo_toctou] __d_alloc.ret pid=265209 comm=demo_toctou.out dentry=ffff899130665f00`
- #28. call=`do_filp_open.ret` source_line=`dmesg:29` raw=`[53084.478780] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=ffff898ebd38e300`
- #29. call=`do_filp_open.entry` source_line=`dmesg:30` raw=`[53084.478794] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8c9a5000 op=ffffcc9702267ad4`
- #30. call=`__d_alloc.entry` source_line=`dmesg:31` raw=`[53084.478798] [trace_demo_toctou] __d_alloc.entry pid=265209 comm=demo_toctou.out sb=ffff898e906aa000 name_qstr=ffffcc97022679a0`
- #31. call=`__d_alloc.ret` source_line=`dmesg:32` raw=`[53084.478801] [trace_demo_toctou] __d_alloc.ret pid=265209 comm=demo_toctou.out dentry=ffff899130665180`
- #32. call=`do_filp_open.ret` source_line=`dmesg:33` raw=`[53084.478813] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=ffff898ebd38e300`
- #33. call=`__d_alloc.entry` source_line=`dmesg:34` raw=`[53084.478832] [trace_demo_toctou] __d_alloc.entry pid=265209 comm=demo_toctou.out sb=ffff898e906aa000 name_qstr=ffffcc9702267d10`
- #34. call=`__d_alloc.ret` source_line=`dmesg:35` raw=`[53084.478835] [trace_demo_toctou] __d_alloc.ret pid=265209 comm=demo_toctou.out dentry=ffff89914d178600`
- #35. call=`__d_alloc.entry` source_line=`dmesg:36` raw=`[53084.478850] [trace_demo_toctou] __d_alloc.entry pid=265209 comm=demo_toctou.out sb=ffff898e906aa000 name_qstr=ffffcc9702267d20`
- #36. call=`__d_alloc.ret` source_line=`dmesg:37` raw=`[53084.478853] [trace_demo_toctou] __d_alloc.ret pid=265209 comm=demo_toctou.out dentry=ffff89914d178000`
- #37. call=`do_filp_open.entry` source_line=`dmesg:38` raw=`[53084.478866] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9702267bb4`
- #38. call=`do_filp_open.ret` source_line=`dmesg:39` raw=`[53084.478871] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=ffff898ebd38e300`
- #39. call=`do_filp_open.entry` source_line=`dmesg:40` raw=`[53084.478991] [trace_demo_toctou] do_filp_open.entry pid=265212 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e99618000 op=ffffcc9702213de0`
- #40. call=`do_filp_open.ret` source_line=`dmesg:41` raw=`[53084.479010] [trace_demo_toctou] do_filp_open.ret pid=265212 comm=demo_toctou.out ret=ffff8990cf207b40`
- #41. call=`do_filp_open.entry` source_line=`dmesg:42` raw=`[53084.479167] [trace_demo_toctou] do_filp_open.entry pid=265212 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e99619000 op=ffffcc9702213c78`
- #42. call=`do_filp_open.ret` source_line=`dmesg:43` raw=`[53084.479180] [trace_demo_toctou] do_filp_open.ret pid=265212 comm=demo_toctou.out ret=ffff8990cf207780`
- #43. call=`__d_alloc.entry` source_line=`dmesg:44` raw=`[53084.482455] [trace_demo_toctou] __d_alloc.entry pid=265209 comm=demo_toctou.out sb=ffff898e906aa000 name_qstr=ffffcc9702267db0`
- #44. call=`__d_alloc.ret` source_line=`dmesg:45` raw=`[53084.482464] [trace_demo_toctou] __d_alloc.ret pid=265209 comm=demo_toctou.out dentry=ffff89911c560300`
- #45. call=`__d_alloc.entry` source_line=`dmesg:46` raw=`[53084.482490] [trace_demo_toctou] __d_alloc.entry pid=265209 comm=demo_toctou.out sb=ffff898e906aa000 name_qstr=ffffcc9702267c30`
- #46. call=`__d_alloc.ret` source_line=`dmesg:47` raw=`[53084.482493] [trace_demo_toctou] __d_alloc.ret pid=265209 comm=demo_toctou.out dentry=ffff89911c5606c0`
- #47. call=`do_filp_open.entry` source_line=`dmesg:48` raw=`[53084.482527] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9702267d44`
- #48. call=`__d_alloc.entry` source_line=`dmesg:49` raw=`[53084.482532] [trace_demo_toctou] __d_alloc.entry pid=265209 comm=demo_toctou.out sb=ffff898e906aa000 name_qstr=ffffcc9702267c10`
- #49. call=`__d_alloc.ret` source_line=`dmesg:50` raw=`[53084.482535] [trace_demo_toctou] __d_alloc.ret pid=265209 comm=demo_toctou.out dentry=ffff89911c560d80`
- #50. call=`do_filp_open.ret` source_line=`dmesg:51` raw=`[53084.482549] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=ffff898ebd38e300`
- #51. call=`do_filp_open.entry` source_line=`dmesg:52` raw=`[53084.482564] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9702267d24`
- #52. call=`__d_alloc.entry` source_line=`dmesg:53` raw=`[53084.482568] [trace_demo_toctou] __d_alloc.entry pid=265209 comm=demo_toctou.out sb=ffff898e906aa000 name_qstr=ffffcc9702267bf0`
- #53. call=`__d_alloc.ret` source_line=`dmesg:54` raw=`[53084.482571] [trace_demo_toctou] __d_alloc.ret pid=265209 comm=demo_toctou.out dentry=ffff89911c5609c0`
- #54. call=`do_filp_open.ret` source_line=`dmesg:55` raw=`[53084.482584] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=ffff898ebd38e300`
- #55. call=`do_filp_open.entry` source_line=`dmesg:56` raw=`[53084.482593] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8c9a1000 op=ffffcc9702267d14`
- #56. call=`do_filp_open.ret` source_line=`dmesg:57` raw=`[53084.482597] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=ffff898ebd38e300`
- #57. call=`__d_alloc.entry` source_line=`dmesg:58` raw=`[53084.482604] [trace_demo_toctou] __d_alloc.entry pid=265209 comm=demo_toctou.out sb=ffff898e906aa000 name_qstr=ffffcc9702267b10`
- #58. call=`__d_alloc.ret` source_line=`dmesg:59` raw=`[53084.482607] [trace_demo_toctou] __d_alloc.ret pid=265209 comm=demo_toctou.out dentry=ffff89911c560e40`
- #59. call=`__d_alloc.entry` source_line=`dmesg:60` raw=`[53084.482621] [trace_demo_toctou] __d_alloc.entry pid=265209 comm=demo_toctou.out sb=ffff898e906aa000 name_qstr=ffffcc9702267e30`
- #60. call=`__d_alloc.ret` source_line=`dmesg:61` raw=`[53084.482624] [trace_demo_toctou] __d_alloc.ret pid=265209 comm=demo_toctou.out dentry=ffff89911c560b40`
- #61. call=`do_filp_open.entry` source_line=`dmesg:62` raw=`[53084.482636] [trace_demo_toctou] do_filp_open.entry pid=265209 comm=demo_toctou.out dfd=3 pathname=ffff898e8c9a5000 op=ffffcc9702267cd4`
- #62. call=`do_filp_open.ret` source_line=`dmesg:63` raw=`[53084.482641] [trace_demo_toctou] do_filp_open.ret pid=265209 comm=demo_toctou.out ret=ffff898ebd38e600`
- #63. call=`do_filp_open.entry` source_line=`dmesg:64` raw=`[53084.482713] [trace_demo_toctou] do_filp_open.entry pid=265214 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8d77e000 op=ffffcc97007a7ab0`
- #64. call=`do_filp_open.ret` source_line=`dmesg:65` raw=`[53084.482734] [trace_demo_toctou] do_filp_open.ret pid=265214 comm=demo_toctou.out ret=ffff898e9abc2840`
- #65. call=`do_filp_open.entry` source_line=`dmesg:66` raw=`[53084.482923] [trace_demo_toctou] do_filp_open.entry pid=265214 comm=demo_toctou.out dfd=4294967196 pathname=ffff898e8d77f000 op=ffffcc97007a7948`
- #66. call=`do_filp_open.ret` source_line=`dmesg:67` raw=`[53084.482940] [trace_demo_toctou] do_filp_open.ret pid=265214 comm=demo_toctou.out ret=ffff898e9abc2900`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=21 ret=21
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=12 ret=12

## Raw Artifacts
- report: `kernel/user/stage3/case1/reports/demo_toctou_trace_report.md`
- dmesg: `kernel/user/stage3/case1/reports/demo_toctou_dmesg.txt`
