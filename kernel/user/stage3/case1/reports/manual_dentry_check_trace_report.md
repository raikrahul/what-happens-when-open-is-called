# Trace Report: manual_dentry_check.c

- Userspace source: `kernel/user/stage3/case1/manual_dentry_check.c`
- Driver source: `kernel/drivers/stage3/case1/trace_manual_dentry_check/trace_manual_dentry_check.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case1/trace_manual_dentry_check/trace_manual_dentry_check.ko
# build userspace binary target as needed
sudo insmod trace_manual_dentry_check.ko target_comm="manual_dentry_c"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_manual_dentry_check
```

## Notes
- Add parsed timeline and branch-path proof here.
