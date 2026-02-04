# LESSON 04: THE ALLOCATION
> **Goal**: Create the `struct file` in RAM to track your position.

01. **Axiom**: Finding the file (Inode) is not enough. We need to track *your* usage (Offset).
02. **Axiom**: `struct file` is the object that represents an "Open File".

## THE OBJECTS (Kernel Memory)
01. **Inode (Disk/Cache)**: Represents the Data. Shared by everyone.
02. **File (RAM)**: Represents the *Cursor*. Private to you (mostly).
03. **Action**: `open()` calls `kmem_cache_alloc` to grab a fresh `struct file`.

## THE MATH OF ALLOCATION
01. `slabtop` shows `filp` (File Pointer) cache.
02. Size is usually 256 bytes (approx).
03. **Linkage**:
    - `file->f_inode` points to the Inode (Stage 3).
    - `file->f_pos` starts at 0.

## THE FILE DESCRIPTOR TABLE
01. Your process has `struct files_struct`.
02. It has an array `fd_array[]`.
03. **Algorithm**: Find the first `NULL` slot.
04. Usually Slot 0, 1, 2 are taken (Stdin, Stdout, Stderr).
05. System returns index `3`.
06. `fd_array[3] = pointer_to_struct_file`.

## YOUR JOB
1.  Visualize this.
2.  Inode = The Book in the Library.
3.  Struct File = Your Bookmark.
4.  FD = The Card in your pocket saying "Bookmark #3".
