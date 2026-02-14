# Trace Report: case2_deep_miss.c

- Userspace source: `kernel/user/stage3/case2_deep_miss/case2_deep_miss.c`
- Driver source: `kernel/drivers/stage3/case2_deep_miss/trace_case2_deep_miss/trace_case2_deep_miss.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case2_deep_miss/trace_case2_deep_miss/trace_case2_deep_miss.ko
# build userspace binary target as needed
sudo insmod trace_case2_deep_miss.ko target_comm="case2_deep_miss"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_case2_deep_miss
```

## Notes
- Add parsed timeline and branch-path proof here.
