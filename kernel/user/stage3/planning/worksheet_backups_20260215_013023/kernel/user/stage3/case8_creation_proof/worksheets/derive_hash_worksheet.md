# Worksheet: derive_hash

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case8_creation_proof/derive_hash.c`
- Driver: `kernel/drivers/stage3/case8_creation_proof/trace_derive_hash/trace_derive_hash.c`
- Module: `trace_derive_hash`
- Binary: `kernel/user/stage3/case8_creation_proof/derive_hash.out`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 8
- `do_filp_open.ret`: 8
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 6
- non-error pointer returns: 2

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53115.394038] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77c64`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53115.394059] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=fffffffffffffffe`
- #3. call=`do_filp_open.entry` source_line=`dmesg:4` raw=`[53115.394073] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77b74`
- #4. call=`do_filp_open.ret` source_line=`dmesg:5` raw=`[53115.394084] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=fffffffffffffffe`
- #5. call=`do_filp_open.entry` source_line=`dmesg:6` raw=`[53115.394096] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77ab4`
- #6. call=`do_filp_open.ret` source_line=`dmesg:7` raw=`[53115.394107] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=fffffffffffffffe`
- #7. call=`do_filp_open.entry` source_line=`dmesg:8` raw=`[53115.394121] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77e64`
- #8. call=`do_filp_open.ret` source_line=`dmesg:9` raw=`[53115.394129] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=fffffffffffffffe`
- #9. call=`do_filp_open.entry` source_line=`dmesg:10` raw=`[53115.394136] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77e44`
- #10. call=`do_filp_open.ret` source_line=`dmesg:11` raw=`[53115.394143] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=fffffffffffffffe`
- #11. call=`do_filp_open.entry` source_line=`dmesg:12` raw=`[53115.394150] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77dd4`
- #12. call=`do_filp_open.ret` source_line=`dmesg:13` raw=`[53115.394158] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=fffffffffffffffe`
- #13. call=`do_filp_open.entry` source_line=`dmesg:14` raw=`[53115.394165] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77b64`
- #14. call=`do_filp_open.ret` source_line=`dmesg:15` raw=`[53115.394176] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=ffff898e8d448240`
- #15. call=`do_filp_open.entry` source_line=`dmesg:16` raw=`[53115.394209] [trace_derive_hash] do_filp_open.entry pid=271301 comm=derive_hash.out dfd=4294967196 pathname=ffff898e8c9e5000 op=ffffcc9700e77ac4`
- #16. call=`do_filp_open.ret` source_line=`dmesg:17` raw=`[53115.394219] [trace_derive_hash] do_filp_open.ret pid=271301 comm=derive_hash.out ret=ffff898e8d448900`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=8 ret=8
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case8_creation_proof/reports/derive_hash_trace_report.md`
- dmesg: `kernel/user/stage3/case8_creation_proof/reports/derive_hash_dmesg.txt`
