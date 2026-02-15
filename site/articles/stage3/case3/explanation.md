---
layout: default
title: "Stage 3 CASE3: Explanation"
---
[CASE]
- id: case3
- title: Deep Hit
- userspace root: [kernel/user/stage3/case3_deep_hit](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case3_deep_hit)
- driver root: [kernel/drivers/stage3/case3_deep_hit](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case3_deep_hit)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Deep Hit.

[REPORT ARTIFACTS]
- [case3_deep_hit_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case3_deep_hit/reports/case3_deep_hit_trace_report.md)

[RAW LOG ARTIFACTS]
- [case3_deep_hit_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case3_deep_hit/reports/case3_deep_hit_dmesg.txt)
