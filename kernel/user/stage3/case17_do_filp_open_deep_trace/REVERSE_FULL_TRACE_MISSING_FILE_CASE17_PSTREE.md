# Reverse Full Trace (Case17 Missing File) (pstree style, end -> start)
Run data source: `kernel/user/stage3/case17_do_filp_open_deep_trace/DLOOKUP_REPLAY_RUN_LOG.txt`
Kernel source anchors: `/usr/src/linux-hwe-6.17-6.17.0`

Legend (tokens used inline per-line): `CALL`=enter function, `RET`=return from function, `RESUME`=caller continues after callee returns.

0.  [ROOT] user_trigger(pid=75221 tgid=75221 comm="user_trigger") -> open("/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case17_do_filp_open_deep_trace/missing_case17_filp_75221.txt", O_RDONLY=0x0)
|
|-- #1 RET  userspace:open() -> fd=-1 errno=2(ENOENT)  path_len=114  flags=0x0  (result printed by `user_trigger.c`)
|   |
|   `-- #2 RET  kernel:do_sys_openat2  /usr/src/linux-hwe-6.17-6.17.0/fs/open.c:1420  caller=__x64_sys_openat2/?  fd_result=-2  (ENOENT)
|       |
|       `-- #3 RESUME fs/open.c:1437  do_sys_openat2 resumes after do_filp_open(dfd=AT_FDCWD? or abs path) returned IS_ERR(f)=1
|           |
|           `-- #4 RET  kernel:do_filp_open  /usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:4073  pid=75221  ret_ptr=0xfffffffffffffffe  is_err=1  err=2
|               |
|               `-- #5 RESUME fs/namei.c:4040-4063  path_openat() had alloc_empty_file() already; error path executed -> fput_close(file) (fs/namei.c:4063)
|                   |
|                   `-- #6 RET  kernel:path_openat  /usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:4034  pid=75221  error=-2
|                       |
|                       `-- #7 RESUME fs/namei.c:4049-4055  while-loop ended with error=-2 from do_open() path (not ECHILD/ESTALE)
|                           |
|                           `-- #8 RET  kernel:do_open  /usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3851  pid=75221  error=-2
|                               |
|                               `-- #9 RET  kernel:may_open  /usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3447  pid=75221  inode=0x0 -> return -2
|                                   |
|                                   `-- #10 DATA fs/namei.c:3450-3455  dentry=nd->path.dentry=(NEGATIVE)  inode=dentry->d_inode=0x0  if(!inode) return -ENOENT
|
|-- #11 RESUME (how nd->path.dentry became NEGATIVE)  do_open() at fs/namei.c:3860-3864 saw file->f_mode lacks FMODE_OPENED|FMODE_CREATED -> complete_walk() then audit/idmap then may_open()
|   |
|   `-- #12 RET  kernel:open_last_lookups  /usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3768  pid=75221  returns NULL/err-sentinel such that path_openat while-loop exits
|       |
|       `-- #13 RESUME fs/namei.c:3815  open_last_lookups called lookup_open() under inode_lock_shared()
|           |
|           `-- #14 RET  kernel:lookup_open  /usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3618  pid=75221  returns dentry=0xffff8ddc063cb3c0  d_inode=0x0  (negative)
|               |
|               |-- #15 DATA fs/namei.c:3634  file->f_mode &= ~FMODE_CREATED  (O_CREAT not set; open_flag=0x0 from userspace O_RDONLY)
|               |
|               |-- #16 RESUME fs/namei.c:3635  dentry = d_lookup(dir=0xffff8dda3ba6f0c0, name=&nd->last)
|               |   |
|               |   `-- #17 RET  kernel:d_lookup  /usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:2332  parent=0xffff8dda3ba6f0c0  qstr.hash=0xf168d14a  -> returns NULL (cache miss)
|               |       |
|               |       `-- #18 RET  kernel:__d_lookup  /usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:2362  bucket=d_hash(0xf168d14a)  scan count>=0  found=0x0
|               |
|               |-- #19 RESUME fs/namei.c:3637  if(!dentry) -> dentry=d_alloc_parallel(dir,&nd->last,&wq)
|               |   |
|               |   `-- #20 RET  kernel:d_alloc_parallel  /usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:2542  pid=75221
|               |       parent=0xffff8dda3ba6f0c0  parent_inode=0xffff8ddb28e95d98  parent_sb=0xffff8dda0bce8000  sb_magic=0xef53  sb_blocksize=4096
|               |       child_name="missing_case17_filp_75221.txt" len=29 hash=0xf168d14a
|               |       returns new=0xffff8ddc063cb3c0
|               |       |
|               |       |-- #21 DATA fs/dcache.c:2549  new = __d_alloc(parent->d_sb, name)
|               |       |   |
|               |       |   `-- #22 RET  kernel:__d_alloc  /usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:1684  qstr_ptr=0xffffd0c941f33a80 name_ptr=0xffff8dda082a8083 len=29 hash=0xf168d14a
|               |       |       -> dentry=0xffff8ddc063cb3c0  inode=0x0  unhashed=1  in_lookup=0  (captured at __d_alloc RET)
|               |       |
|               |       |-- #23 DATA fs/dcache.c:2558-2559  new->d_parent = dget_dlock(parent)  AND  hlist_add_head(&new->d_sib,&parent->d_children)
|               |       |-- #24 DATA fs/dcache.c:2647-2649  new->d_wait=&wq  AND  hlist_bl_add_head(&new->d_u.d_in_lookup_hash, in_lookup_bucket(parent,hash))
|               |       `-- #25 NOTE fs/dcache.c:2648  this is NOT global dentry_hashtable; it is the per-parent “in-lookup” chain to dedupe parallel lookups
|               |
|               |-- #26 RESUME fs/namei.c:3642-3643  if(d_in_lookup(dentry)) break;  (dentry is in-lookup now)
|               |
|               `-- #27 RESUME fs/namei.c:3693-3705  because d_in_lookup(dentry)=1:
|                   |
|                   |-- #28 CALL kernel:FS->lookup  (ext4)  dir_inode->i_op->lookup(dir_inode=0xffff8ddb28e95d98, dentry=0xffff8ddc063cb3c0, flags=nd->flags)
|                   |   |
|                   |   `-- #29 RET  kernel:ext4_lookup  /usr/src/linux-hwe-6.17-6.17.0/fs/ext4/namei.c:1762
|                   |       inode=0x0 (miss)  -> return d_splice_alias(inode=0x0, dentry=0xffff8ddc063cb3c0) at fs/ext4/namei.c:1814
|                   |
|                   |-- #30 RESUME (FS -> VFS callback)  d_splice_alias(NULL,dentry) enters dcache attach path:
|                   |   |
|                   |   |-- #31 CALL kernel:__d_add  /usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:2692  dentry=0xffff8ddc063cb3c0 inode=0x0 ops=0x0
|                   |   |-- #32 DATA fs/dcache.c:2699-2703  d_in_lookup(dentry)=1 -> __d_lookup_unhash(dentry) removes d_u.d_in_lookup_hash node (ends “lookup in progress” chain)
|                   |   |-- #33 DATA fs/dcache.c:2714  __d_rehash(dentry)
|                   |   |   |
|                   |   |   `-- #34 DATA kernel:__d_rehash  /usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:2484  b=d_hash(dentry->d_name.hash=0xf168d14a)  -> hlist_bl_add_head_rcu(&dentry->d_hash,b) at fs/dcache.c:2489
|                   |   |       RESULT: dentry=0xffff8ddc063cb3c0 now reachable by future __d_lookup(parent,qstr) bucket scan
|                   |   `-- #35 RET  __d_add returns (still inside lookup_open call stack)
|                   |
|                   |-- #36 RESUME fs/namei.c:3696  d_lookup_done(dentry) executes after FS lookup returns (clears in-lookup state / wakes waiters)
|                   |-- #37 RESUME fs/namei.c:3697-3704  res!=NULL (ext4 returned dentry*) -> dput(old_dentry) then dentry=res (same pointer in this run)
|                   `-- #38 RET  fs/namei.c:3725  lookup_open returns negative dentry 0xffff8ddc063cb3c0 (open_flag lacks O_CREAT)
|
`-- [POST-PROOF] replay verification (separate module, after the failed open)
    |
    |-- #39 CALL  d_lookup_replay_driver:init  parent=0xffff8dda3ba6f0c0  child_name="missing_case17_filp_75221.txt"  child_hash=0xf168d14a
    `-- #40 RET   d_lookup(parent,qstr) HIT  dentry=0xffff8ddc063cb3c0  inode=0x0  negative=1  unhashed=0  (proves global dentry_hashtable insert happened at fs/dcache.c:2489)

