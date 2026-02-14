# KERNEL CRASH CAPTURE GUIDE
## Stage 3 VFS Tracing Project

### Why Kernel Crashes Are Hard to Capture

When a kernel module crashes, the system may:
1. **Immediate freeze** - No logs written to disk
2. **Kernel panic** - Pink/black screen, automatic reboot
3. **Oops** - Error message but system continues
4. **Silent crash** - No visible error, just stops responding

The problem: **dmesg and /var/log are in RAM and lost on reboot!**

---

## METHOD 1: Netconsole (Remote Logging) - BEST

Send kernel logs to another computer via network BEFORE crash.

### Setup on TARGET (crashing machine):

```bash
# Load netconsole module
sudo modprobe netconsole netconsole=@/eth0,192.168.1.100@/00:11:22:33:44:55

# Breakdown:
# @/eth0 = listen on eth0
# 192.168.1.100 = remote logging server IP
# 00:11:22:33:44:55 = remote server MAC address
```

### Setup on RECEIVER (logging machine):

```bash
# Install netcat
sudo apt-get install netcat

# Listen for kernel messages
nc -u -l 6666

# Or save to file
nc -u -l 6666 > kernel_crash_$(date +%Y%m%d_%H%M%S).log
```

### Advantages:
- Logs sent in real-time over network
- Survives target crash/reboot
- No disk I/O on target (won't crash due to disk issues)

---

## METHOD 2: Serial Console (Most Reliable)

If you have physical access or VM with serial port.

### Enable serial console on target:

```bash
# Edit grub
sudo nano /etc/default/grub

# Add to GRUB_CMDLINE_LINUX_DEFAULT:
console=tty0 console=ttyS0,115200n8

# Update grub
sudo update-grub

# Reboot
sudo reboot
```

### Connect from another machine:

```bash
# Using minicom
sudo minicom -D /dev/ttyUSB0 -b 115200

# Using screen
sudo screen /dev/ttyUSB0 115200

# Using picocom
sudo picocom -b 115200 /dev/ttyUSB0
```

### For VMs (QEMU/KVM):

```bash
# Add to QEMU command line
-serial stdio

# Or log to file
-serial file:serial.log
```

---

## METHOD 3: kdump/kexec (Post-Crash Analysis)

Capture crash dump after kernel panics.

### Install kdump:

```bash
sudo apt-get install linux-crashdump kdump-tools

# Edit config
sudo nano /etc/default/kdump-tools

# Set:
USE_KDUMP=1
```

### After crash, find dump in:

```bash
/var/crash/

# Analyze with crash utility
sudo crash /usr/lib/debug/boot/vmlinux-$(uname -r) /var/crash/xxxx/dump.xxxx
```

---

## METHOD 4: pstore (Persistent Storage)

Save crash logs to EFI variable storage or reserved RAM.

```bash
# Check if available
ls /sys/fs/pstore/

# Mount pstore
sudo mount -t pstore pstore /sys/fs/pstore/

# After crash, logs appear here automatically
ls /sys/fs/pstore/

# Read crash log
cat /sys/fs/pstore/dmesg-efi-xxxx

# Clear old logs
cd /sys/fs/pstore/
sudo rm *
```

### Requirements:
- UEFI firmware (for EFI pstore)
- Or reserved RAM region in device tree

---

## METHOD 5: Continuous dmesg Logging

Save dmesg to disk continuously during testing.

```bash
# Terminal 1: Start logging BEFORE loading module
sudo dmesg -w > kernel_trace_$(date +%Y%m%d_%H%M%S).log &

# Terminal 2: Load and test your module
sudo insmod driver.ko
./user_program

# If crash occurs, Terminal 1 log has everything up to crash
```

### With automatic sync:

```bash
# More aggressive sync (may slow system)
sudo dmesg -w | while read line; do
    echo "$line" >> /var/log/kernel_live.log
    sync
 done &
```

---

## METHOD 6: Early printk + Video Record

For when all else fails:

```bash
# Enable early printk
sudo nano /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="earlyprintk=vga,keep loglevel=8"
sudo update-grub

# Record screen with phone/camera during test
# Or use video capture card
```

---

## QUICK TESTING WORKFLOW (Recommended)

```bash
# 1. Open 3 terminals

# TERMINAL 1: Start netconsole receiver
nc -u -l 6666 | tee kernel_crash_$(date +%s).log

# TERMINAL 2: Continuous dmesg log
sudo dmesg -C  # Clear first
sudo dmesg -w > /tmp/dmesg_backup.log &

# TERMINAL 3: Run test
sudo insmod driver.ko
./user_program
sudo rmmod driver

# 4. Check both logs if crash occurs
```

---

## COMMON CRASH SIGNS TO WATCH FOR

### Kernel Panic:
```
Kernel panic - not syncing: VFS: Unable to mount root fs
```

### Oops:
```
BUG: unable to handle page fault for address: 0000000000000000
```

### Null Pointer Dereference:
```
NULL pointer dereference at: 0000000000000000
```

### Sleeping in Atomic Context:
```
BUG: scheduling while atomic: insmod/0x00000001/1234
```

### Stack Overflow:
```
stack overflow: 0000 [#1] PREEMPT SMP
```

---

## YOUR SPECIFIC CRASH: copy_from_user in kprobe

**What happened:**
```c
// BAD - causes panic:
static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs) {
    copy_from_user(buf, user_ptr, size);  // MAY SLEEP!
    return 0;
}
```

**Why:**
- kprobes run in **atomic context** (like interrupt handler)
- `copy_from_user()` can trigger page fault and sleep
- Sleeping in atomic context = instant panic

**Fixed version:**
```c
// GOOD - no sleep:
static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs) {
    // Access kernel memory only (already validated by kernel)
    const char *kernel_ptr = *(const char **)regs->si;
    if (kernel_ptr && !IS_ERR(kernel_ptr)) {
        // Safe to use - already in kernel space
    }
    return 0;
}
```

---

## TROUBLESHOOTING

### Netconsole not working:
```bash
# Check network interface
ip link show

# Get MAC address of receiver
arp -a 192.168.1.100

# Check firewall
sudo iptables -L | grep 6666
```

### Serial console not showing:
```bash
# Check serial port exists
ls /dev/ttyS* /dev/ttyUSB*

# Check permissions
sudo usermod -a -G dialout $USER

# Re-login required
```

### kdump not capturing:
```bash
# Check kdump is loaded
sudo systemctl status kdump-tools

# Check reserved memory
cat /proc/cmdline | grep crashkernel
```

---

## SUMMARY: CHOOSE YOUR METHOD

| Method | Complexity | Reliability | Best For |
|--------|-----------|-------------|----------|
| Netconsole | Low | High | VMs, networked systems |
| Serial | Low | Very High | Physical machines |
| kdump | Medium | Very High | Post-mortem analysis |
| pstore | Low | Medium | EFI systems |
| dmesg -w | Very Low | Low | Quick tests |

**For your VFS tracing project, use NETCONSOLE + dmesg -w combo!**

---

Created: $(date)
Project: Stage 3 VFS Tracing
Purpose: Capture kernel crashes during module testing
