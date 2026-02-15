---
layout: default
title: "Stage 3 CASE12: Explanation"
---
[CASE]
- id: case12
- title: Harder Puzzle
- userspace root: [kernel/user/stage3/case12_harder_puzzle](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case12_harder_puzzle)
- driver root: [kernel/drivers/stage3/case12_harder_puzzle](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/stage3/case12_harder_puzzle)

[OBJECTIVE]
- Match Stage1/Stage2 intensity by linking every claim to reproducible logs and worksheets.

[TRACE CLAIM BLOCK]
1. Entry/return pair integrity for do_filp_open.
2. Entry/return pair integrity for __d_alloc where applicable.
3. Error-pointer vs non-error-pointer branch classification.
4. Case-specific branch proof for Harder Puzzle.

[REPORT ARTIFACTS]
- [puzzle_verify_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case12_harder_puzzle/reports/puzzle_verify_trace_report.md)
- [user_puzzle_trace_report.md](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case12_harder_puzzle/reports/user_puzzle_trace_report.md)

[RAW LOG ARTIFACTS]
- [puzzle_verify_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case12_harder_puzzle/reports/puzzle_verify_dmesg.txt)
- [user_puzzle_dmesg.txt](https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case12_harder_puzzle/reports/user_puzzle_dmesg.txt)
