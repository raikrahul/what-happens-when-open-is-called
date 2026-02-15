# Stage 3 Full Execution Plan (No Deletions)

## Scope Lock
- Root: `kernel/user/stage3/`
- Rule: do not delete existing files, folders, paragraphs, code, branches, workflows.
- Execution model: one userspace program + one dedicated driver + one report per pair.
- Driver reuse across different programs: not allowed for final evidence runs.

## Stage 3 Userspace Program Inventory (Canonical)
1. `kernel/user/stage3/case1/case1_relative/case1_relative.c`
2. `kernel/user/stage3/case1/case6_symlink_loop.c`
3. `kernel/user/stage3/case1/case7_symlink_fast.c`
4. `kernel/user/stage3/case1/dcache_loop_analysis.c`
5. `kernel/user/stage3/case1/demo_at_fdcwd/demo_at_fdcwd.c`
6. `kernel/user/stage3/case1/demo_dup_names.c`
7. `kernel/user/stage3/case1/demo_o_path/demo_o_path.c`
8. `kernel/user/stage3/case1/demo_o_path/demo_o_path_dir.c`
9. `kernel/user/stage3/case1/demo_o_tmpfile/demo_o_tmpfile.c`
10. `kernel/user/stage3/case1/demo_thread_safety/demo_thread_safety.c`
11. `kernel/user/stage3/case1/demo_toctou/demo_toctou.c`
12. `kernel/user/stage3/case1/manual_dentry_check.c`
13. `kernel/user/stage3/case1/test_vfs_trace.c`
14. `kernel/user/stage3/case1/vfs_trigger.c`
15. `kernel/user/stage3/case10_rename_investigation/user_dir_rename.c`
16. `kernel/user/stage3/case11_bulk_rename/user_bulk_rename.c`
17. `kernel/user/stage3/case12_harder_puzzle/puzzle_verify.c`
18. `kernel/user/stage3/case12_harder_puzzle/user_puzzle.c`
19. `kernel/user/stage3/case13_salt_avalanche/user_salt_avalanche.c`
20. `kernel/user/stage3/case14_symmetry_break/user_symmetry_break.c`
21. `kernel/user/stage3/case15_deep_trace/user_deep_create.c`
22. `kernel/user/stage3/case15_deep_trace/user_deep_open.c`
23. `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists.c`
24. `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_missing.c`
25. `kernel/user/stage3/case16_do_sys_openat2_trace/user_trigger.c`
26. `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger.c`
27. `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger_raw_openat.S`
28. `kernel/user/stage3/case2_deep_miss/case2_deep_miss.c`
29. `kernel/user/stage3/case3_deep_hit/case3_deep_hit.c`
30. `kernel/user/stage3/case4_create_flow/case4_create_flow.c`
31. `kernel/user/stage3/case5_mount_jump/case5_mount_jump.c`
32. `kernel/user/stage3/case6_symlink_loop/case6_symlink_loop.c`
33. `kernel/user/stage3/case7_symlink_fast/case7_symlink_fast.c`
34. `kernel/user/stage3/case8_creation_proof/derive_hash.c`
35. `kernel/user/stage3/case8_creation_proof/user_create_deep.c`
36. `kernel/user/stage3/case8_creation_proof/user_create_long.c`
37. `kernel/user/stage3/case8_creation_proof/user_create_simple.c`
38. `kernel/user/stage3/case8_creation_proof/user_hash_collision.c`
39. `kernel/user/stage3/case8_creation_proof/user_open_existing.c`
40. `kernel/user/stage3/case8_creation_proof/user_rename.c`
41. `kernel/user/stage3/multi_path_open.c`

## Existing Stage 3 Driver Baseline
- Present now:
1. `kernel/drivers/stage3/case1/trace_path_init/trace_path_init.c`
2. `kernel/drivers/stage3/case1/trace_path_init/trace_d_lookup.c`
3. `kernel/drivers/stage3/case1/trace_path_init/trace_lpw.c`
4. `kernel/drivers/stage3/case1/trace_path_init/trace_lpw_safe.c`
5. `kernel/drivers/stage3/case1/trace_path_init/trace_lpw_v2.c`
6. `kernel/drivers/stage3/case1/trace_path_init/trace_lpw_v4.c`
7. `kernel/drivers/stage3/case1/trace_path_init/trace_offset_proof.c`
8. `kernel/drivers/stage3/case1/trace_do_sys_openat2/trace_do_sys_openat2.c`
9. `kernel/drivers/stage3/case1/vfs_depth_probe.c`

