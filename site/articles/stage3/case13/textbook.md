---
layout: default
title: "Stage 3 Case 13: Salt Avalanche: Textbook"
---
[OBJECTIVE]
- Trace open path transitions and validate entry/return pair integrity.

[MANDATORY CHECKS]
1. do_filp_open.entry count == do_filp_open.ret count
2. __d_alloc.entry count == __d_alloc.ret count
3. error-pointer observations align with missing-file paths

[DATA SOURCES]
- [reports](https://github.com/raikrahul/what-happens-when-open-is-called/tree/main/kernel/user/stage3/case13_salt_avalanche/reports)
- [worksheets](https://github.com/raikrahul/what-happens-when-open-is-called/tree/main/kernel/user/stage3/case13_salt_avalanche/worksheets)

[OUTPUT]
- Pair-level reports
- Pair-level worksheets
- Axiom + hard-axiom worksheet tiers
