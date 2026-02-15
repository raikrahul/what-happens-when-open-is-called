---
layout: default
title: "Stage 3 CASE15: Proof"
---
[PROOF CHECKLIST]
1. Claim -> Evidence line -> Pass/Fail.
2. Reproduction command list.
3. Counterexample path.
4. Closure check: no orphan claim.

[PRIMARY REPORT LINKS]
- [user_deep_create_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace/reports/user_deep_create_trace_report.md)
- [user_deep_open_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace/reports/user_deep_open_trace_report.md)

[PRIMARY DMESG LINKS]
- [user_deep_create_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace/reports/user_deep_create_dmesg.txt)
- [user_deep_open_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case15_deep_trace/reports/user_deep_open_dmesg.txt)

[SECONDARY PROOF INPUTS]
- worksheet index: [STAGE3_WORKSHEET_INDEX](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_WORKSHEET_INDEX.md)
- axiom index: [STAGE3_AXIOM_WORKSHEET_INDEX](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_AXIOM_WORKSHEET_INDEX.md)
- hard index: [STAGE3_AXIOM_HARD_WORKSHEET_INDEX](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_AXIOM_HARD_WORKSHEET_INDEX.md)

<!-- AUTO-EMBED START -->
[AUTO] case=case15

[USERDIR] kernel/user/stage3/case15_deep_trace

================================================================================
[EMBED] user_deep_create_trace_report.md
[SOURCE] kernel/user/stage3/case15_deep_trace/reports/user_deep_create_trace_report.md
================================================================================
# Trace Report: user_deep_create.c

- Userspace source: `kernel/user/stage3/case15_deep_trace/user_deep_create.c`
- Driver source: `kernel/drivers/stage3/case15_deep_trace/trace_user_deep_create/trace_user_deep_create.c`
- Module: `trace_user_deep_create`
- Binary: `kernel/user/stage3/case15_deep_trace/user_deep_create`
- Run timestamp: `2026-02-15T23:32:11`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 9
- do_filp_open.ret: 9
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 3

## Commands
```bash
make -C kernel/drivers/stage3/case15_deep_trace/trace_user_deep_create
kernel/user/stage3/case15_deep_trace/user_deep_create
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case15_deep_trace/trace_user_deep_create/trace_user_deep_create.ko target_comm="user_deep_creat"
sudo rmmod trace_user_deep_create
```

## Dmesg
`kernel/user/stage3/case15_deep_trace/reports/user_deep_create_dmesg.txt`

================================================================================
[EMBED] user_deep_open_trace_report.md
[SOURCE] kernel/user/stage3/case15_deep_trace/reports/user_deep_open_trace_report.md
================================================================================
# Trace Report: user_deep_open.c

- Userspace source: `kernel/user/stage3/case15_deep_trace/user_deep_open.c`
- Driver source: `kernel/drivers/stage3/case15_deep_trace/trace_user_deep_open/trace_user_deep_open.c`
- Module: `trace_user_deep_open`
- Binary: `kernel/user/stage3/case15_deep_trace/user_deep_open`
- Run timestamp: `2026-02-15T23:32:12`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 9
- do_filp_open.ret: 9
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 3

## Commands
```bash
make -C kernel/drivers/stage3/case15_deep_trace/trace_user_deep_open
kernel/user/stage3/case15_deep_trace/user_deep_open
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case15_deep_trace/trace_user_deep_open/trace_user_deep_open.ko target_comm="user_deep_open"
sudo rmmod trace_user_deep_open
```

## Dmesg
`kernel/user/stage3/case15_deep_trace/reports/user_deep_open_dmesg.txt`

