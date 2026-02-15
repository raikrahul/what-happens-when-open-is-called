---
layout: default
title: "Stage 3 CASE3: Explanation"
---
[CASE]
- id: case3
- title: Deep Hit
- userspace root: [kernel/user/stage3/case3_deep_hit](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case3_deep_hit)
- driver root: [kernel/drivers/stage3/case3_deep_hit](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case3_deep_hit)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Deep Hit.

[REPORT ARTIFACTS]
- [case3_deep_hit_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case3_deep_hit/reports/case3_deep_hit_trace_report.md)

[RAW LOG ARTIFACTS]
- [case3_deep_hit_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case3_deep_hit/reports/case3_deep_hit_dmesg.txt)

<!-- AUTO-EMBED START -->
[AUTO] case=case3

[FOLDER] case3_deep_hit
[INTENT] dcache hit path
[BASELINE_PROBES] do_sys_openat2;do_filp_open;path_openat;lookup_open;__d_alloc
[EXTRA_PROBES] d_lookup;__d_lookup;d_revalidate;lookup_open
[EXPECTED_SIGNATURES] d_lookup hit;fewer allocations

================================================================================
[EMBED] case3_deep_hit_trace_report.md (primary)
[SOURCE] kernel/user/stage3/case3_deep_hit/reports/case3_deep_hit_trace_report.md
================================================================================
# Trace Report: case3_deep_hit.c

- Userspace source: `kernel/user/stage3/case3_deep_hit/case3_deep_hit.c`
- Driver source: `kernel/drivers/stage3/case3_deep_hit/trace_case3_deep_hit/trace_case3_deep_hit.c`
- Module: `trace_case3_deep_hit`
- Binary: `kernel/user/stage3/case3_deep_hit/case3_deep_hit`
- Run timestamp: `2026-02-15T23:32:20`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 10
- do_filp_open.ret: 10
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 8
- Non-error pointer returns observed: 2

## Commands
```bash
make -C kernel/drivers/stage3/case3_deep_hit/trace_case3_deep_hit
kernel/user/stage3/case3_deep_hit/case3_deep_hit
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case3_deep_hit/trace_case3_deep_hit/trace_case3_deep_hit.ko target_comm="case3_deep_hit"
sudo rmmod trace_case3_deep_hit
```

## Dmesg
`kernel/user/stage3/case3_deep_hit/reports/case3_deep_hit_dmesg.txt`

================================================================================
[EMBED] case3_deep_hit_dmesg.txt (primary)
[SOURCE] kernel/user/stage3/case3_deep_hit/reports/case3_deep_hit_dmesg.txt
================================================================================
[38321.393958] [trace_case3_deep_hit] loaded target_comm=case3_deep_hit user=kernel/user/stage3/case3_deep_hit/case3_deep_hit.c
[38321.397150] [trace_case3_deep_hit] do_filp_open.entry pid=182603 comm=case3_deep_hit dfd=4294967196 pathname=ffff8dda0d5e3000 op=ffffd0c940e83e34
[38321.397193] [trace_case3_deep_hit] do_filp_open.ret pid=182603 comm=case3_deep_hit ret=fffffffffffffffe
[38321.397211] [trace_case3_deep_hit] do_filp_open.entry pid=182603 comm=case3_deep_hit dfd=4294967196 pathname=ffff8dda0d5e3000 op=ffffd0c940e83c14
[38321.397226] [trace_case3_deep_hit] do_filp_open.ret pid=182603 comm=case3_deep_hit ret=fffffffffffffffe
[38321.397240] [trace_case3_deep_hit] do_filp_open.entry pid=182603 comm=case3_deep_hit dfd=4294967196 pathname=ffff8dda0d5e3000 op=ffffd0c940e83d24
[38321.397254] [trace_case3_deep_hit] do_filp_open.ret pid=182603 comm=case3_deep_hit ret=fffffffffffffffe
[38321.397273] [trace_case3_deep_hit] do_filp_open.entry pid=182603 comm=case3_deep_hit dfd=4294967196 pathname=ffff8dda0d5e3000 op=ffffd0c940e83ae4
[38321.397283] [trace_case3_deep_hit] do_filp_open.ret pid=182603 comm=case3_deep_hit ret=fffffffffffffffe
[38321.397292] [trace_case3_deep_hit] do_filp_open.entry pid=182603 comm=case3_deep_hit dfd=4294967196 pathname=ffff8dda0d5e3000 op=ffffd0c940e83c84
[38321.397301] [trace_case3_deep_hit] do_filp_open.ret pid=182603 comm=case3_deep_hit ret=fffffffffffffffe
[38321.397310] [trace_case3_deep_hit] do_filp_open.entry pid=182603 comm=case3_deep_hit dfd=4294967196 pathname=ffff8dda0d5e3000 op=ffffd0c940e83c74
[38321.397319] [trace_case3_deep_hit] do_filp_open.ret pid=182603 comm=case3_deep_hit ret=fffffffffffffffe
[38321.397328] [trace_case3_deep_hit] do_filp_open.entry pid=182603 comm=case3_deep_hit dfd=4294967196 pathname=ffff8dda0d5e3000 op=ffffd0c940e83ae4
[38321.397341] [trace_case3_deep_hit] do_filp_open.ret pid=182603 comm=case3_deep_hit ret=ffff8dda04d7c840
[38321.397390] [trace_case3_deep_hit] do_filp_open.entry pid=182603 comm=case3_deep_hit dfd=4294967196 pathname=ffff8dda0d5e3000 op=ffffd0c940e83bf4
[38321.397402] [trace_case3_deep_hit] do_filp_open.ret pid=182603 comm=case3_deep_hit ret=ffff8dda04d7c9c0
[38321.397922] [trace_case3_deep_hit] do_filp_open.entry pid=182603 comm=case3_deep_hit dfd=4294967196 pathname=ffff8dda0d5e3000 op=ffffd0c940e83d04
[38321.397943] [trace_case3_deep_hit] do_filp_open.ret pid=182603 comm=case3_deep_hit ret=fffffffffffffffe
[38321.398020] [trace_case3_deep_hit] do_filp_open.entry pid=182603 comm=case3_deep_hit dfd=4294967196 pathname=ffff8dda0d5e3000 op=ffffd0c940e83b14
[38321.398033] [trace_case3_deep_hit] do_filp_open.ret pid=182603 comm=case3_deep_hit ret=fffffffffffffffe
<!-- AUTO-EMBED END -->
