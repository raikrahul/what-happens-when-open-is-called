# Trace Report: demo_dup_names.c

- Userspace source: `kernel/user/stage3/case1/demo_dup_names.c`
- Driver source: `kernel/drivers/stage3/case1/trace_demo_dup_names/trace_demo_dup_names.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case1/trace_demo_dup_names/trace_demo_dup_names.ko
# build userspace binary target as needed
sudo insmod trace_demo_dup_names.ko target_comm="demo_dup_names"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_demo_dup_names
```

## Notes
- Add parsed timeline and branch-path proof here.