## Required New Structure (Per Program)
For each userspace program listed above:
1. create dedicated driver folder under `kernel/drivers/stage3/<case>/trace_<program>/`
2. add dedicated `<trace_program>.c`
3. add dedicated Makefile
4. compile + insmod + run userspace + capture dmesg + rmmod
5. save report in `kernel/user/stage3/<case>/reports/<program>_trace_report.md`
6. save raw dmesg in `kernel/user/stage3/<case>/reports/<program>_dmesg.txt`

## Standard Probe Set (Minimal Safe Baseline)
1. `do_filp_open` kprobe
2. `do_filp_open` kretprobe
3. `__d_alloc` kprobe
4. `__d_alloc` kretprobe

## Optional Probe Extensions (per case objective)
1. `path_openat`
2. `do_open`
3. `lookup_open`
4. `atomic_open`
5. `d_alloc_parallel`
6. `d_lookup`
7. `dput`
8. `fput_close`

## Acceptance Criteria (Per Pair)
1. target process filter (`target_comm`) enabled
2. program run captured in logs
3. entry/exit evidence for success/failure path
4. explicit note: dentry allocated vs attached-to-file timing
5. module unload cleanly without warning/oops

## Risk Control
1. keep probe count minimal per dedicated driver
2. avoid deep field deref in atomic/unsafe context unless guarded
3. prefer pointer/value logging first, optional string logging second
4. one driver loaded at a time


## PLANNING-ONLY ERROR REGISTER (INSIDE-OUT, NO FIXES APPLIED)

