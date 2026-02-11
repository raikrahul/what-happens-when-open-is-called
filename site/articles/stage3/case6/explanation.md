---
layout: default
title: "Stage 3 Case 6: Explanation"
---

[CASE 6 EXPLANATION: SYMLINK LOOP]
Input: A -> B -> A
Computation: recursion tracking
Output: stack protection

[LOGIC]
1. follow link ✓
2. increment counter ✓
3. limit reached ∴ kill walk

[RESULTS]
Input: ./case6_symlink_loop.out
Computation: errno check
Output: -40 (-ELOOP) verified ✓

🐾 DONE. 🐾
