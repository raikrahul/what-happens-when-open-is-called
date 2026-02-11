---
layout: default
title: "Stage 3 Case 4: Explanation"
---

[CASE 4 EXPLANATION: O_CREAT]
Input: file creation path
Computation: intent resolution
Output: persistence

[LOGIC]
1. check existence ✗
2. allocate dentry ✓
3. filesystem create ✓

[RESULTS]
Input: ./case4_create_flow.out
Computation: inode capture @ do_last ret
Output: valid addr verified ✓

🐾 DONE. 🐾