1. `site/index.html:76-82` -> only `case1..case7` linked -> should link full Stage3 set (case1..case17 + mapped names).
2. `site/index.html:71` + `site/index.html:102` -> duplicated sell CTA blocks -> should be single canonical CTA block.
3. `site/articles/stage3/case15/index.md:1-4` -> stub only (front matter, no body) -> should include full content sections matching case1..case7 pattern.
4. `site/articles/stage3/` -> missing directories `case8..case14, case16, case17` -> should exist with `index.md/explanation.md/textbook.md/worksheet.md`.
5. `site/articles/stage3/` -> no `case10..case14` web pages though kernel/user data exists -> should map each case folder to website case folder.
6. `site/articles/stage3_pathwalk.html:21-31` -> generic iframe doc not tied to full case matrix -> should include navigation to every case page.
7. `kernel/user/stage3/planning/STAGE3_DRIVER_PAIR_MATRIX.csv` -> 41 pair scope exists -> should be reflected in website IA, currently not.
8. `kernel/user/stage3/planning/STAGE3_WORKSHEET_INDEX.md` -> worksheet index exists -> should have mirrored link surface in site docs.
9. `kernel/user/stage3/planning/STAGE3_AXIOM_WORKSHEET_INDEX.md` -> axiom index exists -> should be discoverable via site/article index.
10. `kernel/user/stage3/planning/STAGE3_AXIOM_HARD_WORKSHEET_INDEX.md` -> hard index exists -> should be linked from Stage3 top page.
11. `site/index.html` -> no link to full summary artifacts -> should link `STAGE3_FULL_TEST_SUMMARY` outputs.
12. `site/index.html` -> no status indicator for finished 41/41 -> should show numeric completion banner.
13. `site/articles/stage3/case1..7/index.md` pattern exists -> case creation consistency missing for remaining cases -> should apply same file contract.
14. `kernel/user/stage3/case15_deep_trace_solution/` exists but no site mapping rule -> should define include/exclude policy.
15. `kernel/user/stage3/STAGE3_RESULTS_20260213_170251/` logs present but no publication policy -> should define artifact exposure boundary.
16. `site/articles` has mixed standalone stage pages + case pages -> should define one canonical Stage3 navigation strategy.
17. `site/index.html` only two-column grid -> should verify scalability for 17+ links.
18. `site/index.html` uses raw hardcoded links -> should derive from single source index manifest.
19. `kernel/user/stage3/planning/run_full_stage3_tests.py` outputs reports -> should define webpage ingestion path for generated reports.
20. `site/articles/stage3/case15/index.md` no naming metadata for case id -> should include explicit `case_id`, `case_slug` fields.
21. `site/articles/stage3/case1/proofs.md` exists only for case1 -> should define proofs file requirement for all cases or remove asymmetry.
22. `kernel/user/stage3/case17.../worksheets/*` has 3 tiers -> website currently lacks tier chooser.
23. `kernel/user/stage3/*/reports/*_trace_report.md` populated -> no index page listing all reports -> should add report manifest.
24. `kernel/user/stage3/*/reports/*_dmesg.txt` populated -> no textual caution page for raw kernel logs -> should define disclosure policy.
25. `site/articles/stage3/` lacks `README`/map file -> should add `index manifest` file for generation integrity.
26. `Cargo.toml` scan result empty -> request to "check cargo files" has no target -> should record explicit zero-cargo status.
27. `Makefile` has publish/build paths -> no stage3-specific publish validation target -> should define `check-stage3-site` target.
28. `site/index.html` stage label says "Path Walk Investigations" -> scope now broader (rename, salt, symmetry) -> should rename stage heading to full scope.
29. `site/index.html` case labels fixed to first 7 semantics -> should align labels to actual case folder semantics.
30. `kernel/user/stage3/case16_do_sys_openat2_trace` ignored paths history exists -> should define gitignore exception policy for reports/worksheets.
31. `kernel/user/stage3/planning/worksheet_backups_*` includes copied axiom files -> backup policy unclear -> should define backup purity (original-only vs all).
32. `site/articles/convert_md.py` generation workflow present -> missing documented build contract for new case folders -> should define mandatory front matter schema.
33. `site/articles/stage3/case15/index.md` created without `textbook/worksheet/explanation` siblings -> should enforce completeness check.
34. `site/articles` has old stage3 wrapper docs (`*_stage3_pathwalk.md`) not mapped to all cases -> should classify legacy vs current docs.
35. `site/index.html` includes sell CTA above stage grid -> no explicit learning CTA hierarchy -> should define conversion vs learning priority.
36. `kernel/user/stage3/planning/STAGE3_FOLDER_TRACE_MATRIX.md` exists -> website does not expose it -> should provide public matrix page.
37. `kernel/user/stage3/planning/STAGE3_PROBE_FLOW_GRAPH.md` exists -> not published linkable from stage page -> should surface graph link.
38. `kernel/user/stage3/planning/STAGE3_PROBE_HEATMAP_SOURCE.csv` exists -> no visual embed path -> should define chart rendering path.
39. `kernel/user/stage3/planning/STAGE3_FULL_TEST_SUMMARY.md` exists -> not discoverable from stage landing -> should add summary link block.
40. `kernel/user/stage3/planning/STAGE3_FULL_TEST_SUMMARY.csv` exists -> no machine-readable exposure note -> should add data usage note.
41. `kernel/user/stage3/case0_misc/reports/multi_path_open_trace_report.md` path includes duplicated `stage3/case0_misc` -> should normalize naming rule.
42. `kernel/drivers/stage3/case0_misc/trace_multi_path_open` mirrored naming anomaly -> should enforce folder naming lint.
43. `site/articles/stage3/case1..7` have built html siblings -> missing html for future cases until build generated -> should add generation check in CI.
44. `site/index.html` no "pending cases" indicator -> should display pending counter until full page set is present.
45. `kernel/user/stage3/case*/worksheets/*_worksheet_axiom_hard.md` generated -> no statement of intended audience/usage -> should add usage legend file.
46. `site/articles/stage3/caseX/worksheet` pages expected print mode pattern -> missing consistency check for future case pages.
47. `site/articles/stage3/caseX/textbook` expected pairing -> missing consistency check for future case pages.
48. `site/articles/stage3/caseX/explanation` expected pairing -> missing consistency check for future case pages.
49. `site/index.html` no direct link to Stage3 planning docs -> should add planning/docs block.
50. `kernel/user/stage3/planning` has many index files -> no master meta-index linking all indexes -> should create one.

