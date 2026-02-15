# Trace Report: vfs_trigger.c

- Userspace source: `kernel/user/stage3/case1/vfs_trigger.c`
- Driver source: `kernel/drivers/stage3/case1/trace_vfs_trigger/trace_vfs_trigger.c`
- Module: `trace_vfs_trigger`
- Binary: `kernel/user/stage3/case1/vfs_trigger.out`
- Run timestamp: `2026-02-15T13:08:02`
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
make -C kernel/drivers/stage3/case1/trace_vfs_trigger
kernel/user/stage3/case1/vfs_trigger.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case1/trace_vfs_trigger/trace_vfs_trigger.ko target_comm="vfs_trigger.out"
sudo rmmod trace_vfs_trigger
```

## Dmesg
`kernel/user/stage3/case1/reports/vfs_trigger_dmesg.txt`
