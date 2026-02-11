---
layout: default
title: "Stage 3 Case 2: Textbook"
---

[STAGE 3 CASE 2: PATH MISS]
Input: "/tmp/nonexistent/file"
Computation: walk_component fail
Output: ENOENT ✓

[AXIOMS]
1. walk_component -> lookup_fast ✗
2. lookup_slow -> inode MISS ✓
3. return err = -2 ✓

[PROBE]
Input: walk_component ret
Computation: capture return register
Output: -2 verified ✓

🐾 DONE. 🐾
