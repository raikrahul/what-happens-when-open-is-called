---
layout: default
title: "Stage 3 CASE14: Textbook"
---
[INVARIANTS]
1. do_filp_open.entry count = do_filp_open.ret count.
2. __d_alloc.entry count = __d_alloc.ret count when allocation path is active.
3. Missing-file paths must show error-pointer class in ret stream.
4. Cross-check invariant failure paths with worksheet failure-prediction block.

[DERIVATION CHAIN]
- source: reports + dmesg
- transform: count + classify + verify
- output: pass/fail per invariant

[DATA SOURCES]
- reports root: [kernel/user/stage3/case14_symmetry_break/reports](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case14_symmetry_break/reports)
- worksheets root: [kernel/user/stage3/case14_symmetry_break/worksheets](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case14_symmetry_break/worksheets)
- planning summary: [STAGE3_FULL_TEST_SUMMARY](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_FULL_TEST_SUMMARY.md)

<!-- AUTO-EMBED START -->
[AUTO] case=case14

[FOLDER] case14_symmetry_break
[INTENT] collision/symmetry break

[INVARIANTS] source=kernel/user/stage3/case14_symmetry_break/reports/user_symmetry_break_trace_report.md
- filp_open entry=10 ret=10
- __d_alloc entry=0 ret=0
- ERR_PTR(-ENOENT) count=6
- non-error file* count=4
- check: entry==ret (filp_open) => 1
- check: entry==ret (__d_alloc) => 1
<!-- AUTO-EMBED END -->
