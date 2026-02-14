# Worksheet: puzzle_verify

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case12_harder_puzzle/puzzle_verify.c`
- Driver: `kernel/drivers/stage3/case12_harder_puzzle/trace_puzzle_verify/trace_puzzle_verify.c`
- Module: `trace_puzzle_verify`
- Binary: `kernel/user/stage3/case12_harder_puzzle/puzzle_verify.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 8
- `do_filp_open.ret`: 8
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53091.268659] [trace_puzzle_verify] do_filp_open.entry pid=266875 comm=puzzle_verify.o dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970206fb84`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53091.268682] [trace_puzzle_verify] do_filp_open.ret pid=266875 comm=puzzle_verify.o ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53091.268696] [trace_puzzle_verify] do_filp_open.entry pid=266875 comm=puzzle_verify.o dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970206fe44`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53091.268708] [trace_puzzle_verify] do_filp_open.ret pid=266875 comm=puzzle_verify.o ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53091.268720] [trace_puzzle_verify] do_filp_open.entry pid=266875 comm=puzzle_verify.o dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970206fb94`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53091.268731] [trace_puzzle_verify] do_filp_open.ret pid=266875 comm=puzzle_verify.o ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53091.268746] [trace_puzzle_verify] do_filp_open.entry pid=266875 comm=puzzle_verify.o dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970206fcb4`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53091.268754] [trace_puzzle_verify] do_filp_open.ret pid=266875 comm=puzzle_verify.o ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53091.268761] [trace_puzzle_verify] do_filp_open.entry pid=266875 comm=puzzle_verify.o dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970206fdd4`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53091.268769] [trace_puzzle_verify] do_filp_open.ret pid=266875 comm=puzzle_verify.o ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53091.268776] [trace_puzzle_verify] do_filp_open.entry pid=266875 comm=puzzle_verify.o dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970206fb34`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53091.268784] [trace_puzzle_verify] do_filp_open.ret pid=266875 comm=puzzle_verify.o ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53091.268792] [trace_puzzle_verify] do_filp_open.entry pid=266875 comm=puzzle_verify.o dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970206fe24`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53091.268802] [trace_puzzle_verify] do_filp_open.ret pid=266875 comm=puzzle_verify.o ret=ffff898e893ebcc0`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53091.268843] [trace_puzzle_verify] do_filp_open.entry pid=266875 comm=puzzle_verify.o dfd=4294967196 pathname=ffff898e868b3000 op=ffffcc970206fd84`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53091.268854] [trace_puzzle_verify] do_filp_open.ret pid=266875 comm=puzzle_verify.o ret=ffff898e893ebc00`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=8 ret=8
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case12_harder_puzzle/reports/puzzle_verify_trace_report.md`
- dmesg: `kernel/user/stage3/case12_harder_puzzle/reports/puzzle_verify_dmesg.txt`
