---
layout: default
title: "Stage 3 CASE16: Explanation"
---
[CASE]
- id: case16
- title: filp_open + sys_openat2
- userspace root: [kernel/user/stage3/case16_do_filp_open_trace](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace)
- driver root: [kernel/drivers/stage3/case16_do_filp_open_trace](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case16_do_filp_open_trace)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for filp_open + sys_openat2.

[REPORT ARTIFACTS]
- [user_trigger_exists_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_trace_report.md)
- [user_trigger_missing_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_trace_report.md)

[RAW LOG ARTIFACTS]
- [user_trigger_exists_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_dmesg.txt)
- [user_trigger_missing_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_dmesg.txt)
