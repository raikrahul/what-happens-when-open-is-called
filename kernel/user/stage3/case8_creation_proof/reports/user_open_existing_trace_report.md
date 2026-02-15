# Trace Report: user_open_existing.c

- Userspace source: `kernel/user/stage3/case8_creation_proof/user_open_existing.c`
- Driver source: `kernel/drivers/stage3/case8_creation_proof/trace_user_open_existing/trace_user_open_existing.c`
- Module: `trace_user_open_existing`
- Binary: `kernel/user/stage3/case8_creation_proof/user_open_existing`
- Run timestamp: `2026-02-15T23:32:37`
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
make -C kernel/drivers/stage3/case8_creation_proof/trace_user_open_existing
kernel/user/stage3/case8_creation_proof/user_open_existing
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case8_creation_proof/trace_user_open_existing/trace_user_open_existing.ko target_comm="user_open_exist"
sudo rmmod trace_user_open_existing
```

## Dmesg
`kernel/user/stage3/case8_creation_proof/reports/user_open_existing_dmesg.txt`
