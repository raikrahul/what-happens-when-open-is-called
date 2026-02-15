# Trace Report: user_create_long.c

- Userspace source: `kernel/user/stage3/case8_creation_proof/user_create_long.c`
- Driver source: `kernel/drivers/stage3/case8_creation_proof/trace_user_create_long/trace_user_create_long.c`
- Module: `trace_user_create_long`
- Binary: `kernel/user/stage3/case8_creation_proof/user_create_long.out`
- Run timestamp: `2026-02-15T13:08:29`
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
make -C kernel/drivers/stage3/case8_creation_proof/trace_user_create_long
kernel/user/stage3/case8_creation_proof/user_create_long.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case8_creation_proof/trace_user_create_long/trace_user_create_long.ko target_comm="user_create_lon"
sudo rmmod trace_user_create_long
```

## Dmesg
`kernel/user/stage3/case8_creation_proof/reports/user_create_long_dmesg.txt`
