# Trace Report: case3_deep_hit.c

- Userspace source: `kernel/user/stage3/case3_deep_hit/case3_deep_hit.c`
- Driver source: `kernel/drivers/stage3/case3_deep_hit/trace_case3_deep_hit/trace_case3_deep_hit.c`
- Module: `trace_case3_deep_hit`
- Binary: `kernel/user/stage3/case3_deep_hit/case3_deep_hit.out`
- Run timestamp: `2026-02-15T13:08:17`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 10
- do_filp_open.ret: 10
- __d_alloc.entry: 1
- __d_alloc.ret: 1

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 8
- Non-error pointer returns observed: 2

## Commands
```bash
make -C kernel/drivers/stage3/case3_deep_hit/trace_case3_deep_hit
kernel/user/stage3/case3_deep_hit/case3_deep_hit.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case3_deep_hit/trace_case3_deep_hit/trace_case3_deep_hit.ko target_comm="case3_deep_hit."
sudo rmmod trace_case3_deep_hit
```

## Dmesg
`kernel/user/stage3/case3_deep_hit/reports/case3_deep_hit_dmesg.txt`
