---
layout: default
title: "Stage 3 CASE2: Explanation"
---
[CASE]
- id: case2
- title: Deep Miss
- userspace root: [kernel/user/stage3/case2_deep_miss](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case2_deep_miss)
- driver root: [kernel/drivers/stage3/case2_deep_miss](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case2_deep_miss)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Deep Miss.

[REPORT ARTIFACTS]
- [case2_deep_miss_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case2_deep_miss/reports/case2_deep_miss_trace_report.md)

[RAW LOG ARTIFACTS]
- [case2_deep_miss_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case2_deep_miss/reports/case2_deep_miss_dmesg.txt)
