# Trace Report: dcache_loop_analysis.c

- Userspace source: `kernel/user/stage3/case1/dcache_loop_analysis.c`
- Driver source: `kernel/drivers/stage3/case1/trace_dcache_loop_analysis/trace_dcache_loop_analysis.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case1/trace_dcache_loop_analysis/trace_dcache_loop_analysis.ko
# build userspace binary target as needed
sudo insmod trace_dcache_loop_analysis.ko target_comm="dcache_loop_ana"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_dcache_loop_analysis
```

## Notes
- Add parsed timeline and branch-path proof here.
