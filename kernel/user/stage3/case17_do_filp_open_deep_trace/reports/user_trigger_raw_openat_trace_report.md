# Trace Report: user_trigger_raw_openat.S

- Userspace source: `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger_raw_openat.S`
- Driver source: `kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger_raw_openat/trace_user_trigger_raw_openat.c`
- Module: `trace_user_trigger_raw_openat`
- Binary: `kernel/user/stage3/case17_do_filp_open_deep_trace/openat_raw`
- Run timestamp: `2026-02-15T13:22:34`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 1
- do_filp_open.ret: 1
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 1
- Non-error pointer returns observed: 0

## Commands
```bash
make -C kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger_raw_openat
kernel/user/stage3/case17_do_filp_open_deep_trace/openat_raw
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger_raw_openat/trace_user_trigger_raw_openat.ko target_comm="openat_raw"
sudo rmmod trace_user_trigger_raw_openat
```

## Dmesg
`kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_raw_openat_dmesg.txt`
