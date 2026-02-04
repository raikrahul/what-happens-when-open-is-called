# Troubleshooting Guide

This page covers common issues and solutions when working with the "What Happens When Open Is Called" project.

## 🔨 Build Issues

### Compiler Errors

#### Problem: "implicit function declaration"
```
error: implicit declaration of function 'getrlimit'
```

**Solution**: Missing headers. Add to your C file:
```c
#include <sys/time.h>
#include <sys/resource.h>
```

#### Problem: "undefined reference to SYS_open"
```
error: undefined reference to `SYS_open'
```

**Solution**: Missing syscall header:
```c
#include <sys/syscall.h>
```

#### Problem: Permission denied creating files
```
fatal error: output/file.h: Permission denied
```

**Solution**: Check directory permissions:
```bash
ls -la /path/to/directory
sudo chown $USER:$USER /path/to/directory
```

### Linking Errors

#### Problem: "undefined reference to" during linking
```
undefined reference to `some_function'
```

**Solution**: Check if all required libraries are linked:
```bash
# For math functions
gcc program.c -lm

# For threading
gcc program.c -lpthread
```

## 🚀 Runtime Issues

### Permission Denied Errors

#### Problem: EACCES when accessing system files
```
ERROR DEMO: Permission denied
errno: 13 (Permission denied)
```

**Expected behavior**: This is normal when accessing restricted files like `/etc/shadow`. The demo is working correctly.

#### Problem: Cannot create demo files
```
open("/tmp/demo_file.txt"): Permission denied
```

**Solution**: Check /tmp permissions:
```bash
ls -la /tmp
# If /tmp is mounted noexec, create files elsewhere:
mkdir -p ~/tmp
export TMPDIR=~/tmp
```

### File Descriptor Issues

#### Problem: "Too many open files" during normal operation
```
EMFILE: Too many open files
```

**Solution**: Check and increase limits:
```bash
# Check current limits
ulimit -n

# Increase limit
ulimit -n 4096

# For permanent change, add to ~/.bashrc:
echo "ulimit -n 4096" >> ~/.bashrc
```

#### Problem: File descriptor leak detection
```
File descriptor leak detected in program
```

**Solution**: Check program for unclosed file descriptors:
```bash
# Monitor file descriptors during execution
watch "ls -la /proc/$$/fd"

# Use lsof to track open files
lsof -p $$
```

## 🔍 Debugging Tools

### Using strace

#### Basic strace usage
```bash
# Trace all syscalls
strace ./program

# Trace only open-related syscalls
strace -e trace=openat,open ./program

# Save trace to file
strace -o trace.log ./program
```

#### Interpreting strace output
```
openat(AT_FDCWD, "/etc/passwd", O_RDONLY) = 3
```
- `openat`: System call name
- `AT_FDCWD`: Current working directory
- `"/etc/passwd"`: File being opened
- `O_RDONLY`: Open flags
- `= 3`: Return value (file descriptor)

### Using gdb

#### Basic gdb usage for register inspection
```bash
# Compile with debug symbols
gcc -g -o program program.c

# Start debugging
gdb ./program

# Set breakpoint at open
(gdb) break open

# Run program
(gdb) run

# Examine registers before syscall
(gdb) info registers

# Step into syscall
(gdb) stepi
```

#### Examining memory
```bash
# Examine string in memory
(gdb) x/s $rdi  # RDI contains filename pointer

# Examine bytes
(gdb) x/10bx $rdi  # Show 10 bytes in hex
```

## 🐛 Common Program Issues

### register_dump fails

#### Problem: "SUCCESS: Syscall returned FD 3" but program exits immediately

**Solution**: This is the expected behavior. The program demonstrates the successful syscall and exits.

#### Problem: No output on some systems

**Solution**: Check if stdout is being redirected:
```bash
./proofs/register_dump | cat
# or
strace -e write ./proofs/register_dump
```

### path_walk_simulator issues

#### Problem: "cannot find" for valid paths

**Solution**: Check if the path actually exists:
```bash
ls -la /etc/passwd
stat /etc/passwd

# Try with absolute path
./proofs/path_walk_simulator /etc/passwd
```

#### Problem: Permission denied on system directories

**Solution**: Run with appropriate permissions or use accessible paths:
```bash
# Use your home directory
./proofs/path_walk_simulator $HOME/.bashrc

# Or create a test file
echo "test" > /tmp/test_file
./proofs/path_walk_simulator /tmp/test_file
```

### Error demonstration issues

#### Problem: EMFILE demo doesn't reach file descriptor limit

**Solution**: The limit might be too high. Check with:
```bash
ulimit -n

# If limit is very high (>10000), the demo might take too long
# You can artificially lower it:
ulimit -n 100
./error_demo_emfile
```

#### Problem: EACCES demo succeeds when it should fail

**Solution**: This means you have elevated permissions. Try:
```bash
# Drop privileges if running as root
sudo -u nobody ./error_demo_eacces

# Or check file permissions:
ls -la /etc/shadow
```

## 🔧 System-Specific Issues

### Debian/Ubuntu

#### Problem: Missing development packages
```
fatal error: sys/syscall.h: No such file or directory
```

**Solution**: Install build essentials:
```bash
sudo apt-get update
sudo apt-get install build-essential linux-headers-$(uname -r)
```

### CentOS/RHEL/Fedora

#### Problem: Different syscall numbers
```
SYS_open not defined
```

**Solution**: Use the correct macro:
```c
// Instead of SYS_open, use:
__NR_open
// Or better, use the syscall() wrapper
syscall(__NR_open, filename, flags, mode)
```

### WSL (Windows Subsystem for Linux)

#### Problem: Some syscalls behave differently

**Solution**: WSL has some limitations:
```bash
# Check WSL version
wsl.exe --list --verbose

# Some kernel-specific demos may not work
# Focus on user-space demonstrations
```

## 📋 Verification Checklist

When troubleshooting, use this checklist:

### Build Verification
- [ ] `make clean` completes without errors
- [ ] `make all` builds all programs
- [ ] No compiler warnings about missing functions
- [ ] All executable files are created

### Runtime Verification
- [ ] Programs don't crash with segmentation fault
- [ ] strace shows expected syscalls
- [ ] File descriptor counts are reasonable
- [ ] Error demos produce expected errors

### System Verification
- [ ] Running as non-root user (unless required)
- [ ] /tmp directory is writable
- [ ] File descriptor limits are reasonable (>100)
- [ ] Required system files exist (/etc/passwd, etc.)

---

If you encounter issues not covered here, please:
1. Check the [GitHub Issues](https://github.com/raikrahul/what-happens-when-open-is-called/issues)
2. Run the integration test: `./integration_test.sh`
3. Create a detailed bug report with system information