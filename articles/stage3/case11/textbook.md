---
layout: default
title: "Stage 3 CASE11: Textbook"
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
- reports root: [kernel/user/stage3/case11_bulk_rename/reports](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case11_bulk_rename/reports)
- worksheets root: [kernel/user/stage3/case11_bulk_rename/worksheets](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case11_bulk_rename/worksheets)
- planning summary: [STAGE3_FULL_TEST_SUMMARY](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_FULL_TEST_SUMMARY.md)

<!-- AUTO-EMBED START -->
[AUTO] case=case11

[FOLDER] case11_bulk_rename
[INTENT] bulk rename churn

[INVARIANTS] source=kernel/user/stage3/case11_bulk_rename/reports/user_bulk_rename_trace_report.md
- filp_open entry=110 ret=110
- __d_alloc entry=0 ret=0
- ERR_PTR(-ENOENT) count=6
- non-error file* count=104
- check: entry==ret (filp_open) => 1
- check: entry==ret (__d_alloc) => 1
<!-- AUTO-EMBED END -->
