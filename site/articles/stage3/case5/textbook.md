[STAGE 3 CASE 5: MOUNT]
Input: boundary crossing
Computation: step_into jump
Output: vfsmount transition ✓

[AXIOMS]
1. dentry -> d_flags & DCACHE_MOUNTED ✓
2. path_init -> root vfsmount ✓
3. step_into -> new vfsmount ✓

[PROBE]
Input: step_into
Computation: extract nd->path.mnt
Output: MNT_A != MNT_B ✓

🐾 DONE. 🐾
