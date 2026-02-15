---
layout: default
title: "Stage 3 CASE14: Explanation"
---
[CASE]
- id: case14
- title: Symmetry Break
- userspace root: [kernel/user/stage3/case14_symmetry_break](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case14_symmetry_break)
- driver root: [kernel/drivers/stage3/case14_symmetry_break](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case14_symmetry_break)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Symmetry Break.

[REPORT ARTIFACTS]
- [user_symmetry_break_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case14_symmetry_break/reports/user_symmetry_break_trace_report.md)

[RAW LOG ARTIFACTS]
- [user_symmetry_break_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case14_symmetry_break/reports/user_symmetry_break_dmesg.txt)
