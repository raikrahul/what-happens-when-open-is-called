# Trace Report: user_dir_rename.c

- Userspace source: `kernel/user/stage3/case10_rename_investigation/user_dir_rename.c`
- Driver source: `kernel/drivers/stage3/case10_rename_investigation/trace_user_dir_rename/trace_user_dir_rename.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case10_rename_investigation/trace_user_dir_rename/trace_user_dir_rename.ko
# build userspace binary target as needed
sudo insmod trace_user_dir_rename.ko target_comm="user_dir_rename"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_user_dir_rename
```

## Notes
- Add parsed timeline and branch-path proof here.
