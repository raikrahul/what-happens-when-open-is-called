# Stage3 Folder Trace Matrix

Baseline probes for all executable folders:
- `do_sys_openat2` entry + return
- `do_filp_open` entry + return
- `path_openat` entry + return
- `lookup_open` entry + return
- `__d_alloc` entry + return

## Per-folder plan

### `case1`
- Intent: path-init and walk fundamentals
- Probes:
  - `path_init` entry + return
  - `link_path_walk` entry + return
  - `open_last_lookups` entry + return
  - `do_open` entry + return
  - `lookup_open` entry + return
- Expected signatures:
  - relative/open success
  - ENOENT on miss

### `case2_deep_miss`
- Intent: dcache miss path
- Probes:
  - `d_lookup` entry + return
  - `__d_lookup` entry + return
  - `d_alloc_parallel` entry + return
  - `__d_alloc` entry + return
  - `lookup_open` entry + return
- Expected signatures:
  - d_lookup miss
  - __d_alloc hit
  - ENOENT

### `case3_deep_hit`
- Intent: dcache hit path
- Probes:
  - `d_lookup` entry + return
  - `__d_lookup` entry + return
  - `d_revalidate` entry + return
  - `lookup_open` entry + return
- Expected signatures:
  - d_lookup hit
  - fewer allocations

### `case4_create_flow`
- Intent: create-if-missing
- Probes:
  - `lookup_open` entry + return
  - `atomic_open` entry + return
  - `vfs_create` entry + return
  - `may_open` entry + return
- Expected signatures:
  - FMODE_CREATED path
  - create success/permission error

### `case5_mount_jump`
- Intent: mount traversal
- Probes:
  - `follow_managed` entry + return
  - `handle_mounts` entry + return
  - `path_lookupat` entry + return
  - `link_path_walk` entry + return
- Expected signatures:
  - mount crossing observed

### `case6_symlink_loop`
- Intent: symlink loop error
- Probes:
  - `pick_link` entry + return
  - `trailing_symlink` entry + return
  - `link_path_walk` entry + return
- Expected signatures:
  - ELOOP

### `case7_symlink_fast`
- Intent: symlink resolved quickly
- Probes:
  - `pick_link` entry + return
  - `step_into` entry + return
  - `link_path_walk` entry + return
- Expected signatures:
  - symlink resolution success

### `case8_creation_proof`
- Intent: creation and dcache proof
- Probes:
  - `__d_alloc` entry + return
  - `d_alloc_parallel` entry + return
  - `d_lookup_done` entry + return
  - `lookup_open` entry + return
- Expected signatures:
  - allocation then lookup-done sequence

### `case10_rename_investigation`
- Intent: single rename internals
- Probes:
  - `do_renameat2` entry + return
  - `vfs_rename` entry + return
  - `lock_rename` entry + return
- Expected signatures:
  - rename success/failure

### `case11_bulk_rename`
- Intent: bulk rename churn
- Probes:
  - `do_renameat2` entry + return
  - `vfs_rename` entry + return
  - `d_move` entry + return
  - `d_exchange` entry + return
- Expected signatures:
  - many rename calls

### `case12_harder_puzzle`
- Intent: complex open puzzle
- Probes:
  - `path_init` entry + return
  - `link_path_walk` entry + return
  - `open_last_lookups` entry + return
  - `lookup_open` entry + return
- Expected signatures:
  - branch-specific open path

### `case13_salt_avalanche`
- Intent: name hash behavior
- Probes:
  - `full_name_hash` entry + return
  - `d_lookup` entry + return
  - `d_alloc_parallel` entry + return
- Expected signatures:
  - hash values shift by input

### `case14_symmetry_break`
- Intent: collision/symmetry break
- Probes:
  - `d_lookup` entry + return
  - `d_alloc_parallel` entry + return
  - `lookup_open` entry + return
  - `atomic_open` entry + return
- Expected signatures:
  - different branch for close names

### `case15_deep_trace`
- Intent: deep path traversal
- Probes:
  - `path_init` entry + return
  - `link_path_walk` entry + return
  - `open_last_lookups` entry + return
  - `do_open` entry + return
  - `lookup_open` entry + return
- Expected signatures:
  - deep walk timing

### `case16_do_filp_open_trace`
- Intent: do_filp_open focus
- Probes:
  - `alloc_empty_file` entry + return
  - `path_openat` entry + return
  - `do_open` entry + return
  - `fput_close` entry + return
  - `do_filp_open` entry + return
- Expected signatures:
  - ERR_PTR on fail
  - fput_close on error

### `case16_do_sys_openat2_trace`
- Intent: syscall front-door focus
- Probes:
  - `build_open_flags` entry + return
  - `getname` entry + return
  - `get_unused_fd_flags` entry + return
  - `do_filp_open` entry + return
  - `fd_install` entry + return
  - `putname` entry + return
- Expected signatures:
  - fd install only on success

### `case17_do_filp_open_deep_trace`
- Intent: missing-file dentry proof
- Probes:
  - `do_filp_open` entry + return
  - `lookup_open` entry + return
  - `atomic_open` entry + return
  - `d_alloc_parallel` entry + return
  - `__d_alloc` entry + return
  - `fput_close` entry + return
- Expected signatures:
  - __d_alloc hit + do_filp_open ERR_PTR(-ENOENT)

### `multi_path_open`
- Intent: mixed path patterns
- Probes:
  - `path_init` entry + return
  - `link_path_walk` entry + return
  - `open_last_lookups` entry + return
  - `do_open` entry + return
- Expected signatures:
  - different path classes captured

