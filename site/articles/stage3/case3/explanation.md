---
layout: default
title: "Stage 3 Case 3: Explanation"
---

[CASE 3 EXPLANATION: PATH HIT]
Input: repeated path walk
Computation: dcache search
Output: zero disk I/O

[LOGIC]
1. Search hash table ✓
2. Found dentry ✓
3. Proceed to next component

[RESULTS]
Input: double open loop
Computation: capture dentry pointer
Output: addr1 == addr2 ✓

🐾 DONE. 🐾
