---
layout: default
title: "Worksheet: Stage 3 (Path Walk)"
---

[STAGE 3 WORKSHEET: COMPONENT WALK]
Input: 7 target paths
Computation: system execution + dmesg capture
Output: verified state values

[CASE 1: RELATIVE]
Input: "some_relative_file.txt"
Computation: link_path_walk
Output: nd->last_type = ________

[CASE 2: MISS]
Input: middle component missing
Computation: walk_component return
Output: return = ________ (Expected ENOENT)

[CASE 3: HIT]
Input: repeating path
Computation: lookup_fast
Output: dentry addr = 0x________

[CASE 4: CREAT]
Input: O_CREAT
Computation: do_last
Output: dentry->d_inode = 0x________

[CASE 5: MOUNT]
Input: ext2 loopback jump
Computation: step_into
Output: mnt_A = 0x________ | mnt_B = 0x________

[CASE 6: LOOP]
Input: recursive symlink
Computation: total_link_count
Output: count = ________ (Expected 40)

[CASE 7: FOLLOW]
Input: valid symlink
Computation: get_link
Output: target = "________"

🐾 DONE. 🐾
