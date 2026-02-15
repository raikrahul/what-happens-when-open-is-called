---
layout: default
title: "Stage 3 CASE13: Explanation"
---
[CASE]
- id: case13
- title: Salt Avalanche
- userspace root: [kernel/user/stage3/case13_salt_avalanche](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case13_salt_avalanche)
- driver root: [kernel/drivers/stage3/case13_salt_avalanche](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case13_salt_avalanche)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Salt Avalanche.

[REPORT ARTIFACTS]
- [user_salt_avalanche_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case13_salt_avalanche/reports/user_salt_avalanche_trace_report.md)

[RAW LOG ARTIFACTS]
- [user_salt_avalanche_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case13_salt_avalanche/reports/user_salt_avalanche_dmesg.txt)
