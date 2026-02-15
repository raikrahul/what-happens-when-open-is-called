# Trace Report: user_dir_rename.c

- Userspace source: `kernel/user/stage3/case10_rename_investigation/user_dir_rename.c`
- Driver source: `kernel/drivers/stage3/case10_rename_investigation/trace_user_dir_rename/trace_user_dir_rename.c`
- Module: `trace_user_dir_rename`
- Binary: `kernel/user/stage3/case10_rename_investigation/user_dir_rename`
- Run timestamp: `2026-02-15T23:32:04`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 8
- do_filp_open.ret: 8
- __d_alloc.entry: 1
- __d_alloc.ret: 1

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 2

## Commands
```bash
make -C kernel/drivers/stage3/case10_rename_investigation/trace_user_dir_rename
kernel/user/stage3/case10_rename_investigation/user_dir_rename
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case10_rename_investigation/trace_user_dir_rename/trace_user_dir_rename.ko target_comm="user_dir_rename"
sudo rmmod trace_user_dir_rename
```

## Dmesg
`kernel/user/stage3/case10_rename_investigation/reports/user_dir_rename_dmesg.txt`
