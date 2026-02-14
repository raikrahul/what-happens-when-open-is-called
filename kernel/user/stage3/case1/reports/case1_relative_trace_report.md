# Trace Report: case1_relative.c

- Userspace source: `kernel/user/stage3/case1/case1_relative/case1_relative.c`
- Driver source: `kernel/drivers/stage3/case1/trace_case1_relative/trace_case1_relative.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case1/trace_case1_relative/trace_case1_relative.ko
# build userspace binary target as needed
sudo insmod trace_case1_relative.ko target_comm="case1_relative"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_case1_relative
```

## Notes
- Add parsed timeline and branch-path proof here.
