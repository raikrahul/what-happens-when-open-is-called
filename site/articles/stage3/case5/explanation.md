---
layout: default
title: "Stage 3 CASE5: Explanation"
---
[CASE]
- id: case5
- title: Mount Jump
- userspace root: [kernel/user/stage3/case5_mount_jump](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case5_mount_jump)
- driver root: [kernel/drivers/stage3/case5_mount_jump](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case5_mount_jump)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Mount Jump.

[REPORT ARTIFACTS]
- [case5_mount_jump_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case5_mount_jump/reports/case5_mount_jump_trace_report.md)

[RAW LOG ARTIFACTS]
- [case5_mount_jump_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case5_mount_jump/reports/case5_mount_jump_dmesg.txt)
