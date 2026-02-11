[CASE 5 EXPLANATION: MOUNT JUMP]
Input: path crossing loopback bound
Computation: mount resolution
Output: jump into sub-filesystem

[LOGIC]
1. resolve /tmp/mnt ✓
2. detect mount flag ✓
3. replace path state

[RESULTS]
Input: ./case5_mount_jump.out
Computation: path.mnt capture
Output: transition verified ✓

🐾 DONE. 🐾
