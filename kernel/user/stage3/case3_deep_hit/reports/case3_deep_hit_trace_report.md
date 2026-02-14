# Trace Report: case3_deep_hit.c

- Userspace source: `kernel/user/stage3/case3_deep_hit/case3_deep_hit.c`
- Driver source: `kernel/drivers/stage3/case3_deep_hit/trace_case3_deep_hit/trace_case3_deep_hit.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case3_deep_hit/trace_case3_deep_hit/trace_case3_deep_hit.ko
# build userspace binary target as needed
sudo insmod trace_case3_deep_hit.ko target_comm="case3_deep_hit"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_case3_deep_hit
```

## Notes
- Add parsed timeline and branch-path proof here.
