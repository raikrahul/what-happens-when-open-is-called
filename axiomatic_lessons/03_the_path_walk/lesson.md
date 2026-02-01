# LESSON 03: THE PATH WALK
> **Goal**: Find the Inode Number on Disk.

01. **Axiom**: A file path is a Breadcrumb Trail. "/home/r/file.txt".
02. **Axiom**: You must start at `/` (Root Inode) or `CWD` (Current Work Dir).

## THE ALGORITHM (`link_path_walk`)
01. **Start**: Inode 2 (Root).
02. **Component 1**: "home".
    - Read Inode 2's data (Directory List).
    - Find "home" -> Inode 1033.
03. **Component 2**: "r".
    - Read Inode 1033's data.
    - Find "r" -> Inode 5041.
04. **Component 3**: "file.txt".
    - Read Inode 5041's data.
    - Find "file.txt" -> Inode 9988.
05. **Result**: Found Inode 9988.

## THE CACHE (Dentry)
01. Reading disk is slow (Milliseconds).
02. Kernel keeps a Hash Table in RAM: `Dentry Cache`.
03. `hash("home")` -> Dentry Object -> Inode 1033.
04. If found in RAM -> Microseconds.

## YOUR JOB
1.  Go to `proofs/01_path_walk_simulator.c`.
2.  This program mimics the "Walk" by calling `stat` on each component.
3.  It proves that to find a deep file, you must find all parents first.