51. `why sloppy` -> `scope=41` known, `links=7` shipped -> `missed` release gate on link count -> `prevent` add gate `count(site cases)==count(matrix groups)`.
52. `why sloppy` -> duplicated CTA shipped -> `missed` diff review on homepage sections -> `prevent` static rule `single_sell_block`.
53. `why sloppy` -> stub case page committed -> `missed` completeness check -> `prevent` fail build if any case has only index front matter.
54. `why sloppy` -> artifact-rich backend, thin frontend -> `missed` publish parity checklist -> `prevent` parity table mandatory before publish.
55. `why sloppy` -> naming anomaly `stage3/case0_misc` persisted -> `missed` path-lint step -> `prevent` add path regex checks.
56. `why sloppy` -> cargo task requested with zero cargo files -> `missed` environment verification first -> `prevent` preflight section "tooling existence".
57. `why sloppy` -> backup grew with generated files -> `missed` backup scope definition -> `prevent` policy file before batch generation.
58. `why sloppy` -> no public index for 41 reports -> `missed` discoverability requirements -> `prevent` explicit artifact publication matrix.
59. `why sloppy` -> no Stage3 completion badge -> `missed` user-facing status requirement -> `prevent` dashboard block requirement.
60. `why sloppy` -> inconsistent case doc contract -> `missed` schema-driven generator -> `prevent` generate cases from manifest only.

61. `counter-Q` -> matrix has 41 pairs; website needs how many case nodes: `17?` `41?` `17+subpages?`.
62. `counter-Q` -> one case page per case folder or one page per pair?
63. `counter-Q` -> expose raw dmesg publicly: full, redacted, or none?
64. `counter-Q` -> include sales CTA on learning page or separate route?
65. `counter-Q` -> stage order by case number or by concept cluster?
66. `counter-Q` -> case8 has 7 userspace programs; show as one case page with sub-table or 7 subpages?
67. `counter-Q` -> case16 has two traces; merge or split?
68. `counter-Q` -> should case15_deep_trace_solution appear publicly?
69. `counter-Q` -> should backup folders be excluded from repo-facing docs?
70. `counter-Q` -> should hard worksheets be default or opt-in?
71. `counter-Q` -> should index pages include pass/fail counts from last run only or historical trend?
72. `counter-Q` -> should naming normalize `case10_rename_investigation` to `case10` on web path?
73. `counter-Q` -> should stage3 wrapper iframe stay or be replaced by direct case list page?
74. `counter-Q` -> should each case page embed report links directly from planning CSV?
75. `counter-Q` -> should generation use static checked-in md or generated from summary CSV each publish?

76. `phase-plan A (no fix)` -> collect canonical manifest from `STAGE3_DRIVER_PAIR_MATRIX.csv` grouped by case.
77. `phase-plan B (no fix)` -> define website IA contract `{case}/index,explanation,textbook,worksheet`.
78. `phase-plan C (no fix)` -> define naming normalization table for folder→web slug.
79. `phase-plan D (no fix)` -> define artifact exposure table (public/private/internal).
80. `phase-plan E (no fix)` -> define release gates: link count, page completeness, naming lint, summary link presence.
81. `phase-plan F (no fix)` -> define test matrix: build site, case page existence, broken-link scan, markdown schema check.
82. `phase-plan G (no fix)` -> define cargo check rule outcome `no cargo files` with explicit skip rationale.
83. `phase-plan H (no fix)` -> define commit slicing: IA files, case pages batch, index updates, validation artifacts.
84. `phase-plan I (no fix)` -> define post-publish verify script against live URL and local parity.

85. `pending execution tasks after planning` -> compile user programs, build drivers, rerun stage3 tests, naming normalization, index repair, cargo preflight check (expect zero), commit, push, retest.

