# Trace Report: demo_at_fdcwd.c

- Userspace source: `kernel/user/stage3/case1/demo_at_fdcwd/demo_at_fdcwd.c`
- Driver source: `kernel/drivers/stage3/case1/trace_demo_at_fdcwd/trace_demo_at_fdcwd.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case1/trace_demo_at_fdcwd/trace_demo_at_fdcwd.ko
# build userspace binary target as needed
sudo insmod trace_demo_at_fdcwd.ko target_comm="demo_at_fdcwd"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_demo_at_fdcwd
```

## Notes
- Add parsed timeline and branch-path proof here.
