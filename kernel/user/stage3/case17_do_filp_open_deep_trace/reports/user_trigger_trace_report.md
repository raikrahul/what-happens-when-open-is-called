# Trace Report: user_trigger.c

- Userspace source: `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger.c`
- Driver source: `kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger/trace_user_trigger.c`
- Module: `trace_user_trigger`
- Binary: `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger.out`
- Run timestamp: `2026-02-15T13:08:14`
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
make -C kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger
kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger/trace_user_trigger.ko target_comm="user_trigger.ou"
sudo rmmod trace_user_trigger
```

## Dmesg
`kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_dmesg.txt`
