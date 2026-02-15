---
layout: default
title: "Stage 3 CASE7: Explanation"
---
[CASE]
- id: case7
- title: Symlink Follow
- userspace root: [kernel/user/stage3/case7_symlink_fast](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case7_symlink_fast)
- driver root: [kernel/drivers/stage3/case7_symlink_fast](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case7_symlink_fast)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Symlink Follow.

[REPORT ARTIFACTS]
- [case7_symlink_fast_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case7_symlink_fast/reports/case7_symlink_fast_trace_report.md)

[RAW LOG ARTIFACTS]
- [case7_symlink_fast_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case7_symlink_fast/reports/case7_symlink_fast_dmesg.txt)
