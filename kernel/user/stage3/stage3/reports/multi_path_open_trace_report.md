# Trace Report: multi_path_open.c

- Userspace source: `kernel/user/stage3/multi_path_open.c`
- Driver source: `kernel/drivers/stage3/stage3/trace_multi_path_open/trace_multi_path_open.c`
- Module: `trace_multi_path_open`
- Binary: `kernel/user/stage3/multi_path_open.auto.out`
- Run timestamp: `2026-02-15T01:15:43`
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
make -C kernel/drivers/stage3/stage3/trace_multi_path_open
kernel/user/stage3/multi_path_open.auto.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/stage3/trace_multi_path_open/trace_multi_path_open.ko target_comm="multi_path_open"
sudo rmmod trace_multi_path_open
```

## Dmesg
`kernel/user/stage3/stage3/reports/multi_path_open_dmesg.txt`
