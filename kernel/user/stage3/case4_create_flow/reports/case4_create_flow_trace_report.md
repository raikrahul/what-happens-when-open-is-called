# Trace Report: case4_create_flow.c

- Userspace source: `kernel/user/stage3/case4_create_flow/case4_create_flow.c`
- Driver source: `kernel/drivers/stage3/case4_create_flow/trace_case4_create_flow/trace_case4_create_flow.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case4_create_flow/trace_case4_create_flow/trace_case4_create_flow.ko
# build userspace binary target as needed
sudo insmod trace_case4_create_flow.ko target_comm="case4_create_fl"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_case4_create_flow
```

## Notes
- Add parsed timeline and branch-path proof here.
