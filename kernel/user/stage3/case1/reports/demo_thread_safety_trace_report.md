# Trace Report: demo_thread_safety.c

- Userspace source: `kernel/user/stage3/case1/demo_thread_safety/demo_thread_safety.c`
- Driver source: `kernel/drivers/stage3/case1/trace_demo_thread_safety/trace_demo_thread_safety.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case1/trace_demo_thread_safety/trace_demo_thread_safety.ko
# build userspace binary target as needed
sudo insmod trace_demo_thread_safety.ko target_comm="demo_thread_saf"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_demo_thread_safety
```

## Notes
- Add parsed timeline and branch-path proof here.
