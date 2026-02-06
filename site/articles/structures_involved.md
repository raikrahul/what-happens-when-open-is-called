---
layout: default
title: "Structures Involved in Filename Trace"
---

================================================================================
STRUCTURES INVOLVED IN FILENAME IDENTITY TRACE
================================================================================

This document lists all kernel structures touched during the filename settlement
trace, including their members and how they are accessed.

================================================================================
STRUCT 1: struct filename (User-space to Kernel Bridge)
================================================================================

LOCATION: Passed as argument to do_filp_open()
SOURCE: include/linux/fs.h

struct filename {
    const char          *name;          // +0  - Kernel copy of filename
    const __user char   *uptr;          // +8  - Original user pointer
    int                 refcnt;         // +16 - Reference count
    struct qstr         name_attr;      // +24 - Cached hash/length
};

MEMBERS ACCESSED IN TRACE:
  • name (char *) - Pointer to the filename string in kernel memory
    
    CAPTURED BY: open_entry() probe
    TRACE TAG: [O] IN
    PURPOSE: Entry point of filename into VFS layer

USAGE IN DRIVER:
    struct my_filename *f = (struct my_filename *)regs->si;
    f->name  // Accessed at offset +0

NOTE: The driver defines its own `struct my_filename` to match kernel layout
without requiring full kernel headers in the probe handler.

================================================================================
STRUCT 2: struct file (The Result Object)
================================================================================

LOCATION: Returned by do_filp_open() in RAX register
SOURCE: include/linux/fs.h

struct file {
    file_ref_t              f_ref;          // +0   - Reference count
    spinlock_t              f_lock;         // +8   - Lock for f_pos
    fmode_t                 f_mode;         // +12  - Open mode (read/write)
    const struct file_operations *f_op;     // +16  - File operations
    struct address_space    *f_mapping;     // +24  - Page cache mapping
    void                    *private_data;  // +32  - Private data
    struct inode            *f_inode;       // +40  - Inode pointer
    unsigned int            f_flags;        // +48  - Open flags (O_RDONLY, etc.)
    unsigned int            f_iocb_flags;   // +52  - Async I/O flags
    const struct cred       *f_cred;        // +56  - Credentials
    struct path             f_path;         // +64  - PATH STRUCT
    ...
};

MEMBERS ACCESSED IN TRACE:
  • f_path (struct path) - Located at offset +64
    
    CHAIN ACCESSED: file → f_path → dentry → d_name → name
    
    CAPTURED BY: open_ret() probe
    TRACE TAG: [O] OUT
    PURPOSE: Extracts where the filename settled in dentry cache

USAGE IN DRIVER:
    struct file *f = (struct file *)regs->ax;  // Return value
    f->f_path.dentry->d_name.name  // Chain: +64 → +8 → +32 → +8

================================================================================
STRUCT 3: struct path (Mount/Dentry Pair)
================================================================================

LOCATION: Embedded in struct file at offset +64
SOURCE: include/linux/path.h

struct path {
    struct vfsmount     *mnt;       // +0 - Mount point
    struct dentry       *dentry;    // +8 - DENTRY POINTER
};

MEMBERS ACCESSED IN TRACE:
  • dentry (struct dentry *) - Located at offset +8
    
    CAPTURED BY: Accessed via f->f_path.dentry
    PURPOSE: Gets the dentry containing the settled filename

USAGE IN DRIVER:
    f->f_path.dentry  // +64 (f_path) + 8 = +72 from struct file start

================================================================================
STRUCT 4: struct dentry (The Settlement Container)
================================================================================

LOCATION: Allocated by __d_alloc(), returned in RAX
SOURCE: include/linux/dcache.h

struct dentry {
    unsigned int            d_flags;        // +0   - Flags (DCACHE_*)
    seqcount_spinlock_t     d_seq;          // +4   - Sequence lock
    struct hlist_bl_node    d_hash;         // +8   - Hash list node
    struct dentry           *d_parent;      // +24  - Parent directory
    struct qstr             d_name;         // +32  - QSTR STRUCT
    struct inode            *d_inode;       // +48  - Associated inode (NULL=negative)
    union shortname_store   d_shortname;    // +56  - INLINE BUFFER (32 bytes)
    ...
};

MEMBERS ACCESSED IN TRACE:

1. d_name (struct qstr) - Located at offset +32
   
   CAPTURED BY: alloc_ret() and open_ret() probes
   TRACE TAG: [A] DST, [O] OUT
   PURPOSE: Contains the settled filename pointer

2. d_shortname (union) - Located at offset +56
   
   ALSO KNOWN AS: d_iname (macro alias)
   
   PURPOSE: Inline buffer for short filenames (< 32 chars)
   
   USAGE: When name->len < DNAME_INLINE_LEN (32), memcpy writes here

USAGE IN DRIVER:
    struct dentry *d = (struct dentry *)regs->ax;  // __d_alloc return
    d->d_name.name  // +32 + 8 = +40 from dentry start

================================================================================
STRUCT 5: struct qstr (Quick String)
================================================================================

LOCATION: Embedded in struct dentry at offset +32
           Also embedded in struct filename at offset +24
SOURCE: include/linux/dcache.h

struct qstr {
    union {
        struct {
            u32     hash;       // +0 - Hash value
            u32     len;        // +4 - String length
        };
        u64         hash_len;   // +0 - Combined hash+len
    };
    const unsigned char     *name;  // +8 - THE STRING POINTER
};

MEMBERS ACCESSED IN TRACE:

