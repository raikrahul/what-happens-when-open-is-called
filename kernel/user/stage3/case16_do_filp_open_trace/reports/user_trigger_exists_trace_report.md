# Trace Report: user_trigger_exists.c

- Userspace source: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists.c`
- Driver source: `kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_exists/trace_user_trigger_exists.c`
- Module: `trace_user_trigger_exists`
- Binary: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists`
- Run timestamp: `2026-02-15T23:32:13`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 10
- do_filp_open.ret: 10
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 4

## Commands
```bash
make -C kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_exists
kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_exists/trace_user_trigger_exists.ko target_comm="user_trigger_ex"
sudo rmmod trace_user_trigger_exists
```

## Dmesg
`kernel/user/stage3/case16_do_filp_open_trace/reports/user_trigger_exists_dmesg.txt`
