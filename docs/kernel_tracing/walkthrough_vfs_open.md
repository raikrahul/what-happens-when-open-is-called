VFS OPEN: AXIOMATIC WALKTHROUGH

01. TRAP: do_sys_openat2 (ffffffff817c0650)
    Input: RSI = 2 (O_RDWR)
    Function: Entry point for open/openat dispatcher.
    Source: fs/open.c:1388

02. TRANSFORM: build_open_flags (ffffffff817c0430)
    Logic: acc_mode = ("\004\002\006\006"[(flags)&3])
    Math: 2 & 3 = 2 → Array[2] = 6
    Result: op->acc_mode = 6 (MAY_READ | MAY_WRITE)
    Source: fs/open.c:1209

03. PROTECT: getname (ffffffff817b7380)
    Action: strncpy_from_user to kernel memory.
    Purpose: TOCTOU prevention (prevent user-space swapping path string during walk).
    Source: fs/open.c:1398

04. DISPATCH: do_filp_open (ffffffff817ced0)
    Action: Setup nameidata (nd) structure.
    Source: fs/namei.c:3819

05. RESOLVE: path_openat (ffffffff817cf10)
    Action: Main traversal loop anchor.
    Source: fs/namei.c:3780

06. TRAVERSE: link_path_walk (ffffffff817c460)
    Algorithm: 
    a. Hash component name.
    b. Lookup dentry in RCU/Dcache.
    c. If symlink → Jump to 05.
    Source: fs/namei.c:2250

07. GATE: inode_permission (ffffffff817c0a0)
    Action: do_inode_permission(inode, 6)
    Logic: (inode->i_mode & 6) == 6
    Result: 0 (Success) or -EACCES (Fail)
    Source: fs/namei.c:504

NEW THINGS INTRODUCED WITHOUT DERIVATION: NONE.
