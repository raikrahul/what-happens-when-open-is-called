---
layout: default
title: "Stage 3 CASE12: Textbook"
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
- reports root: [kernel/user/stage3/case12_harder_puzzle/reports](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case12_harder_puzzle/reports)
- worksheets root: [kernel/user/stage3/case12_harder_puzzle/worksheets](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case12_harder_puzzle/worksheets)
- planning summary: [STAGE3_FULL_TEST_SUMMARY](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/planning/STAGE3_FULL_TEST_SUMMARY.md)
