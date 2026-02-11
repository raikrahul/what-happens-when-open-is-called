---
layout: default
title: "Stage 3 Case 1: Explanation"
---

[CASE 1 EXPLANATION: RELATIVE PATH]
Input: open("file")
Computation: path walk entry
Output: no separation logic triggered

[LOGIC]
1. link_path_walk(name) -> search for '/'
2. No '/' -> nd->last = name
3. nd->last_type = LAST_NORM
4. Return to do_last

[RESULTS]
Input: kprobe @ link_path_walk
Computation: print nd->last.name
Output: "some_relative_file.txt" ✓

🐾 DONE. 🐾
