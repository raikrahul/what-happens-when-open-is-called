# Trace Report: demo_o_path.c

- Userspace source: `kernel/user/stage3/case1/demo_o_path/demo_o_path.c`
- Driver source: `kernel/drivers/stage3/case1/trace_demo_o_path/trace_demo_o_path.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case1/trace_demo_o_path/trace_demo_o_path.ko
# build userspace binary target as needed
sudo insmod trace_demo_o_path.ko target_comm="demo_o_path"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_demo_o_path
```

## Notes
- Add parsed timeline and branch-path proof here.
