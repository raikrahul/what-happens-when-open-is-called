# Trace Report: user_salt_avalanche.c

- Userspace source: `kernel/user/stage3/case13_salt_avalanche/user_salt_avalanche.c`
- Driver source: `kernel/drivers/stage3/case13_salt_avalanche/trace_user_salt_avalanche/trace_user_salt_avalanche.c`
- Module: `trace_user_salt_avalanche`
- Binary: `kernel/user/stage3/case13_salt_avalanche/user_salt_avalanche.out`
- Run timestamp: `2026-02-15T13:49:06`
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
make -C kernel/drivers/stage3/case13_salt_avalanche/trace_user_salt_avalanche
kernel/user/stage3/case13_salt_avalanche/user_salt_avalanche.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case13_salt_avalanche/trace_user_salt_avalanche/trace_user_salt_avalanche.ko target_comm="user_salt_avala"
sudo rmmod trace_user_salt_avalanche
```

## Dmesg
`kernel/user/stage3/case13_salt_avalanche/reports/user_salt_avalanche_dmesg.txt`
