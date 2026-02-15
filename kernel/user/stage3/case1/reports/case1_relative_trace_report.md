# Trace Report: case1_relative.c

- Userspace source: `kernel/user/stage3/case1/case1_relative/case1_relative.c`
- Driver source: `kernel/drivers/stage3/case1/trace_case1_relative/trace_case1_relative.c`
- Module: `trace_case1_relative`
- Binary: `kernel/user/stage3/case1/case1_relative/case1_relative.out`
- Run timestamp: `2026-02-15T13:48:47`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 9
- do_filp_open.ret: 9
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 3

## Commands
```bash
make -C kernel/drivers/stage3/case1/trace_case1_relative
kernel/user/stage3/case1/case1_relative/case1_relative.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case1/trace_case1_relative/trace_case1_relative.ko target_comm="case1_relative."
sudo rmmod trace_case1_relative
```

## Dmesg
`kernel/user/stage3/case1/reports/case1_relative_dmesg.txt`
