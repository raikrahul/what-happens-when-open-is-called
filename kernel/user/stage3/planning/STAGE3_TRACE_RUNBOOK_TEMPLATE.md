# Stage 3 Trace Runbook Template

## Pair
- Userspace source: `<path>`
- Driver source: `<path>`
- Target comm: `<binary_name>`

## Build
```bash
make <userspace_output_target>
make <driver_ko_target>
```

## Run
```bash
sudo insmod <driver>.ko target_comm="<target_comm>"
./<userspace_binary>
sudo dmesg | tail -n 400 > <dmesg_capture_file>
sudo rmmod <driver_module_name>
```

## Evidence Checklist
1. do_filp_open entry hit
2. do_filp_open return hit
3. __d_alloc entry/return hit (for miss paths)
4. error path value captured (e.g., -ENOENT)
5. dentry pointer continuity captured

## Report Sections
1. Objective
2. Probe list
3. Trigger command
4. Raw kernel log excerpt
5. Parsed timeline (step-by-step)
6. Result
7. Next probe adjustment
