[STAGE 3 CASE 6: LOOP]
Input: infinite symlink
Computation: total_link_count increment
Output: ELOOP ✓

[AXIOMS]
1. trailing_symlink -> follow ✓
2. restart link_path_walk ✓
3. link_count > 40 -> abort ✓

[PROBE]
Input: total_link_count
Computation: capture @ trigger
Output: 40 verified ✓

🐾 DONE. 🐾
