---
layout: default
title: "Stage 3 CASE12: Explanation"
---
[CASE]
- id: case12
- title: Harder Puzzle
- userspace root: [kernel/user/stage3/case12_harder_puzzle](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case12_harder_puzzle)
- driver root: [kernel/drivers/stage3/case12_harder_puzzle](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case12_harder_puzzle)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Harder Puzzle.

[REPORT ARTIFACTS]
- [puzzle_verify_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case12_harder_puzzle/reports/puzzle_verify_trace_report.md)
- [user_puzzle_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case12_harder_puzzle/reports/user_puzzle_trace_report.md)

[RAW LOG ARTIFACTS]
- [puzzle_verify_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case12_harder_puzzle/reports/puzzle_verify_dmesg.txt)
- [user_puzzle_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case12_harder_puzzle/reports/user_puzzle_dmesg.txt)

<!-- AUTO-EMBED START -->
[AUTO] case=case12

[FOLDER] case12_harder_puzzle
[INTENT] complex open puzzle
[BASELINE_PROBES] do_sys_openat2;do_filp_open;path_openat;lookup_open;__d_alloc
[EXTRA_PROBES] path_init;link_path_walk;open_last_lookups;lookup_open
[EXPECTED_SIGNATURES] branch-specific open path

================================================================================
[EMBED] puzzle_verify_trace_report.md (primary)
[SOURCE] kernel/user/stage3/case12_harder_puzzle/reports/puzzle_verify_trace_report.md
================================================================================
# Trace Report: puzzle_verify.c

- Userspace source: `kernel/user/stage3/case12_harder_puzzle/puzzle_verify.c`
- Driver source: `kernel/drivers/stage3/case12_harder_puzzle/trace_puzzle_verify/trace_puzzle_verify.c`
- Module: `trace_puzzle_verify`
- Binary: `kernel/user/stage3/case12_harder_puzzle/puzzle_verify`
- Run timestamp: `2026-02-15T23:32:06`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 8
- do_filp_open.ret: 8
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 2

## Commands
```bash
make -C kernel/drivers/stage3/case12_harder_puzzle/trace_puzzle_verify
kernel/user/stage3/case12_harder_puzzle/puzzle_verify
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case12_harder_puzzle/trace_puzzle_verify/trace_puzzle_verify.ko target_comm="puzzle_verify"
sudo rmmod trace_puzzle_verify
```

## Dmesg
`kernel/user/stage3/case12_harder_puzzle/reports/puzzle_verify_dmesg.txt`

================================================================================
[EMBED] puzzle_verify_dmesg.txt (primary)
[SOURCE] kernel/user/stage3/case12_harder_puzzle/reports/puzzle_verify_dmesg.txt
================================================================================
[38307.617569] [trace_puzzle_verify] loaded target_comm=puzzle_verify user=kernel/user/stage3/case12_harder_puzzle/puzzle_verify.c
[38307.621140] [trace_puzzle_verify] do_filp_open.entry pid=179519 comm=puzzle_verify dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c9407f7cf4
[38307.621162] [trace_puzzle_verify] do_filp_open.ret pid=179519 comm=puzzle_verify ret=fffffffffffffffe
[38307.621177] [trace_puzzle_verify] do_filp_open.entry pid=179519 comm=puzzle_verify dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c9407f7d24
[38307.621191] [trace_puzzle_verify] do_filp_open.ret pid=179519 comm=puzzle_verify ret=fffffffffffffffe
[38307.621205] [trace_puzzle_verify] do_filp_open.entry pid=179519 comm=puzzle_verify dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c9407f7bd4
[38307.621218] [trace_puzzle_verify] do_filp_open.ret pid=179519 comm=puzzle_verify ret=fffffffffffffffe
[38307.621236] [trace_puzzle_verify] do_filp_open.entry pid=179519 comm=puzzle_verify dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c9407f7d94
[38307.621244] [trace_puzzle_verify] do_filp_open.ret pid=179519 comm=puzzle_verify ret=fffffffffffffffe
[38307.621253] [trace_puzzle_verify] do_filp_open.entry pid=179519 comm=puzzle_verify dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c9407f7b74
[38307.621283] [trace_puzzle_verify] do_filp_open.ret pid=179519 comm=puzzle_verify ret=fffffffffffffffe
[38307.621293] [trace_puzzle_verify] do_filp_open.entry pid=179519 comm=puzzle_verify dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c9407f7c84
[38307.621301] [trace_puzzle_verify] do_filp_open.ret pid=179519 comm=puzzle_verify ret=fffffffffffffffe
[38307.621308] [trace_puzzle_verify] do_filp_open.entry pid=179519 comm=puzzle_verify dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c9407f7dc4
[38307.621319] [trace_puzzle_verify] do_filp_open.ret pid=179519 comm=puzzle_verify ret=ffff8ddc28873d80
[38307.621361] [trace_puzzle_verify] do_filp_open.entry pid=179519 comm=puzzle_verify dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c9407f7ad4
[38307.621371] [trace_puzzle_verify] do_filp_open.ret pid=179519 comm=puzzle_verify ret=ffff8ddc288733c0
<!-- AUTO-EMBED END -->
