[STAGE 3 CASE 7: FOLLOW]
Input: good symlink
Computation: path replacement
Output: target settlement ✓

[AXIOMS]
1. get_link -> target string read ✓
2. link_path_walk restart with target ✓
3. component count reset ✓

[PROBE]
Input: get_link return
Computation: print target string
Output: target verified ✓

🐾 DONE. 🐾
