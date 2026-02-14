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

