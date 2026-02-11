---
layout: default
title: "Stage 3 Case 3: Textbook"
---

[STAGE 3 CASE 3: PATH HIT]
Input: "/tmp/a/file" (cached)
Computation: lookup_fast hit
Output: reuse dentry ✓

[AXIOMS]
1. d_lookup_rcu -> valid dentry ✓
2. skip lookup_slow ✓
3. dentry address consistency ✓

[PROBE]
Input: lookup_fast return
Computation: compare pointer to dcache
Output: pointer match ✓

🐾 DONE. 🐾
