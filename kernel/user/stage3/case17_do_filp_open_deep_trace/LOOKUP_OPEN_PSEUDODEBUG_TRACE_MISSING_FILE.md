# lookup_open() Pseudo-Debug Trace (Case17 Missing File) (single caller, no race)
Data source (captured): `kernel/user/stage3/case17_do_filp_open_deep_trace/DLOOKUP_REPLAY_RUN_LOG.txt`
Kernel source anchors: `/usr/src/linux-hwe-6.17-6.17.0`

Target run (captured):
- pid=75221 tgid=75221 comm=`user_trigger`
- parent dentry (dir)=`0xffff8dda3ba6f0c0`
- parent inode (dir_inode)=`0xffff8ddb28e95d98`
- superblock (parent->d_sb)=`0xffff8dda0bce8000` magic=`0xef53` blocksize=`4096`
- last component (nd->last): name=`"missing_case17_filp_75221.txt"` len=`29` hash=`0xf168d14a`

Format per line:
`#N  FUNC  STATE  file:line  caller(file:line)  values  work  result`

1.  lookup_open  CALL    fs/namei.c:3618  open_last_lookups(fs/namei.c:3815)  dir=`0xffff8dda3ba6f0c0` dir_inode=`0xffff8ddb28e95d98` open_flag=`0x0` got_write=`0`  enter  ok
2.  lookup_open  DATA    fs/namei.c:3634  lookup_open(fs/namei.c:3618)        file->f_mode: (old)=?  work=`file->f_mode &= ~FMODE_CREATED`  file->f_mode (new)=old&~FMODE_CREATED
3.  d_lookup     CALL    fs/dcache.c:2332  lookup_open(fs/namei.c:3635)       parent=`0xffff8dda3ba6f0c0` qstr.name=`"missing_case17_filp_75221.txt"` qstr.len=`29` qstr.hash=`0xf168d14a`  begin  ->
4.  __d_lookup   CALL    fs/dcache.c:2362  d_lookup(fs/dcache.c:2339)         hash=`0xf168d14a` bucket=`d_hash(0xf168d14a)`  scan `dentry_hashtable` bucket-chain  found=`NULL`
5.  d_lookup     RET     fs/dcache.c:2332  lookup_open(fs/namei.c:3635)       ret=`NULL`  cache-miss  dentry=`NULL`
6.  lookup_open  BRANCH  fs/namei.c:3637  lookup_open(fs/namei.c:3636)       cond=`(!dentry)` -> TRUE  allocate candidate via d_alloc_parallel  ->
7.  d_alloc_parallel  CALL  fs/dcache.c:2542  lookup_open(fs/namei.c:3638)    parent=`0xffff8dda3ba6f0c0` name=`"missing_case17_filp_75221.txt"` len=`29` hash=`0xf168d14a` wq=`&wq(stack)`  allocate+publish(in-lookup)  ->
8.  __d_alloc    CALL    fs/dcache.c:1684  d_alloc_parallel(fs/dcache.c:2549) sb=`0xffff8dda0bce8000` qstr_ptr=`0xffffd0c941f33a80` name_ptr=`0xffff8dda082a8083` len=`29` hash=`0xf168d14a`  slab alloc (`kmem_cache_alloc_lru`) + init name fields  ->
9.  __d_alloc    RET     fs/dcache.c:1684  d_alloc_parallel(fs/dcache.c:2549) ret(new)=`0xffff8ddc063cb3c0` new->d_inode=`0x0` new unhashed=`1` new in_lookup=`0` name.hash=`0xf168d14a` name.len=`29` name_ptr_field_addr=`0xffff8ddc063cb3f8`  dentry object exists (negative, not hashed yet)  ok
10. d_alloc_parallel  DATA  fs/dcache.c:2556  d_alloc_parallel(fs/dcache.c:2542) new=`0xffff8ddc063cb3c0`  set `DCACHE_PAR_LOOKUP`  ok
11. d_alloc_parallel  DATA  fs/dcache.c:2558  d_alloc_parallel(fs/dcache.c:2542) new->d_parent=`dget_dlock(parent=0xffff8dda3ba6f0c0)`  attach to parent pointer  ok
12. d_alloc_parallel  DATA  fs/dcache.c:2559  d_alloc_parallel(fs/dcache.c:2542) link-list: `hlist_add_head(&new->d_sib,&parent->d_children)`  attach into parent child list  ok
13. d_alloc_parallel  DATA  fs/dcache.c:2647  d_alloc_parallel(fs/dcache.c:2542) new->d_wait=`&wq(stack)`  publish waiter queue pointer  ok
14. d_alloc_parallel  DATA  fs/dcache.c:2648  d_alloc_parallel(fs/dcache.c:2542) `hlist_bl_add_head(&new->d_u.d_in_lookup_hash, in_lookup_hash(parent,hash))`  publish “lookup-in-progress” node  ok
15. d_alloc_parallel  RET   fs/dcache.c:2650  lookup_open(fs/namei.c:3638)     ret=`0xffff8ddc063cb3c0`  return candidate dentry  dentry!=ERR
16. lookup_open  BRANCH  fs/namei.c:3642  lookup_open(fs/namei.c:3636)       cond=`d_in_lookup(dentry)` -> TRUE  break out of for(;;)  ->
17. lookup_open  BRANCH  fs/namei.c:3654  lookup_open(fs/namei.c:3618)       cond=`dentry->d_inode` -> FALSE (`0x0`)  continue (not cached positive)  ->
18. lookup_open  BRANCH  fs/namei.c:3686  lookup_open(fs/namei.c:3618)       cond=`dir_inode->i_op->atomic_open` -> FALSE in this run (path uses ->lookup)  ->
19. FS->lookup   CALL    fs/namei.c:3694  lookup_open(fs/namei.c:3693)       call=`dir_inode->i_op->lookup(dir_inode=0xffff8ddb28e95d98, dentry=0xffff8ddc063cb3c0, flags=nd->flags)`  ask FS “does this name exist?”  ->
20. ext4_lookup  CALL    fs/ext4/namei.c:1762  lookup_open(fs/namei.c:3694)   dentry=`0xffff8ddc063cb3c0`  directory search  ->
21. ext4_lookup  DATA    fs/ext4/namei.c:1774  ext4_lookup(fs/ext4/namei.c:1762) inode=`NULL` on miss  missing file confirmed by FS directory scan  inode=`0x0`
22. ext4_lookup  RET     fs/ext4/namei.c:1814  lookup_open(fs/namei.c:3694)   return=`d_splice_alias(inode=0x0,dentry=0xffff8ddc063cb3c0)`  FS hands result to VFS dcache  res=`dentry*` (usually same)
23. __d_add      CALL    fs/dcache.c:2692  (via d_splice_alias)               dentry=`0xffff8ddc063cb3c0` inode=`0x0` ops=`0x0`  finalize dentry + hash it  (NOT PROBED in this run)
24. __d_add      DATA    fs/dcache.c:2699  __d_add(fs/dcache.c:2692)          cond=`d_in_lookup(dentry)` -> TRUE  remove in-lookup state via `__d_lookup_unhash(dentry)`  (NOT PROBED)
25. __d_add      DATA    fs/dcache.c:2714  __d_add(fs/dcache.c:2692)          call=`__d_rehash(dentry)`  insert into global dentry_hashtable  (NOT PROBED)
26. __d_rehash   DATA    fs/dcache.c:2489  __d_rehash(fs/dcache.c:2484)       `hlist_bl_add_head_rcu(&dentry->d_hash, d_hash(dentry->d_name.hash=0xf168d14a))`  global-hash attach happens here  (NOT PROBED)
27. lookup_open  DATA    fs/namei.c:3696  lookup_open(fs/namei.c:3693)       `d_lookup_done(dentry)`  clear lookup-in-progress flag/wake waiters  (NOT PROBED)
28. lookup_open  BRANCH  fs/namei.c:3697  lookup_open(fs/namei.c:3693)       cond=`res` -> TRUE (ext4 returned non-NULL)  if(res==dentry) net effect is keep same pointer; code does `dput(dentry); dentry=res;`  (NOT PROBED)
29. lookup_open  BRANCH  fs/namei.c:3708  lookup_open(fs/namei.c:3618)       cond=`(!dentry->d_inode && (open_flag & O_CREAT))` -> FALSE (open_flag=`0x0`)  skip create  ->
30. lookup_open  RET     fs/namei.c:3725  open_last_lookups(fs/namei.c:3815)  ret=`0xffff8ddc063cb3c0` inode=`0x0`  negative dentry returned to caller  ok

Post-proof (captured separately, confirms step #26 happened):
31. d_lookup (replay)  RET  fs/dcache.c:2332  dlookup_replay_driver            HIT ret=`0xffff8ddc063cb3c0` inode=`0x0` negative=`1` unhashed=`0`  (means: global dentry_hashtable contains it)

Notes:
- Steps marked “NOT PROBED” are kernel-source steps that were *proven indirectly* by the replay HIT (`unhashed=0`) plus the captured pre/post pointers.
- If you want direct brute proof, add kprobe+kretprobe on: `__d_add`, `__d_rehash`, and `__d_lookup_unhash` and re-run the same trigger.

