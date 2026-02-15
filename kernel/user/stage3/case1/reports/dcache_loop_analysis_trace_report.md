# Trace Report: dcache_loop_analysis.c

- Userspace source: `kernel/user/stage3/case1/dcache_loop_analysis.c`
- Driver source: `kernel/drivers/stage3/case1/trace_dcache_loop_analysis/trace_dcache_loop_analysis.c`
- Module: `trace_dcache_loop_analysis`
- Binary: `kernel/user/stage3/case1/dcache_loop_analysis.out`
- Run timestamp: `2026-02-15T13:48:51`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 8
- do_filp_open.ret: 8
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 2

## Commands
```bash
make -C kernel/drivers/stage3/case1/trace_dcache_loop_analysis
kernel/user/stage3/case1/dcache_loop_analysis.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case1/trace_dcache_loop_analysis/trace_dcache_loop_analysis.ko target_comm="dcache_loop_ana"
sudo rmmod trace_dcache_loop_analysis
```

## Dmesg
`kernel/user/stage3/case1/reports/dcache_loop_analysis_dmesg.txt`
