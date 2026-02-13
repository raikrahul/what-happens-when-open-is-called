# Theory of Initialization: The `path_init` Starting Line

Before the VFS can resolve a string, it must establish a valid coordinate system. `path_init` in `fs/namei.c` is the deterministic state-machine that selects the initial `dentry` and `inode` from which the subsequent component walk will begin. It bifurcates the world into three distinct axiomatic starting points based on the string prefix and the process context.

### 1. The Absolute Fork: Root Jump
If the first character of the ingestion buffer is a slash (`/`), the kernel performs a "Root Jump." This bypasses the current working directory and anchors the walk to the global namespace root.
- **Code Proof**: `fs/namei.c:2568`: `if (*s == '/' && !(flags & LOOKUP_IN_ROOT))`
- **Mechanism**: `nd_jump_root(nd)` is called. It retrieves the stored `nd->root` (which defaults to the process root) and sets `nd->path` to this coordinate.
- **Result**: The GPS is now centered at Inode 2 (typically the filesystem root).

### 2. The Relative Fork: CWD (AT_FDCWD)
If the path does not start with `/` and the directory file descriptor is the sentinel `AT_FDCWD`, the kernel anchors the walk to the process's current working directory.
- **Code Proof**: `fs/namei.c:2576`: `if (nd->dfd == AT_FDCWD)`
- **Mechanism**: The kernel accesses `current->fs->pwd`. In high-performance RCU mode, it captures `fs->seq` to detect concurrent renames during the ingestion. 
- **Result**: The GPS is centered at the user's current shell directory.

### 3. The Contextual Fork: Fd-Relative
If a valid file descriptor is provided (e.g., via `openat`), the kernel anchors the walk to that specific directory handle.
- **Code Proof**: `fs/namei.c:2591`: `else { ... CLASS(fd_raw, f)(nd->dfd); ... }`
- **Mechanism**: The kernel retrieves the `struct file` associated with the FD and extracts its `f_path`. It then validates that this object is actually a directory using `d_can_lookup`.
- **Result**: The GPS is centered inside the secure, pinpointed folder provided by the application.

### The Numerical Initialization State
| Path Type | Trigger | Starting Coordinate (`nd->path`) | Cost (Axiomatic) |
| :--- | :--- | :--- | :--- |
| **Absolute** | `s[0] == '/'` | System Root (`/`) | ~50 ns (Memory Pointer Switch) |
| **Relative** | `dfd == -100` | Working Dir (`./`) | ~80 ns (Process Meta Access) |
| **Contextual**| `dfd >= 0` | Descriptor Path | ~120 ns (Fd Table Translation) |
