# VFS Trace Target Map: Functions for Kprobes

This document lists all kernel functions analyzed during this session. These are the primary targets for kprobes or ftrace to verify the axiomatic derivations of path resolution and syscall behavior.

## 1. System Call Entry Points
These are the top-level gates where user-space arguments (fd, flags, mode, filename) first enter the kernel.
- `__x64_sys_open`: Entry for `open(2)`.
- `__x64_sys_stat`: Entry for `stat(2)`.
- `__x64_sys_fstat`: Entry for `fstat(2)`.
- `__x64_sys_newfstatat`: Entry for `fstatat(2)`.
- `__x64_sys_statx`: Entry for the modern `statx(2)`.

## 2. Name Ingestion Layer
These functions handle the memory copy and initial validation of the filename string.
- `getname`: Inline wrapper (passed 0 flags).
- `getname_flags`: The core ingestion function that checks `LOOKUP_EMPTY`.
- `getname_uflags`: Translates user-space `AT_` flags to kernel `LOOKUP_` flags.
- `getname_maybe_null`: The multiplexer that allows for the `NULL` pointer optimization.
- `strncpy_from_user`: The architectural boundary where the string crosses from User to Kernel memory.

## 3. VFS Translation Helpers
These functions coordinate between file descriptors (handle-logic) and path strings (name-logic).
- `vfs_stat`: Inlined with `AT_FDCWD` and 0 flags.
- `vfs_fstatat`: The shared multiplexer for all stat-family lookups.
- `vfs_fstat`: Directly accesses inode via file descriptor (Fast Path).
- `vfs_getattr`: The high-level attribute retrieval interface.
- `vfs_getattr_nosec`: Core attribute extraction (bypassing LSM hooks).

## 4. Path Resolution Engine (The Walk Loop)
These functions comprise the state machine for resolving multi-component strings.
- `path_init`: Establishes the GPS "Starting Point" (Root vs CWD vs Fd).
- `nd_jump_root`: Anchors the walk to Inode 2 (Global Root).
- `link_path_walk`: The main loop that chops the string and iterates components.
- `hash_name`: Scans for slashes and computes component hashes.
- `walk_component`: Resolves a single name component (e.g. "etc") to a dentry.
- `lookup_fast`: Performs lockless RCU dentry cache lookups.
- `step_into`: Moves the `nameidata` focus into the resolved component.

## 5. Security and Permission Gates
- `may_lookup`: Validates `EXECUTE` permissions on directories in the path.
- `security_inode_getattr`: Entry point for SELinux/AppArmor meta-data visibility.
- `may_create_in_sticky`: Specific security logic for `O_CREAT` in shared folders.