================================================================================
[EMBED] user_deep_create_dmesg.txt
[SOURCE] kernel/user/stage3/case15_deep_trace/reports/user_deep_create_dmesg.txt
================================================================================
[38312.303621] [trace_user_deep_create] loaded target_comm=user_deep_creat user=kernel/user/stage3/case15_deep_trace/user_deep_create.c
[38312.307327] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823d44
[38312.307340] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=fffffffffffffffe
[38312.307346] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823c84
[38312.307351] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=fffffffffffffffe
[38312.307356] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823be4
[38312.307361] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=fffffffffffffffe
[38312.307368] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823ab4
[38312.307371] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=fffffffffffffffe
[38312.307374] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823b74
[38312.307377] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=fffffffffffffffe
[38312.307380] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823e54
[38312.307384] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=fffffffffffffffe
[38312.307387] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823c44
[38312.307392] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=ffff8dda39edf780
[38312.307411] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823cb4
[38312.307416] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=ffff8dda39edff00
[38312.307661] [trace_user_deep_create] do_filp_open.entry pid=180559 comm=user_deep_creat dfd=4294967196 pathname=ffff8dda0d5e0000 op=ffffd0c940823c44
[38312.307688] [trace_user_deep_create] do_filp_open.ret pid=180559 comm=user_deep_creat ret=ffff8dda39edf780

================================================================================
[EMBED] user_deep_open_dmesg.txt
[SOURCE] kernel/user/stage3/case15_deep_trace/reports/user_deep_open_dmesg.txt
================================================================================
[38313.507200] [trace_user_deep_open] loaded target_comm=user_deep_open user=kernel/user/stage3/case15_deep_trace/user_deep_open.c
[38313.509826] [trace_user_deep_open] do_filp_open.entry pid=180815 comm=user_deep_open dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fe44
[38313.509838] [trace_user_deep_open] do_filp_open.ret pid=180815 comm=user_deep_open ret=fffffffffffffffe
[38313.509844] [trace_user_deep_open] do_filp_open.entry pid=180815 comm=user_deep_open dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fb34
[38313.509849] [trace_user_deep_open] do_filp_open.ret pid=180815 comm=user_deep_open ret=fffffffffffffffe
[38313.509854] [trace_user_deep_open] do_filp_open.entry pid=180815 comm=user_deep_open dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fd34
[38313.509859] [trace_user_deep_open] do_filp_open.ret pid=180815 comm=user_deep_open ret=fffffffffffffffe
[38313.509866] [trace_user_deep_open] do_filp_open.entry pid=180815 comm=user_deep_open dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fe34
[38313.509870] [trace_user_deep_open] do_filp_open.ret pid=180815 comm=user_deep_open ret=fffffffffffffffe
[38313.509873] [trace_user_deep_open] do_filp_open.entry pid=180815 comm=user_deep_open dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fda4
[38313.509876] [trace_user_deep_open] do_filp_open.ret pid=180815 comm=user_deep_open ret=fffffffffffffffe
[38313.509879] [trace_user_deep_open] do_filp_open.entry pid=180815 comm=user_deep_open dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fd04
[38313.509883] [trace_user_deep_open] do_filp_open.ret pid=180815 comm=user_deep_open ret=fffffffffffffffe
[38313.509886] [trace_user_deep_open] do_filp_open.entry pid=180815 comm=user_deep_open dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fd54
[38313.509891] [trace_user_deep_open] do_filp_open.ret pid=180815 comm=user_deep_open ret=ffff8dda03775180
[38313.509908] [trace_user_deep_open] do_filp_open.entry pid=180815 comm=user_deep_open dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fbe4
[38313.509913] [trace_user_deep_open] do_filp_open.ret pid=180815 comm=user_deep_open ret=ffff8dda03775840
[38313.510112] [trace_user_deep_open] do_filp_open.entry pid=180815 comm=user_deep_open dfd=4294967196 pathname=ffff8dda082ad000 op=ffffd0c94077fd34
[38313.510118] [trace_user_deep_open] do_filp_open.ret pid=180815 comm=user_deep_open ret=ffff8dda03775180
<!-- AUTO-EMBED END -->
