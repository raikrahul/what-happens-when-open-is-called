# Trace Report: demo_o_path_dir.c

- Userspace source: `kernel/user/stage3/case1/demo_o_path/demo_o_path_dir.c`
- Driver source: `kernel/drivers/stage3/case1/trace_demo_o_path_dir/trace_demo_o_path_dir.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case1/trace_demo_o_path_dir/trace_demo_o_path_dir.ko
# build userspace binary target as needed
sudo insmod trace_demo_o_path_dir.ko target_comm="demo_o_path_dir"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_demo_o_path_dir
```

## Notes
- Add parsed timeline and branch-path proof here.
