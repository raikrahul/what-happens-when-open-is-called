# Trace Report: user_create_deep.c

- Userspace source: `kernel/user/stage3/case8_creation_proof/user_create_deep.c`
- Driver source: `kernel/drivers/stage3/case8_creation_proof/trace_user_create_deep/trace_user_create_deep.c`
- Module: `trace_user_create_deep`
- Binary: `kernel/user/stage3/case8_creation_proof/user_create_deep.out`
- Run timestamp: `2026-02-15T13:22:47`
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
make -C kernel/drivers/stage3/case8_creation_proof/trace_user_create_deep
kernel/user/stage3/case8_creation_proof/user_create_deep.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case8_creation_proof/trace_user_create_deep/trace_user_create_deep.ko target_comm="user_create_dee"
sudo rmmod trace_user_create_deep
```

## Dmesg
`kernel/user/stage3/case8_creation_proof/reports/user_create_deep_dmesg.txt`
