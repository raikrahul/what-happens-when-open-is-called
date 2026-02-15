---
layout: default
title: "Stage 3 CASE16: Proof"
---
[PROOF CHECKLIST]
1. Claim -> Evidence line -> Pass/Fail.
2. Reproduction command list.
3. Counterexample path.
4. Closure check: no orphan claim.

[PRIMARY REPORT LINKS]
- [user_trigger_exists_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_trace_report.md)
- [user_trigger_missing_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_trace_report.md)

[PRIMARY DMESG LINKS]
- [user_trigger_exists_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_dmesg.txt)
- [user_trigger_missing_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_dmesg.txt)

[SECONDARY PROOF INPUTS]
- worksheet index: [STAGE3_WORKSHEET_INDEX](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_WORKSHEET_INDEX.md)
- axiom index: [STAGE3_AXIOM_WORKSHEET_INDEX](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_AXIOM_WORKSHEET_INDEX.md)
- hard index: [STAGE3_AXIOM_HARD_WORKSHEET_INDEX](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_AXIOM_HARD_WORKSHEET_INDEX.md)

<!-- AUTO-EMBED START -->
[AUTO] case=case16

[USERDIR] kernel/user/stage3/case16_do_filp_open_trace

================================================================================
[EMBED] user_trigger_exists_trace_report.md
[SOURCE] kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_trace_report.md
================================================================================
# Trace Report: user_trigger_exists.c

- Userspace source: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists.c`
- Driver source: `kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_exists/trace_user_trigger_exists.c`
- Module: `trace_user_trigger_exists`
- Binary: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists`
- Run timestamp: `2026-02-15T23:32:13`
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
make -C kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_exists
kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_exists/trace_user_trigger_exists.ko target_comm="user_trigger_ex"
sudo rmmod trace_user_trigger_exists
```

## Dmesg
`kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_dmesg.txt`

================================================================================
[EMBED] user_trigger_missing_trace_report.md
[SOURCE] kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_trace_report.md
================================================================================
# Trace Report: user_trigger_missing.c

- Userspace source: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_missing.c`
- Driver source: `kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_missing/trace_user_trigger_missing.c`
- Module: `trace_user_trigger_missing`
- Binary: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_missing`
- Run timestamp: `2026-02-15T23:32:14`
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
make -C kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_missing
kernel/user/stage3/case16_do_filp_open_trace/user_trigger_missing
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_missing/trace_user_trigger_missing.ko target_comm="user_trigger_mi"
sudo rmmod trace_user_trigger_missing
```

## Dmesg
`kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_dmesg.txt`

================================================================================
[EMBED] user_trigger_exists_dmesg.txt
[SOURCE] kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_dmesg.txt
================================================================================
[38314.577865] [trace_user_trigger_exists] loaded target_comm=user_trigger_ex user=kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists.c
[38314.581402] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bcb4
[38314.581436] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=fffffffffffffffe
[38314.581454] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bd64
[38314.581468] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=fffffffffffffffe
[38314.581485] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bc24
[38314.581502] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=fffffffffffffffe
[38314.581524] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bbe4
[38314.581536] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=fffffffffffffffe
[38314.581546] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bb14
[38314.581557] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=fffffffffffffffe
[38314.581568] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bdb4
[38314.581579] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=fffffffffffffffe
[38314.581591] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bbe4
[38314.581605] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=ffff8ddc288733c0
[38314.581651] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bc14
[38314.581664] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=ffff8ddc28873d80
[38314.582117] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bd64
[38314.582136] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=ffff8ddc288733c0
[38314.582221] [trace_user_trigger_exists] do_filp_open.entry pid=181070 comm=user_trigger_ex dfd=4294967196 pathname=ffff8dda082f2000 op=ffffd0c941d3bcd4
[38314.582233] [trace_user_trigger_exists] do_filp_open.ret pid=181070 comm=user_trigger_ex ret=ffff8ddc288733c0

