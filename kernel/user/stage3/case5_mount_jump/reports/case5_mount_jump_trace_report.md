# Trace Report: case5_mount_jump.c

- Userspace source: `kernel/user/stage3/case5_mount_jump/case5_mount_jump.c`
- Driver source: `kernel/drivers/stage3/case5_mount_jump/trace_case5_mount_jump/trace_case5_mount_jump.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case5_mount_jump/trace_case5_mount_jump/trace_case5_mount_jump.ko
# build userspace binary target as needed
sudo insmod trace_case5_mount_jump.ko target_comm="case5_mount_jum"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_case5_mount_jump
```

## Notes
- Add parsed timeline and branch-path proof here.
