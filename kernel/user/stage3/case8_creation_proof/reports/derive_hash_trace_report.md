# Trace Report: derive_hash.c

- Userspace source: `kernel/user/stage3/case8_creation_proof/derive_hash.c`
- Driver source: `kernel/drivers/stage3/case8_creation_proof/trace_derive_hash/trace_derive_hash.c`
- Module: `trace_derive_hash`
- Binary: `kernel/user/stage3/case8_creation_proof/derive_hash.out`
- Run timestamp: `2026-02-15T01:15:35`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 8
- do_filp_open.ret: 8
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 2

## Commands
```bash
make -C kernel/drivers/stage3/case8_creation_proof/trace_derive_hash
kernel/user/stage3/case8_creation_proof/derive_hash.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case8_creation_proof/trace_derive_hash/trace_derive_hash.ko target_comm="derive_hash.out"
sudo rmmod trace_derive_hash
```

## Dmesg
`kernel/user/stage3/case8_creation_proof/reports/derive_hash_dmesg.txt`
