---
layout: default
title: "Stage 3 Case 1: Textbook"
---

[STAGE 3 CASE 1: RELATIVE PATH]
Input: "some_relative_file.txt"
Computation: path walk short‑circuit
Output: settlement ✓

[AXIOMS]
1. No slash found -> loop bypassed ✓
2. nd->last_type = LAST_NORM ✓
3. component = "some_relative_file.txt" ✓

[PROBE]
Input: link_path_walk
Computation: extract nd->last
Output: qstr verified ✓

🐾 DONE. 🐾
