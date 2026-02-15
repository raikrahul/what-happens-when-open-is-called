# Trace Report: user_trigger_missing.c

- Userspace source: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_missing.c`
- Driver source: `kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_missing/trace_user_trigger_missing.c`
- Module: `trace_user_trigger_missing`
- Binary: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_missing`
- Run timestamp: `2026-02-15T13:08:12`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 9
- do_filp_open.ret: 9
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 7
- Non-error pointer returns observed: 2

## Commands
```bash
make -C kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_missing
kernel/user/stage3/case16_do_filp_open_trace/user_trigger_missing
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_missing/trace_user_trigger_missing.ko target_comm="user_trigger_mi"
sudo rmmod trace_user_trigger_missing
```

## Dmesg
`kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_missing_dmesg.txt`
