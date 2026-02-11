[STAGE 3 CASE 4: O_CREAT]
Input: open + O_CREAT
Computation: atomic reservation
Output: new inode instantiated ✓

[AXIOMS]
1. lookup_fast MISS ✓
2. do_last -> open_last_lookups ✓
3. vfs_create -> inode allocated ✓

[PROBE]
Input: do_last
Computation: check inode state
Output: NULL -> ADDR ✓

🐾 DONE. 🐾
