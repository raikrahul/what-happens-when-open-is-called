# Trace Report: case5_mount_jump.c

- Userspace source: `kernel/user/stage3/case5_mount_jump/case5_mount_jump.c`
- Driver source: `kernel/drivers/stage3/case5_mount_jump/trace_case5_mount_jump/trace_case5_mount_jump.c`
- Module: `trace_case5_mount_jump`
- Binary: `kernel/user/stage3/case5_mount_jump/case5_mount_jump.out`
- Run timestamp: `2026-02-15T13:22:43`
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
make -C kernel/drivers/stage3/case5_mount_jump/trace_case5_mount_jump
kernel/user/stage3/case5_mount_jump/case5_mount_jump.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case5_mount_jump/trace_case5_mount_jump/trace_case5_mount_jump.ko target_comm="case5_mount_jum"
sudo rmmod trace_case5_mount_jump
```

## Dmesg
`kernel/user/stage3/case5_mount_jump/reports/case5_mount_jump_dmesg.txt`
