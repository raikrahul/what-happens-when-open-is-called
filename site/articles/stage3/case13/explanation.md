---
layout: default
title: "Stage 3 CASE13: Explanation"
---
[CASE]
- id: case13
- title: Salt Avalanche
- userspace root: [kernel/user/stage3/case13_salt_avalanche](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case13_salt_avalanche)
- driver root: [kernel/drivers/stage3/case13_salt_avalanche](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case13_salt_avalanche)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Salt Avalanche.

[REPORT ARTIFACTS]
- [user_salt_avalanche_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case13_salt_avalanche/reports/user_salt_avalanche_trace_report.md)

[RAW LOG ARTIFACTS]
- [user_salt_avalanche_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case13_salt_avalanche/reports/user_salt_avalanche_dmesg.txt)

<!-- AUTO-EMBED START -->
[AUTO] case=case13

[FOLDER] case13_salt_avalanche
[INTENT] name hash behavior
[BASELINE_PROBES] do_sys_openat2;do_filp_open;path_openat;lookup_open;__d_alloc
[EXTRA_PROBES] full_name_hash;d_lookup;d_alloc_parallel
[EXPECTED_SIGNATURES] hash values shift by input

================================================================================
[EMBED] user_salt_avalanche_trace_report.md (primary)
[SOURCE] kernel/user/stage3/case13_salt_avalanche/reports/user_salt_avalanche_trace_report.md
================================================================================
# Trace Report: user_salt_avalanche.c

- Userspace source: `kernel/user/stage3/case13_salt_avalanche/user_salt_avalanche.c`
- Driver source: `kernel/drivers/stage3/case13_salt_avalanche/trace_user_salt_avalanche/trace_user_salt_avalanche.c`
- Module: `trace_user_salt_avalanche`
- Binary: `kernel/user/stage3/case13_salt_avalanche/user_salt_avalanche`
- Run timestamp: `2026-02-15T23:32:08`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 10
- do_filp_open.ret: 10
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 4

## Commands
```bash
make -C kernel/drivers/stage3/case13_salt_avalanche/trace_user_salt_avalanche
kernel/user/stage3/case13_salt_avalanche/user_salt_avalanche
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case13_salt_avalanche/trace_user_salt_avalanche/trace_user_salt_avalanche.ko target_comm="user_salt_avala"
sudo rmmod trace_user_salt_avalanche
```

## Dmesg
`kernel/user/stage3/case13_salt_avalanche/reports/user_salt_avalanche_dmesg.txt`

================================================================================
[EMBED] user_salt_avalanche_dmesg.txt (primary)
[SOURCE] kernel/user/stage3/case13_salt_avalanche/reports/user_salt_avalanche_dmesg.txt
================================================================================
[38309.996073] [trace_user_salt_avalanche] loaded target_comm=user_salt_avala user=kernel/user/stage3/case13_salt_avalanche/user_salt_avalanche.c
[38309.999498] [trace_user_salt_avalanche] do_filp_open.entry pid=180049 comm=user_salt_avala dfd=4294967196 pathname=ffff8dda0d5e4000 op=ffffd0c94062fac4
[38309.999527] [trace_user_salt_avalanche] do_filp_open.ret pid=180049 comm=user_salt_avala ret=fffffffffffffffe
[38309.999534] [trace_user_salt_avalanche] do_filp_open.entry pid=180049 comm=user_salt_avala dfd=4294967196 pathname=ffff8dda0d5e4000 op=ffffd0c94062fb24
[38309.999539] [trace_user_salt_avalanche] do_filp_open.ret pid=180049 comm=user_salt_avala ret=fffffffffffffffe
[38309.999545] [trace_user_salt_avalanche] do_filp_open.entry pid=180049 comm=user_salt_avala dfd=4294967196 pathname=ffff8dda0d5e4000 op=ffffd0c94062fb64
[38309.999550] [trace_user_salt_avalanche] do_filp_open.ret pid=180049 comm=user_salt_avala ret=fffffffffffffffe
[38309.999557] [trace_user_salt_avalanche] do_filp_open.entry pid=180049 comm=user_salt_avala dfd=4294967196 pathname=ffff8dda0d5e4000 op=ffffd0c94062fe34
[38309.999561] [trace_user_salt_avalanche] do_filp_open.ret pid=180049 comm=user_salt_avala ret=fffffffffffffffe
[38309.999564] [trace_user_salt_avalanche] do_filp_open.entry pid=180049 comm=user_salt_avala dfd=4294967196 pathname=ffff8dda0d5e4000 op=ffffd0c94062fca4
[38309.999568] [trace_user_salt_avalanche] do_filp_open.ret pid=180049 comm=user_salt_avala ret=fffffffffffffffe
[38309.999572] [trace_user_salt_avalanche] do_filp_open.entry pid=180049 comm=user_salt_avala dfd=4294967196 pathname=ffff8dda0d5e4000 op=ffffd0c94062fd74
[38309.999575] [trace_user_salt_avalanche] do_filp_open.ret pid=180049 comm=user_salt_avala ret=fffffffffffffffe
[38309.999579] [trace_user_salt_avalanche] do_filp_open.entry pid=180049 comm=user_salt_avala dfd=4294967196 pathname=ffff8dda0d5e4000 op=ffffd0c94062fbe4
[38309.999585] [trace_user_salt_avalanche] do_filp_open.ret pid=180049 comm=user_salt_avala ret=ffff8dda2795d780
[38309.999616] [trace_user_salt_avalanche] do_filp_open.entry pid=180049 comm=user_salt_avala dfd=4294967196 pathname=ffff8dda0d5e4000 op=ffffd0c94062fd84
[38309.999627] [trace_user_salt_avalanche] do_filp_open.ret pid=180049 comm=user_salt_avala ret=ffff8dda2795df00
[38310.000044] [trace_user_salt_avalanche] do_filp_open.entry pid=180049 comm=user_salt_avala dfd=4294967196 pathname=ffff8dda0d5e4000 op=ffffd0c94062fb04
[38310.000058] [trace_user_salt_avalanche] do_filp_open.ret pid=180049 comm=user_salt_avala ret=ffff8dda2795d780
[38310.000139] [trace_user_salt_avalanche] do_filp_open.entry pid=180049 comm=user_salt_avala dfd=4294967196 pathname=ffff8dda0d5e4000 op=ffffd0c94062fd04
[38310.000169] [trace_user_salt_avalanche] do_filp_open.ret pid=180049 comm=user_salt_avala ret=ffff8dda2795d780
<!-- AUTO-EMBED END -->
