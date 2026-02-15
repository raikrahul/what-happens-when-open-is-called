# Trace Report: user_deep_open.c

- Userspace source: `kernel/user/stage3/case15_deep_trace/user_deep_open.c`
- Driver source: `kernel/drivers/stage3/case15_deep_trace/trace_user_deep_open/trace_user_deep_open.c`
- Module: `trace_user_deep_open`
- Binary: `kernel/user/stage3/case15_deep_trace/user_deep_open`
- Run timestamp: `2026-02-15T23:32:12`
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
make -C kernel/drivers/stage3/case15_deep_trace/trace_user_deep_open
kernel/user/stage3/case15_deep_trace/user_deep_open
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case15_deep_trace/trace_user_deep_open/trace_user_deep_open.ko target_comm="user_deep_open"
sudo rmmod trace_user_deep_open
```

## Dmesg
`kernel/user/stage3/case15_deep_trace/reports/user_deep_open_dmesg.txt`
