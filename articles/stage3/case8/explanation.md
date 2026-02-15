---
layout: default
title: "Stage 3 CASE8: Explanation"
---
[CASE]
- id: case8
- title: Creation Proof
- userspace root: [kernel/user/stage3/case8_creation_proof](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof)
- driver root: [kernel/drivers/stage3/case8_creation_proof](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case8_creation_proof)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Creation Proof.

[REPORT ARTIFACTS]
- [derive_hash_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/derive_hash_trace_report.md)
- [user_create_deep_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_create_deep_trace_report.md)
- [user_create_long_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_create_long_trace_report.md)
- [user_create_simple_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_create_simple_trace_report.md)
- [user_hash_collision_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_hash_collision_trace_report.md)
- [user_open_existing_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_open_existing_trace_report.md)
- [user_rename_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_rename_trace_report.md)

[RAW LOG ARTIFACTS]
- [derive_hash_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/derive_hash_dmesg.txt)
- [user_create_deep_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_create_deep_dmesg.txt)
- [user_create_long_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_create_long_dmesg.txt)
- [user_create_simple_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_create_simple_dmesg.txt)
- [user_hash_collision_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_hash_collision_dmesg.txt)
- [user_open_existing_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_open_existing_dmesg.txt)
- [user_rename_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_rename_dmesg.txt)

<!-- AUTO-EMBED START -->
[AUTO] case=case8

[FOLDER] case8_creation_proof
[INTENT] creation and dcache proof
[BASELINE_PROBES] do_sys_openat2;do_filp_open;path_openat;lookup_open;__d_alloc
[EXTRA_PROBES] __d_alloc;d_alloc_parallel;d_lookup_done;lookup_open
[EXPECTED_SIGNATURES] allocation then lookup-done sequence

================================================================================
[EMBED] derive_hash_trace_report.md (primary)
[SOURCE] kernel/user/stage3/case8_creation_proof/reports/derive_hash_trace_report.md
================================================================================
# Trace Report: derive_hash.c

- Userspace source: `kernel/user/stage3/case8_creation_proof/derive_hash.c`
- Driver source: `kernel/drivers/stage3/case8_creation_proof/trace_derive_hash/trace_derive_hash.c`
- Module: `trace_derive_hash`
- Binary: `kernel/user/stage3/case8_creation_proof/derive_hash`
- Run timestamp: `2026-02-15T23:32:31`
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
make -C kernel/drivers/stage3/case8_creation_proof/trace_derive_hash
kernel/user/stage3/case8_creation_proof/derive_hash
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case8_creation_proof/trace_derive_hash/trace_derive_hash.ko target_comm="derive_hash"
sudo rmmod trace_derive_hash
```

## Dmesg
`kernel/user/stage3/case8_creation_proof/reports/derive_hash_dmesg.txt`

================================================================================
[EMBED] derive_hash_dmesg.txt (primary)
[SOURCE] kernel/user/stage3/case8_creation_proof/reports/derive_hash_dmesg.txt
================================================================================
[38332.409362] [trace_derive_hash] loaded target_comm=derive_hash user=kernel/user/stage3/case8_creation_proof/derive_hash.c
[38332.413077] [trace_derive_hash] do_filp_open.entry pid=183915 comm=derive_hash dfd=4294967196 pathname=ffff8dda0e689000 op=ffffd0c940e07ac4
[38332.413090] [trace_derive_hash] do_filp_open.ret pid=183915 comm=derive_hash ret=fffffffffffffffe
[38332.413096] [trace_derive_hash] do_filp_open.entry pid=183915 comm=derive_hash dfd=4294967196 pathname=ffff8dda0e689000 op=ffffd0c940e07d34
[38332.413101] [trace_derive_hash] do_filp_open.ret pid=183915 comm=derive_hash ret=fffffffffffffffe
[38332.413106] [trace_derive_hash] do_filp_open.entry pid=183915 comm=derive_hash dfd=4294967196 pathname=ffff8dda0e689000 op=ffffd0c940e07bf4
[38332.413111] [trace_derive_hash] do_filp_open.ret pid=183915 comm=derive_hash ret=fffffffffffffffe
[38332.413118] [trace_derive_hash] do_filp_open.entry pid=183915 comm=derive_hash dfd=4294967196 pathname=ffff8dda0e689000 op=ffffd0c940e07cd4
[38332.413122] [trace_derive_hash] do_filp_open.ret pid=183915 comm=derive_hash ret=fffffffffffffffe
[38332.413125] [trace_derive_hash] do_filp_open.entry pid=183915 comm=derive_hash dfd=4294967196 pathname=ffff8dda0e689000 op=ffffd0c940e07c74
[38332.413128] [trace_derive_hash] do_filp_open.ret pid=183915 comm=derive_hash ret=fffffffffffffffe
[38332.413131] [trace_derive_hash] do_filp_open.entry pid=183915 comm=derive_hash dfd=4294967196 pathname=ffff8dda0e689000 op=ffffd0c940e07d64
[38332.413134] [trace_derive_hash] do_filp_open.ret pid=183915 comm=derive_hash ret=fffffffffffffffe
[38332.413138] [trace_derive_hash] do_filp_open.entry pid=183915 comm=derive_hash dfd=4294967196 pathname=ffff8dda0e689000 op=ffffd0c940e07e04
[38332.413143] [trace_derive_hash] do_filp_open.ret pid=183915 comm=derive_hash ret=ffff8ddc12465d80
[38332.413161] [trace_derive_hash] do_filp_open.entry pid=183915 comm=derive_hash dfd=4294967196 pathname=ffff8dda0e689000 op=ffffd0c940e07d44
[38332.413166] [trace_derive_hash] do_filp_open.ret pid=183915 comm=derive_hash ret=ffff8ddc124650c0
<!-- AUTO-EMBED END -->
