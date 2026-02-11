---
layout: default
title: "Stage 3 Case 2: Explanation"
---

[CASE 2 EXPLANATION: PATH MISS]
Input: path string with missing node
Computation: component walk loop
Output: walk terminated @ missing node

[LOGIC]
1. alpha found ✓
2. beta missing ✗
3. return -ENOENT

[RESULTS]
Input: ./case2_deep_miss.out
Computation: kernel return check
Output: -2 verified ✓

🐾 DONE. 🐾
