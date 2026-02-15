---
layout: default
title: "Stage 3 CASE10: Explanation"
---
[CASE]
- id: case10
- title: Rename Investigation
- userspace root: [kernel/user/stage3/case10_rename_investigation](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case10_rename_investigation)
- driver root: [kernel/drivers/stage3/case10_rename_investigation](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case10_rename_investigation)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Rename Investigation.

[REPORT ARTIFACTS]
- [user_dir_rename_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case10_rename_investigation/reports/user_dir_rename_trace_report.md)

[RAW LOG ARTIFACTS]
- [user_dir_rename_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case10_rename_investigation/reports/user_dir_rename_dmesg.txt)

<!-- AUTO-EMBED START -->
[AUTO] case=case10

[FOLDER] case10_rename_investigation
[INTENT] single rename internals
[BASELINE_PROBES] do_sys_openat2;do_filp_open;path_openat;lookup_open;__d_alloc
[EXTRA_PROBES] do_renameat2;vfs_rename;lock_rename
[EXPECTED_SIGNATURES] rename success/failure

================================================================================
[EMBED] user_dir_rename_trace_report.md (primary)
[SOURCE] kernel/user/stage3/case10_rename_investigation/reports/user_dir_rename_trace_report.md
================================================================================
# Trace Report: user_dir_rename.c

- Userspace source: `kernel/user/stage3/case10_rename_investigation/user_dir_rename.c`
- Driver source: `kernel/drivers/stage3/case10_rename_investigation/trace_user_dir_rename/trace_user_dir_rename.c`
- Module: `trace_user_dir_rename`
- Binary: `kernel/user/stage3/case10_rename_investigation/user_dir_rename`
- Run timestamp: `2026-02-15T23:32:04`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 8
- do_filp_open.ret: 8
- __d_alloc.entry: 1
- __d_alloc.ret: 1

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 2

## Commands
```bash
make -C kernel/drivers/stage3/case10_rename_investigation/trace_user_dir_rename
kernel/user/stage3/case10_rename_investigation/user_dir_rename
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case10_rename_investigation/trace_user_dir_rename/trace_user_dir_rename.ko target_comm="user_dir_rename"
sudo rmmod trace_user_dir_rename
```

## Dmesg
`kernel/user/stage3/case10_rename_investigation/reports/user_dir_rename_dmesg.txt`

================================================================================
[EMBED] user_dir_rename_dmesg.txt (primary)
[SOURCE] kernel/user/stage3/case10_rename_investigation/reports/user_dir_rename_dmesg.txt
================================================================================
[38305.323685] [trace_user_dir_rename] loaded target_comm=user_dir_rename user=kernel/user/stage3/case10_rename_investigation/user_dir_rename.c
[38305.326107] [trace_user_dir_rename] do_filp_open.entry pid=179009 comm=user_dir_rename dfd=4294967196 pathname=ffff8dda294d6000 op=ffffd0c941d53b64
[38305.326119] [trace_user_dir_rename] do_filp_open.ret pid=179009 comm=user_dir_rename ret=fffffffffffffffe
[38305.326126] [trace_user_dir_rename] do_filp_open.entry pid=179009 comm=user_dir_rename dfd=4294967196 pathname=ffff8dda294d6000 op=ffffd0c941d53cd4
[38305.326131] [trace_user_dir_rename] do_filp_open.ret pid=179009 comm=user_dir_rename ret=fffffffffffffffe
[38305.326137] [trace_user_dir_rename] do_filp_open.entry pid=179009 comm=user_dir_rename dfd=4294967196 pathname=ffff8dda294d6000 op=ffffd0c941d53d64
[38305.326142] [trace_user_dir_rename] do_filp_open.ret pid=179009 comm=user_dir_rename ret=fffffffffffffffe
[38305.326149] [trace_user_dir_rename] do_filp_open.entry pid=179009 comm=user_dir_rename dfd=4294967196 pathname=ffff8dda294d6000 op=ffffd0c941d53ca4
[38305.326152] [trace_user_dir_rename] do_filp_open.ret pid=179009 comm=user_dir_rename ret=fffffffffffffffe
[38305.326155] [trace_user_dir_rename] do_filp_open.entry pid=179009 comm=user_dir_rename dfd=4294967196 pathname=ffff8dda294d6000 op=ffffd0c941d53e34
[38305.326159] [trace_user_dir_rename] do_filp_open.ret pid=179009 comm=user_dir_rename ret=fffffffffffffffe
[38305.326162] [trace_user_dir_rename] do_filp_open.entry pid=179009 comm=user_dir_rename dfd=4294967196 pathname=ffff8dda294d6000 op=ffffd0c941d53c44
[38305.326166] [trace_user_dir_rename] do_filp_open.ret pid=179009 comm=user_dir_rename ret=fffffffffffffffe
[38305.326169] [trace_user_dir_rename] do_filp_open.entry pid=179009 comm=user_dir_rename dfd=4294967196 pathname=ffff8dda294d6000 op=ffffd0c941d53d54
[38305.326174] [trace_user_dir_rename] do_filp_open.ret pid=179009 comm=user_dir_rename ret=ffff8ddb02c2ff00
[38305.326193] [trace_user_dir_rename] do_filp_open.entry pid=179009 comm=user_dir_rename dfd=4294967196 pathname=ffff8dda294d6000 op=ffffd0c941d53b44
[38305.326197] [trace_user_dir_rename] do_filp_open.ret pid=179009 comm=user_dir_rename ret=ffff8ddb02c2fe40
[38305.326366] [trace_user_dir_rename] __d_alloc.entry pid=179009 comm=user_dir_rename sb=ffff8dda0bce8000 name_qstr=ffffd0c941d53b80
[38305.326370] [trace_user_dir_rename] __d_alloc.ret pid=179009 comm=user_dir_rename dentry=ffff8dda2744f0c0
<!-- AUTO-EMBED END -->
