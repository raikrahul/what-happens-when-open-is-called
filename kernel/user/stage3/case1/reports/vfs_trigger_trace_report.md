# Trace Report: vfs_trigger.c

- Userspace source: `kernel/user/stage3/case1/vfs_trigger.c`
- Driver source: `kernel/drivers/stage3/case1/trace_vfs_trigger/trace_vfs_trigger.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case1/trace_vfs_trigger/trace_vfs_trigger.ko
# build userspace binary target as needed
sudo insmod trace_vfs_trigger.ko target_comm="vfs_trigger"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_vfs_trigger
```

## Notes
- Add parsed timeline and branch-path proof here.