1. name (const unsigned char *) - Located at offset +8
   
   CAPTURED BY: alloc_entry() probe (as argument)
   TRACE TAG: [A] SRC
   PURPOSE: Source address for memcpy operation

2. hash_len (u64) - Located at offset +0
   
   PURPOSE: Pre-computed hash for fast dcache lookup

USAGE IN DRIVER:
    struct qstr *q = (struct qstr *)regs->si;  // __d_alloc argument
    q->name  // Accessed at offset +8

    // From dentry:
    d->d_name.name  // +32 (d_name) + 8 = +40 from dentry start

================================================================================
STRUCT 6: struct nameidata (Path Walking State)
================================================================================

LOCATION: Stack-allocated in do_filp_open()
SOURCE: include/linux/namei.h

struct nameidata {
    struct path     path;           // Current path during walk
    struct qstr     last;           // Final component name
    struct path     root;           // Filesystem root
    unsigned int    flags;          // LOOKUP_* flags
    ...
};

MEMBERS ACCESSED DURING PATH WALK:
  • last (struct qstr) - The filename component being looked up
    
    USAGE: Passed to d_lookup(), d_alloc() as the name argument
    
  • flags (unsigned int) - Controls lookup behavior
    
    EXAMPLES: LOOKUP_RCU, LOOKUP_CREATE, LOOKUP_DIRECTORY

NOTE: Not directly accessed in trace probes, but critical to understanding
the call chain from do_filp_open → path_openat → link_path_walk → lookup_open

================================================================================
STRUCTURE CHAIN VISUALIZATION
================================================================================

USER SPACE:
    User calls open("filename")
    ↓
    String copied to kernel via getname()
    ↓
KERNEL SPACE - INPUT CHAIN:
    struct filename (pathname argument)
        └── name → points to "filename" string
            ↓
    do_filp_open() receives this
    ↓
    struct nameidata (path walking)
        └── last (struct qstr)
            └── name → same pointer
                ↓
    __d_alloc() receives this as argument

KERNEL SPACE - ALLOCATION:
    __d_alloc() allocates:
    struct dentry
        ├── d_name (struct qstr)
        │   └── name → will point to settled location
        └── d_shortname (inline buffer at +56)
            OR kmalloc'd buffer (for long names)
    ↓
    memcpy(dname, name->name, name->len)  // fs/dcache.c:1660

KERNEL SPACE - OUTPUT CHAIN:
    struct dentry (returned by __d_alloc)
        └── d_name.name → points to settled string
            ↓
    linked into dentry cache via d_alloc_parallel()
    ↓
    lookup_open() returns this dentry
    ↓
    do_filp_open() creates:
    struct file (returned in RAX)
        └── f_path (struct path)
            └── dentry → points to settled dentry
                └── d_name.name → FINAL SETTLED STRING
                    ↓
    [O] OUT captured here

================================================================================
OFFSET SUMMARY FOR MANUAL DEREFERENCE
================================================================================

To get filename pointer from struct file * (return value):

    file_ptr = 0xffff...                          // struct file *
    + 64 = path_ptr (0xffff... + 64)              // struct path *
    + 8  = dentry_ptr = *(void **)path_ptr        // struct dentry *
    + 32 = qstr_ptr                               // struct qstr *
    + 8  = name_ptr = *(void **)qstr_ptr          // const char * ← [O] OUT

    Total: 64 + 8 → dereference → + 32 + 8 = +112 from file start

To get filename pointer from struct dentry * (__d_alloc return):

    dentry_ptr = 0xffff...                        // struct dentry *
    + 32 = qstr_ptr                               // struct qstr * (d_name)
    + 8  = name_ptr = *(void **)qstr_ptr          // const char * ← [A] DST

    Total: 32 + 8 = +40 from dentry start

================================================================================
MEMORY LAYOUT COMPARISON
================================================================================

SHORT NAME (7 chars: "l_e.txt"):
    [A] SRC: 0xffff...c020  → Points to input string in filename struct
    [A] DST: 0xffff...6f8   → Points to d_shortname (inline at dentry+56)
    Distance: ~100KB+ (kernel heap layout)

LONG NAME (64 chars):
    [A] SRC: 0xffff...e020  → Points to input string
    [A] DST: 0xffff...438   → Points to kmalloc'd buffer
    Distance: ~20MB+ (separate kmalloc allocation)

The inline buffer at +56 holds up to 32 bytes including null terminator.
Names ≥32 chars trigger kmalloc for external storage.

================================================================================
TRACE TAG TO STRUCTURE MAPPING
================================================================================

[O] IN  → struct filename.name
          do_filp_open ENTRY argument

[A] SRC → struct qstr.name  
          __d_alloc ENTRY argument

[A] DST → struct dentry.d_name.name
          __d_alloc RETURN value

[O] OUT → struct file.f_path.dentry.d_name.name
          do_filp_open RETURN value

[L] HIT → struct dentry.d_name.name
          d_lookup RETURN value (cached dentry)

================================================================================
SUMMARY
================================================================================

TOTAL STRUCTURES: 6
TOTAL MEMBERS ACCESSED: 9
TOTAL BYTES DEREFERENCED: ~120 bytes across multiple objects

CRITICAL INSIGHT:
The trace follows a single pointer (the filename string) through 4 different
kernel structures over a chain of function calls spanning:
- User-space → Kernel transition (getname)
- VFS entry (do_filp_open)  
- Path walking (nameidata)
- Dentry allocation (__d_alloc)
- Dentry cache (dcache)
- File object creation (struct file)
- Return to user (fd_install, not traced here)

The proof relies on address identity: the same pointer flows through the
entire chain, only changing when memcpy creates a physical copy in __d_alloc.
