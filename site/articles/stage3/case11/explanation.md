---
layout: default
title: "Stage 3 CASE11: Explanation"
---
[CASE]
- id: case11
- title: Bulk Rename
- userspace root: [kernel/user/stage3/case11_bulk_rename](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case11_bulk_rename)
- driver root: [kernel/drivers/stage3/case11_bulk_rename](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case11_bulk_rename)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Bulk Rename.

[REPORT ARTIFACTS]
- [user_bulk_rename_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case11_bulk_rename/reports/user_bulk_rename_trace_report.md)

[RAW LOG ARTIFACTS]
- [user_bulk_rename_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case11_bulk_rename/reports/user_bulk_rename_dmesg.txt)
