---
layout: default
title: "Stage 3 CASE2: Explanation"
---
[CASE]
- id: case2
- title: Deep Miss
- userspace root: [kernel/user/stage3/case2_deep_miss](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case2_deep_miss)
- driver root: [kernel/drivers/stage3/case2_deep_miss](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case2_deep_miss)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Deep Miss.

[REPORT ARTIFACTS]
- [case2_deep_miss_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case2_deep_miss/reports/case2_deep_miss_trace_report.md)

[RAW LOG ARTIFACTS]
- [case2_deep_miss_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case2_deep_miss/reports/case2_deep_miss_dmesg.txt)

<!-- AUTO-EMBED START -->
[AUTO] case=case2

[FOLDER] case2_deep_miss
[INTENT] dcache miss path
[BASELINE_PROBES] do_sys_openat2;do_filp_open;path_openat;lookup_open;__d_alloc
[EXTRA_PROBES] d_lookup;__d_lookup;d_alloc_parallel;__d_alloc;lookup_open
[EXPECTED_SIGNATURES] d_lookup miss;__d_alloc hit;ENOENT

================================================================================
[EMBED] case2_deep_miss_trace_report.md (primary)
[SOURCE] kernel/user/stage3/case2_deep_miss/reports/case2_deep_miss_trace_report.md
================================================================================
# Trace Report: case2_deep_miss.c

- Userspace source: `kernel/user/stage3/case2_deep_miss/case2_deep_miss.c`
- Driver source: `kernel/drivers/stage3/case2_deep_miss/trace_case2_deep_miss/trace_case2_deep_miss.c`
- Module: `trace_case2_deep_miss`
- Binary: `kernel/user/stage3/case2_deep_miss/case2_deep_miss`
- Run timestamp: `2026-02-15T23:32:19`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 9
- do_filp_open.ret: 9
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 7
- Non-error pointer returns observed: 2

## Commands
```bash
make -C kernel/drivers/stage3/case2_deep_miss/trace_case2_deep_miss
kernel/user/stage3/case2_deep_miss/case2_deep_miss
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case2_deep_miss/trace_case2_deep_miss/trace_case2_deep_miss.ko target_comm="case2_deep_miss"
sudo rmmod trace_case2_deep_miss
```

## Dmesg
`kernel/user/stage3/case2_deep_miss/reports/case2_deep_miss_dmesg.txt`

================================================================================
[EMBED] case2_deep_miss_dmesg.txt (primary)
[SOURCE] kernel/user/stage3/case2_deep_miss/reports/case2_deep_miss_dmesg.txt
================================================================================
[38320.254811] [trace_case2_deep_miss] loaded target_comm=case2_deep_miss user=kernel/user/stage3/case2_deep_miss/case2_deep_miss.c
[38320.257801] [trace_case2_deep_miss] do_filp_open.entry pid=182348 comm=case2_deep_miss dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fb64
[38320.257812] [trace_case2_deep_miss] do_filp_open.ret pid=182348 comm=case2_deep_miss ret=fffffffffffffffe
[38320.257818] [trace_case2_deep_miss] do_filp_open.entry pid=182348 comm=case2_deep_miss dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fe04
[38320.257823] [trace_case2_deep_miss] do_filp_open.ret pid=182348 comm=case2_deep_miss ret=fffffffffffffffe
[38320.257828] [trace_case2_deep_miss] do_filp_open.entry pid=182348 comm=case2_deep_miss dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fb44
[38320.257833] [trace_case2_deep_miss] do_filp_open.ret pid=182348 comm=case2_deep_miss ret=fffffffffffffffe
[38320.257840] [trace_case2_deep_miss] do_filp_open.entry pid=182348 comm=case2_deep_miss dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fd34
[38320.257843] [trace_case2_deep_miss] do_filp_open.ret pid=182348 comm=case2_deep_miss ret=fffffffffffffffe
[38320.257846] [trace_case2_deep_miss] do_filp_open.entry pid=182348 comm=case2_deep_miss dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fb94
[38320.257849] [trace_case2_deep_miss] do_filp_open.ret pid=182348 comm=case2_deep_miss ret=fffffffffffffffe
[38320.257852] [trace_case2_deep_miss] do_filp_open.entry pid=182348 comm=case2_deep_miss dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fb64
[38320.257856] [trace_case2_deep_miss] do_filp_open.ret pid=182348 comm=case2_deep_miss ret=fffffffffffffffe
[38320.257859] [trace_case2_deep_miss] do_filp_open.entry pid=182348 comm=case2_deep_miss dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fbc4
[38320.257863] [trace_case2_deep_miss] do_filp_open.ret pid=182348 comm=case2_deep_miss ret=ffff8dda05063cc0
[38320.257879] [trace_case2_deep_miss] do_filp_open.entry pid=182348 comm=case2_deep_miss dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fc74
[38320.257884] [trace_case2_deep_miss] do_filp_open.ret pid=182348 comm=case2_deep_miss ret=ffff8dda05063e40
[38320.258069] [trace_case2_deep_miss] do_filp_open.entry pid=182348 comm=case2_deep_miss dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fbe4
[38320.258075] [trace_case2_deep_miss] do_filp_open.ret pid=182348 comm=case2_deep_miss ret=fffffffffffffffe
<!-- AUTO-EMBED END -->
