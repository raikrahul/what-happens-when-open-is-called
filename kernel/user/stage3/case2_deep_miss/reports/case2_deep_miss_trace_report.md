# Trace Report: case2_deep_miss.c

- Userspace source: `kernel/user/stage3/case2_deep_miss/case2_deep_miss.c`
- Driver source: `kernel/drivers/stage3/case2_deep_miss/trace_case2_deep_miss/trace_case2_deep_miss.c`
- Module: `trace_case2_deep_miss`
- Binary: `kernel/user/stage3/case2_deep_miss/case2_deep_miss.out`
- Run timestamp: `2026-02-15T01:15:23`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 9
- do_filp_open.ret: 9
- __d_alloc.entry: 1
- __d_alloc.ret: 1

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 7
- Non-error pointer returns observed: 2

## Commands
```bash
make -C kernel/drivers/stage3/case2_deep_miss/trace_case2_deep_miss
kernel/user/stage3/case2_deep_miss/case2_deep_miss.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case2_deep_miss/trace_case2_deep_miss/trace_case2_deep_miss.ko target_comm="case2_deep_miss"
sudo rmmod trace_case2_deep_miss
```

## Dmesg
`kernel/user/stage3/case2_deep_miss/reports/case2_deep_miss_dmesg.txt`
