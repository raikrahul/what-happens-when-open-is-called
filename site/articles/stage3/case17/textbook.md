---
layout: default
title: "Stage 3 CASE17: Textbook"
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
- reports root: [kernel/user/stage3/case17_do_filp_open_deep_trace/reports](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace/reports)
- worksheets root: [kernel/user/stage3/case17_do_filp_open_deep_trace/worksheets](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace/worksheets)
- planning summary: [STAGE3_FULL_TEST_SUMMARY](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_FULL_TEST_SUMMARY.md)

<!-- AUTO-EMBED START -->
[AUTO] case=case17

[FOLDER] case17_do_filp_open_deep_trace
[INTENT] missing-file dentry proof

[INVARIANTS] source=kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_raw_openat_trace_report.md
- filp_open entry=1 ret=1
- __d_alloc entry=0 ret=0
- ERR_PTR(-ENOENT) count=1
- non-error file* count=0
- check: entry==ret (filp_open) => 1
- check: entry==ret (__d_alloc) => 1

[DEEP] kernel/user/stage3/case17_do_filp_open_deep_trace/DLOOKUP_REPLAY_RUN_LOG.txt

[DEEP] kernel/user/stage3/case17_do_filp_open_deep_trace/REVERSE_FULL_TRACE_MISSING_FILE_CASE17_PSTREE.md

[DEEP] kernel/user/stage3/case17_do_filp_open_deep_trace/DLOOKUP_CRITICAL_BLOCK_NUMERIC.md

[DEEP] kernel/user/stage3/case17_do_filp_open_deep_trace/LOOKUP_OPEN_PSEUDODEBUG_TRACE_MISSING_FILE.md
<!-- AUTO-EMBED END -->
