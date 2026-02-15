---
layout: default
title: "Stage 3 CASE17: Explanation"
---
[CASE]
- id: case17
- title: Deep filp_open
- userspace root: [kernel/user/stage3/case17_do_filp_open_deep_trace](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace)
- driver root: [kernel/drivers/stage3/case17_do_filp_open_deep_trace](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case17_do_filp_open_deep_trace)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Deep filp_open.

[REPORT ARTIFACTS]
- [user_trigger_raw_openat_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_raw_openat_trace_report.md)
- [user_trigger_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_trace_report.md)

[RAW LOG ARTIFACTS]
- [user_trigger_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_dmesg.txt)
- [user_trigger_raw_openat_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_raw_openat_dmesg.txt)
