# Trace Report: user_deep_create.c

- Userspace source: `kernel/user/stage3/case15_deep_trace/user_deep_create.c`
- Driver source: `kernel/drivers/stage3/case15_deep_trace/trace_user_deep_create/trace_user_deep_create.c`
- Module: `trace_user_deep_create`
- Binary: `kernel/user/stage3/case15_deep_trace/user_deep_create.out`
- Run timestamp: `2026-02-15T13:22:28`
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
make -C kernel/drivers/stage3/case15_deep_trace/trace_user_deep_create
kernel/user/stage3/case15_deep_trace/user_deep_create.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case15_deep_trace/trace_user_deep_create/trace_user_deep_create.ko target_comm="user_deep_creat"
sudo rmmod trace_user_deep_create
```

## Dmesg
`kernel/user/stage3/case15_deep_trace/reports/user_deep_create_dmesg.txt`
