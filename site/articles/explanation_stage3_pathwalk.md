---
layout: default
title: "Explanation: Stage 3 (Path Walk)"
---

[STAGE 3: FILENAME WALK COMPONENTS]
Input: path string
Computation: iterative resolution
Output: result state

[FLOW]
1. Relative: link_path_walk(name, nd)
2. Deep: walk_component -> lookup_fast / lookup_slow
3. Boundary: step_into -> mount jump
4. Limit: total_link_count -> symlink loop

[DERIVATION]
Input: "some_relative_file.txt"
Computation: path walk entry
Output: no separation → immediate settlement ✓

Input: "/tmp/a/b/c"
Computation: walk iteration
Output: ptr2 = ptr1 + strlen(comp) + 1 ✓

Input: Mount Point
Computation: d_flags & DCACHE_MOUNTED
Output: path transition to target vfsmount ✓

Input: Symlink
Computation: get_link
Output: path string replacement ✓

[VERIFICATION]
Input: 7 binaries
Computation: kprobe instrumentation
Output: Axiomatic Proofs ✓

🐾 DONE. 🐾
