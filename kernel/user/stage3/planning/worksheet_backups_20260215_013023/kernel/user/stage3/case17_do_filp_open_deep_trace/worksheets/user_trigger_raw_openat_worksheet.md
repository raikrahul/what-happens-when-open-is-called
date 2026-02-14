# Worksheet: user_trigger_raw_openat

- Generated: `2026-02-15T01:16:11`
- Userspace: `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger_raw_openat.S`
- Driver: `kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger_raw_openat/trace_user_trigger_raw_openat.c`
- Module: `trace_user_trigger_raw_openat`
- Binary: `kernel/user/stage3/case17_do_filp_open_deep_trace/openat_raw`
- Status: `pass_probe_hits`

## Probe Totals
- `do_filp_open.entry`: 1
- `do_filp_open.ret`: 1
- `__d_alloc.entry`: 0
- `__d_alloc.ret`: 0
- `ERR_PTR(-ENOENT)` returns: 1
- non-error pointer returns: 0

## Full Function Trace Steps (Pseudo-Debugger Style)
- #1. call=`do_filp_open.entry` source_line=`dmesg:2` raw=`[53102.537622] [trace_user_trigger_raw_openat] do_filp_open.entry pid=269453 comm=openat_raw dfd=4294967196 pathname=ffff898e819b0000 op=ffffcc9700c7bab4`
- #2. call=`do_filp_open.ret` source_line=`dmesg:3` raw=`[53102.537639] [trace_user_trigger_raw_openat] do_filp_open.ret pid=269453 comm=openat_raw ret=fffffffffffffffe`

## Per-Probe Pair Checks
- Pair A: `do_filp_open.entry` -> `do_filp_open.ret`
- Count A entry=1 ret=1
- Pair B: `__d_alloc.entry` -> `__d_alloc.ret`
- Count B entry=0 ret=0

## Raw Artifacts
- report: `kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_raw_openat_trace_report.md`
- dmesg: `kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_raw_openat_dmesg.txt`
