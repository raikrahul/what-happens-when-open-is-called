# Trace Report: demo_toctou.c

- Userspace source: `kernel/user/stage3/case1/demo_toctou/demo_toctou.c`
- Driver source: `kernel/drivers/stage3/case1/trace_demo_toctou/trace_demo_toctou.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case1/trace_demo_toctou/trace_demo_toctou.ko
# build userspace binary target as needed
sudo insmod trace_demo_toctou.ko target_comm="demo_toctou"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_demo_toctou
```

## Notes
- Add parsed timeline and branch-path proof here.
