# Trace Report: case6_symlink_loop.c

- Userspace source: `kernel/user/stage3/case1/case6_symlink_loop.c`
- Driver source: `kernel/drivers/stage3/case1/trace_case6_symlink_loop/trace_case6_symlink_loop.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case1/trace_case6_symlink_loop/trace_case6_symlink_loop.ko
# build userspace binary target as needed
sudo insmod trace_case6_symlink_loop.ko target_comm="case6_symlink_l"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_case6_symlink_loop
```

## Notes
- Add parsed timeline and branch-path proof here.
