---
layout: default
title: "Stage 3 CASE10: Textbook"
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
- reports root: [kernel/user/stage3/case10_rename_investigation/reports](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case10_rename_investigation/reports)
- worksheets root: [kernel/user/stage3/case10_rename_investigation/worksheets](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case10_rename_investigation/worksheets)
- planning summary: [STAGE3_FULL_TEST_SUMMARY](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_FULL_TEST_SUMMARY.md)

<!-- AUTO-EMBED START -->
[AUTO] case=case10

[FOLDER] case10_rename_investigation
[INTENT] single rename internals

[INVARIANTS] source=kernel/user/stage3/case10_rename_investigation/reports/user_dir_rename_trace_report.md
- filp_open entry=8 ret=8
- __d_alloc entry=1 ret=1
- ERR_PTR(-ENOENT) count=6
- non-error file* count=2
- check: entry==ret (filp_open) => 1
- check: entry==ret (__d_alloc) => 1
<!-- AUTO-EMBED END -->
