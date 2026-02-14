# Trace Report: case7_symlink_fast.c

- Userspace source: `kernel/user/stage3/case1/case7_symlink_fast.c`
- Driver source: `kernel/drivers/stage3/case1/trace_case7_symlink_fast/trace_case7_symlink_fast.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case1/trace_case7_symlink_fast/trace_case7_symlink_fast.ko
# build userspace binary target as needed
sudo insmod trace_case7_symlink_fast.ko target_comm="case7_symlink_f"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_case7_symlink_fast
```

## Notes
- Add parsed timeline and branch-path proof here.
