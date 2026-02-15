---
layout: default
title: "Stage 3 CASE4: Explanation"
---
[CASE]
- id: case4
- title: Create Flow
- userspace root: [kernel/user/stage3/case4_create_flow](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case4_create_flow)
- driver root: [kernel/drivers/stage3/case4_create_flow](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case4_create_flow)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Create Flow.

[REPORT ARTIFACTS]
- [case4_create_flow_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case4_create_flow/reports/case4_create_flow_trace_report.md)

[RAW LOG ARTIFACTS]
- [case4_create_flow_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case4_create_flow/reports/case4_create_flow_dmesg.txt)
