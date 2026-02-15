# Trace Report: user_hash_collision.c

- Userspace source: `kernel/user/stage3/case8_creation_proof/user_hash_collision.c`
- Driver source: `kernel/drivers/stage3/case8_creation_proof/trace_user_hash_collision/trace_user_hash_collision.c`
- Module: `trace_user_hash_collision`
- Binary: `kernel/user/stage3/case8_creation_proof/user_hash_collision`
- Run timestamp: `2026-02-15T23:32:36`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 11
- do_filp_open.ret: 11
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 5

## Commands
```bash
make -C kernel/drivers/stage3/case8_creation_proof/trace_user_hash_collision
kernel/user/stage3/case8_creation_proof/user_hash_collision
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case8_creation_proof/trace_user_hash_collision/trace_user_hash_collision.ko target_comm="user_hash_colli"
sudo rmmod trace_user_hash_collision
```

## Dmesg
`kernel/user/stage3/case8_creation_proof/reports/user_hash_collision_dmesg.txt`
