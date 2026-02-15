---
layout: default
title: "Stage 3 CASE8: Explanation"
---
[CASE]
- id: case8
- title: Creation Proof
- userspace root: [kernel/user/stage3/case8_creation_proof](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof)
- driver root: [kernel/drivers/stage3/case8_creation_proof](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case8_creation_proof)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Creation Proof.

[REPORT ARTIFACTS]
- [derive_hash_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/derive_hash_trace_report.md)
- [user_create_deep_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_create_deep_trace_report.md)
- [user_create_long_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_create_long_trace_report.md)
- [user_create_simple_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_create_simple_trace_report.md)
- [user_hash_collision_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_hash_collision_trace_report.md)
- [user_open_existing_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_open_existing_trace_report.md)
- [user_rename_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_rename_trace_report.md)

[RAW LOG ARTIFACTS]
- [derive_hash_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/derive_hash_dmesg.txt)
- [user_create_deep_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_create_deep_dmesg.txt)
- [user_create_long_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_create_long_dmesg.txt)
- [user_create_simple_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_create_simple_dmesg.txt)
- [user_hash_collision_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_hash_collision_dmesg.txt)
- [user_open_existing_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_open_existing_dmesg.txt)
- [user_rename_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case8_creation_proof/reports/user_rename_dmesg.txt)
