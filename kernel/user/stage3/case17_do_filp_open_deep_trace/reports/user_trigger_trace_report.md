# Trace Report: user_trigger.c

- Userspace source: `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger.c`
- Driver source: `kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger/trace_user_trigger.c`
- Dmesg capture: `kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_dmesg_targeted.txt`
- Status: baseline_done

## Objective
Capture `do_filp_open` entry/return and `__d_alloc` entry/return for missing-file open.

## Trigger
```bash
sudo insmod kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger/trace_user_trigger.ko target_comm="user_trigger.ou"
./kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger.out
sudo dmesg | tail -n 400 > kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_dmesg_targeted.txt
sudo rmmod trace_user_trigger
```

## Key Evidence
1. `do_filp_open.entry` for `comm=user_trigger.ou`
2. `__d_alloc.entry` and `__d_alloc.ret` observed in same run
3. final `do_filp_open.ret=fffffffffffffffe` observed in same run (error pointer -ENOENT)

## Notes
- `target_comm` must match Linux task-comm truncation (15 chars). For `user_trigger.out`, value is `user_trigger.ou`.
- Empty `target_comm` captures unrelated `sudo`, `dmesg`, and `git` opens; use process filter.
