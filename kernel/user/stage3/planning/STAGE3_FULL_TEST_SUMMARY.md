# Stage3 Full Test Summary

- Total pairs: 41
- pass_probe_hits: 41
- partial: 0
- fail/exception: 0

## Per pair

- 1. `kernel/user/stage3/case1/case1_relative/case1_relative.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case1/reports/case1_relative_trace_report.md`
- 2. `kernel/user/stage3/case1/case6_symlink_loop.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case1/reports/case6_symlink_loop_trace_report.md`
- 3. `kernel/user/stage3/case1/case7_symlink_fast.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case1/reports/case7_symlink_fast_trace_report.md`
- 4. `kernel/user/stage3/case1/dcache_loop_analysis.c` -> `pass_probe_hits` | filp=8/8 dalloc=0/0 | report `kernel/user/stage3/case1/reports/dcache_loop_analysis_trace_report.md`
- 5. `kernel/user/stage3/case1/demo_at_fdcwd/demo_at_fdcwd.c` -> `pass_probe_hits` | filp=11/11 dalloc=0/0 | report `kernel/user/stage3/case1/reports/demo_at_fdcwd_trace_report.md`
- 6. `kernel/user/stage3/case1/demo_dup_names.c` -> `pass_probe_hits` | filp=10/10 dalloc=0/0 | report `kernel/user/stage3/case1/reports/demo_dup_names_trace_report.md`
- 7. `kernel/user/stage3/case1/demo_o_path/demo_o_path.c` -> `pass_probe_hits` | filp=10/10 dalloc=0/0 | report `kernel/user/stage3/case1/reports/demo_o_path_trace_report.md`
- 8. `kernel/user/stage3/case1/demo_o_path/demo_o_path_dir.c` -> `pass_probe_hits` | filp=11/11 dalloc=1/1 | report `kernel/user/stage3/case1/reports/demo_o_path_dir_trace_report.md`
- 9. `kernel/user/stage3/case1/demo_o_tmpfile/demo_o_tmpfile.c` -> `pass_probe_hits` | filp=11/11 dalloc=1/1 | report `kernel/user/stage3/case1/reports/demo_o_tmpfile_trace_report.md`
- 10. `kernel/user/stage3/case1/demo_thread_safety/demo_thread_safety.c` -> `pass_probe_hits` | filp=13/13 dalloc=5/5 | report `kernel/user/stage3/case1/reports/demo_thread_safety_trace_report.md`
- 11. `kernel/user/stage3/case1/demo_toctou/demo_toctou.c` -> `pass_probe_hits` | filp=21/21 dalloc=12/12 | report `kernel/user/stage3/case1/reports/demo_toctou_trace_report.md`
- 12. `kernel/user/stage3/case1/manual_dentry_check.c` -> `pass_probe_hits` | filp=8/8 dalloc=0/0 | report `kernel/user/stage3/case1/reports/manual_dentry_check_trace_report.md`
- 13. `kernel/user/stage3/case1/test_vfs_trace.c` -> `pass_probe_hits` | filp=12/12 dalloc=0/0 | report `kernel/user/stage3/case1/reports/test_vfs_trace_trace_report.md`
- 14. `kernel/user/stage3/case1/vfs_trigger.c` -> `pass_probe_hits` | filp=10/10 dalloc=0/0 | report `kernel/user/stage3/case1/reports/vfs_trigger_trace_report.md`
- 15. `kernel/user/stage3/case10_rename_investigation/user_dir_rename.c` -> `pass_probe_hits` | filp=8/8 dalloc=1/1 | report `kernel/user/stage3/case10_rename_investigation/reports/user_dir_rename_trace_report.md`
- 16. `kernel/user/stage3/case11_bulk_rename/user_bulk_rename.c` -> `pass_probe_hits` | filp=110/110 dalloc=0/0 | report `kernel/user/stage3/case11_bulk_rename/reports/user_bulk_rename_trace_report.md`
- 17. `kernel/user/stage3/case12_harder_puzzle/puzzle_verify.c` -> `pass_probe_hits` | filp=8/8 dalloc=0/0 | report `kernel/user/stage3/case12_harder_puzzle/reports/puzzle_verify_trace_report.md`
- 18. `kernel/user/stage3/case12_harder_puzzle/user_puzzle.c` -> `pass_probe_hits` | filp=11/11 dalloc=0/0 | report `kernel/user/stage3/case12_harder_puzzle/reports/user_puzzle_trace_report.md`
- 19. `kernel/user/stage3/case13_salt_avalanche/user_salt_avalanche.c` -> `pass_probe_hits` | filp=10/10 dalloc=0/0 | report `kernel/user/stage3/case13_salt_avalanche/reports/user_salt_avalanche_trace_report.md`
- 20. `kernel/user/stage3/case14_symmetry_break/user_symmetry_break.c` -> `pass_probe_hits` | filp=10/10 dalloc=0/0 | report `kernel/user/stage3/case14_symmetry_break/reports/user_symmetry_break_trace_report.md`
- 21. `kernel/user/stage3/case15_deep_trace/user_deep_create.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case15_deep_trace/reports/user_deep_create_trace_report.md`
- 22. `kernel/user/stage3/case15_deep_trace/user_deep_open.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case15_deep_trace/reports/user_deep_open_trace_report.md`
- 23. `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists.c` -> `pass_probe_hits` | filp=10/10 dalloc=0/0 | report `kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_trace_report.md`
- 24. `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_missing.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_trace_report.md`
- 25. `kernel/user/stage3/case16_do_sys_openat2_trace/user_trigger.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case16_do_sys_openat2_trace/reports/user_trigger_trace_report.md`
- 26. `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger.c` -> `pass_probe_hits` | filp=9/9 dalloc=1/1 | report `kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_trace_report.md`
- 27. `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger_raw_openat.S` -> `pass_probe_hits` | filp=1/1 dalloc=0/0 | report `kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_raw_openat_trace_report.md`
- 28. `kernel/user/stage3/case2_deep_miss/case2_deep_miss.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case2_deep_miss/reports/case2_deep_miss_trace_report.md`
- 29. `kernel/user/stage3/case3_deep_hit/case3_deep_hit.c` -> `pass_probe_hits` | filp=10/10 dalloc=0/0 | report `kernel/user/stage3/case3_deep_hit/reports/case3_deep_hit_trace_report.md`
- 30. `kernel/user/stage3/case4_create_flow/case4_create_flow.c` -> `pass_probe_hits` | filp=10/10 dalloc=0/0 | report `kernel/user/stage3/case4_create_flow/reports/case4_create_flow_trace_report.md`
- 31. `kernel/user/stage3/case5_mount_jump/case5_mount_jump.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case5_mount_jump/reports/case5_mount_jump_trace_report.md`
- 32. `kernel/user/stage3/case6_symlink_loop/case6_symlink_loop.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case6_symlink_loop/reports/case6_symlink_loop_trace_report.md`
- 33. `kernel/user/stage3/case7_symlink_fast/case7_symlink_fast.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case7_symlink_fast/reports/case7_symlink_fast_trace_report.md`
- 34. `kernel/user/stage3/case8_creation_proof/derive_hash.c` -> `pass_probe_hits` | filp=8/8 dalloc=0/0 | report `kernel/user/stage3/case8_creation_proof/reports/derive_hash_trace_report.md`
- 35. `kernel/user/stage3/case8_creation_proof/user_create_deep.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case8_creation_proof/reports/user_create_deep_trace_report.md`
- 36. `kernel/user/stage3/case8_creation_proof/user_create_long.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case8_creation_proof/reports/user_create_long_trace_report.md`
- 37. `kernel/user/stage3/case8_creation_proof/user_create_simple.c` -> `pass_probe_hits` | filp=9/9 dalloc=1/1 | report `kernel/user/stage3/case8_creation_proof/reports/user_create_simple_trace_report.md`
- 38. `kernel/user/stage3/case8_creation_proof/user_hash_collision.c` -> `pass_probe_hits` | filp=11/11 dalloc=0/0 | report `kernel/user/stage3/case8_creation_proof/reports/user_hash_collision_trace_report.md`
- 39. `kernel/user/stage3/case8_creation_proof/user_open_existing.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case8_creation_proof/reports/user_open_existing_trace_report.md`
- 40. `kernel/user/stage3/case8_creation_proof/user_rename.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case8_creation_proof/reports/user_rename_trace_report.md`
- 41. `kernel/user/stage3/multi_path_open.c` -> `pass_probe_hits` | filp=9/9 dalloc=0/0 | report `kernel/user/stage3/case0_misc/reports/multi_path_open_trace_report.md`