================================================================================
[EMBED] user_trigger_missing_dmesg.txt
[SOURCE] kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_dmesg.txt
================================================================================
[38315.650977] [trace_user_trigger_missing] loaded target_comm=user_trigger_mi user=kernel/user/stage3/case16_do_filp_open_trace/user_trigger_missing.c
[38315.654202] [trace_user_trigger_missing] do_filp_open.entry pid=181325 comm=user_trigger_mi dfd=4294967196 pathname=ffff8dda082a8000 op=ffffd0c94079bbb4
[38315.654223] [trace_user_trigger_missing] do_filp_open.ret pid=181325 comm=user_trigger_mi ret=fffffffffffffffe
[38315.654237] [trace_user_trigger_missing] do_filp_open.entry pid=181325 comm=user_trigger_mi dfd=4294967196 pathname=ffff8dda082a8000 op=ffffd0c94079bca4
[38315.654248] [trace_user_trigger_missing] do_filp_open.ret pid=181325 comm=user_trigger_mi ret=fffffffffffffffe
[38315.654260] [trace_user_trigger_missing] do_filp_open.entry pid=181325 comm=user_trigger_mi dfd=4294967196 pathname=ffff8dda082a8000 op=ffffd0c94079bbc4
[38315.654271] [trace_user_trigger_missing] do_filp_open.ret pid=181325 comm=user_trigger_mi ret=fffffffffffffffe
[38315.654286] [trace_user_trigger_missing] do_filp_open.entry pid=181325 comm=user_trigger_mi dfd=4294967196 pathname=ffff8dda082a8000 op=ffffd0c94079bde4
[38315.654294] [trace_user_trigger_missing] do_filp_open.ret pid=181325 comm=user_trigger_mi ret=fffffffffffffffe
[38315.654300] [trace_user_trigger_missing] do_filp_open.entry pid=181325 comm=user_trigger_mi dfd=4294967196 pathname=ffff8dda082a8000 op=ffffd0c94079bd84
[38315.654308] [trace_user_trigger_missing] do_filp_open.ret pid=181325 comm=user_trigger_mi ret=fffffffffffffffe
[38315.654315] [trace_user_trigger_missing] do_filp_open.entry pid=181325 comm=user_trigger_mi dfd=4294967196 pathname=ffff8dda082a8000 op=ffffd0c94079bca4
[38315.654322] [trace_user_trigger_missing] do_filp_open.ret pid=181325 comm=user_trigger_mi ret=fffffffffffffffe
[38315.654329] [trace_user_trigger_missing] do_filp_open.entry pid=181325 comm=user_trigger_mi dfd=4294967196 pathname=ffff8dda082a8000 op=ffffd0c94079be54
[38315.654339] [trace_user_trigger_missing] do_filp_open.ret pid=181325 comm=user_trigger_mi ret=ffff8ddc26ff6f00
[38315.654376] [trace_user_trigger_missing] do_filp_open.entry pid=181325 comm=user_trigger_mi dfd=4294967196 pathname=ffff8dda082a8000 op=ffffd0c94079bb54
[38315.654386] [trace_user_trigger_missing] do_filp_open.ret pid=181325 comm=user_trigger_mi ret=ffff8ddc26ff66c0
[38315.654832] [trace_user_trigger_missing] do_filp_open.entry pid=181325 comm=user_trigger_mi dfd=4294967196 pathname=ffff8dda082a8000 op=ffffd0c94079bcb4
[38315.654843] [trace_user_trigger_missing] do_filp_open.ret pid=181325 comm=user_trigger_mi ret=fffffffffffffffe

[USERDIR] kernel/user/stage3/case16_do_sys_openat2_trace

================================================================================
[EMBED] user_trigger_trace_report.md
[SOURCE] kernel/user/stage3/case16_do_sys_openat2_trace/reports/user_trigger_trace_report.md
================================================================================
# Trace Report: user_trigger.c

- Userspace source: `kernel/user/stage3/case16_do_sys_openat2_trace/user_trigger.c`
- Driver source: `kernel/drivers/stage3/case16_do_sys_openat2_trace/trace_user_trigger/trace_user_trigger.c`
- Module: `trace_user_trigger`
- Binary: `kernel/user/stage3/case16_do_sys_openat2_trace/user_trigger`
- Run timestamp: `2026-02-15T23:32:15`
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
make -C kernel/drivers/stage3/case16_do_sys_openat2_trace/trace_user_trigger
kernel/user/stage3/case16_do_sys_openat2_trace/user_trigger
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case16_do_sys_openat2_trace/trace_user_trigger/trace_user_trigger.ko target_comm="user_trigger"
sudo rmmod trace_user_trigger
```

## Dmesg
`kernel/user/stage3/case16_do_sys_openat2_trace/reports/user_trigger_dmesg.txt`

================================================================================
[EMBED] user_trigger_dmesg.txt
[SOURCE] kernel/user/stage3/case16_do_sys_openat2_trace/reports/user_trigger_dmesg.txt
================================================================================
[38316.753785] [trace_user_trigger] loaded target_comm=user_trigger user=kernel/user/stage3/case16_do_sys_openat2_trace/user_trigger.c
[38316.756383] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3bba4
[38316.756396] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=fffffffffffffffe
[38316.756402] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3bdd4
[38316.756407] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=fffffffffffffffe
[38316.756413] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3bcf4
[38316.756418] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=fffffffffffffffe
[38316.756425] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3be34
[38316.756428] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=fffffffffffffffe
[38316.756431] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3bb34
[38316.756434] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=fffffffffffffffe
[38316.756437] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3bc44
[38316.756441] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=fffffffffffffffe
[38316.756444] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3be44
[38316.756449] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=ffff8ddc220af180
[38316.756467] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3bcc4
[38316.756472] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=ffff8ddc220afb40
[38316.756673] [trace_user_trigger] do_filp_open.entry pid=181580 comm=user_trigger dfd=4294967196 pathname=ffff8dda294d0000 op=ffffd0c940f3ba9c
[38316.756679] [trace_user_trigger] do_filp_open.ret pid=181580 comm=user_trigger ret=fffffffffffffffe
<!-- AUTO-EMBED END -->
