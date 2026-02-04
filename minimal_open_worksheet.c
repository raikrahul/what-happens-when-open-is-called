// Line 1: #include <fcntl.h> → header at 0x100000-0x1000FF: 256 bytes → contains O_RDWR=0x00000002, open syscall=2
// Line 2: #include <unistd.h> → header at 0x100100-0x1001FF: 256 bytes → contains read(2), write(2), close(3) definitions
// Line 3: int main() → function entry at 0x100200 → stack frame: rbp-0x8=fd1, rbp-0x4=fd2 → 0x7ffd1234: main() start
// Line 4:   int fd = open("somefile", O_RDWR); → syscall 2 → rdi=filename@0x2000, rsi=2, rax=2 → kernel trap
// Line 5:   char* filename1 = "somefile"; → string at 0x2000-0x2008: "somefile\0" = 9 bytes → pointer=0x2000 stored rbp-0x10
// Line 6:   int mode1 = O_RDWR; → constant 0x00000002 → read+write permissions → stored rbp-0x14, copied to rsi register
// Line 7:   long syscall_result1; → rbp-0x18: rax storage → will become fd=3 on success → error codes on failure
// Line 8:   // Pre-call state: rdi=0x2000("somefile"), rsi=2, rax=2 → MSR_LSTAR=0xffffffff81000000 entry point
// Line 9:   asm volatile ("syscall" : "=a"(syscall_result1) : "D"(filename1), "S"(mode1), "a"(2)); → ring3→ring0 transition
// Line 10:   fd = syscall_result1; → rax→rbp-0x8: fd=3 if success → rax=-2→errno=2→fd=-1 if file not found
// Line 11:   
// Line 12:   int fd2 = open("otherfile", O_RDWR); → same syscall 2 → different filename: rdi=0x2010, rsi=2, rax=2
// Line 13:   char* filename2 = "otherfile"; → string at 0x2010-0x2019: "otherfile\0" = 10 bytes → pointer=0x2010 stored rbp-0x20
// Line 14:   int mode2 = O_RDWR; → same constant 0x00000002 → stored rbp-0x24, copied to rsi register
// Line 15:   long syscall_result2; → rbp-0x28: second rax storage → will become fd=4 on success → error codes on failure
// Line 16:   // Pre-call state: rdi=0x2010("otherfile"), rsi=2, rax=2 → same entry point, different arguments
// Line 17:   asm volatile ("syscall" : "=a"(syscall_result2) : "D"(filename2), "S"(mode2), "a"(2)); → ring3→ring0 transition
// Line 18:   fd2 = syscall_result2; → rax→rbp-0x4: fd=4 if success → rax=-2→errno=2→fd=-1 if file not found
// Line 19: } → return value: rax=0 → epilogue: leave, ret → stack unwind from rbp-0x28 to initial state

// Line 20: // Memory layout at syscall1:
// Line 21: // Stack: 0x7ffd1230→rbp, 0x7ffd1228→fd2(uninitialized), 0x7ffd1224→fd1(uninitialized)
// Line 22: // Code: 0x100004: call open@plt → 0x1050 → jmp *0x2f76(%rip) → 0x3fd0→dynamic linker resolver
// Line 23: // Data: 0x2000→"somefile\0", 0x2010→"otherfile\0", O_RDWR=2 at 0x100800
// Line 24: // Registers pre-syscall: rdi=0x2000, rsi=2, rax=2 → entry_SYSCALL_64_fastpath

// Line 25: // Memory layout at syscall2:
// Line 26: // Stack: 0x7ffd1228→fd1=3, 0x7ffd1224→fd2(uninitialized)
// Line 27: // GOT[3] at 0x3fd0 now patched: 0x7f8b12345678 → actual open() address in libc.so.6
// Line 28: // Registers pre-syscall: rdi=0x2010, rsi=2, rax=2 → same entry, different filename argument
// Line 29: // File table: fd=3→somefile inode=123456, fd=4→otherfile inode=123457 (both after success)

// Line 30: // Error case analysis:
// Line 31: // if "somefile" not exist → rax=-2 (ENOENT) → errno=2 → fd=-1 → strace shows "No such file or directory"
// Line 32: // if permissions denied → rax=-13 (EACCES) → errno=13 → fd=-1 → check: ls -la somefile shows permissions
// Line 33: // if fd table full → rax=-24 (EMFILE) → errno=24 → fd=-1 → check: ulimit -n shows 1024 limit
// Line 34: // if signal interrupt → rax=-4 (EINTR) → errno=4 → fd=-1 → restart syscall automatically in glibc wrapper

// Line 35: // Success case analysis:
// Line 36: // path walk: "/somefile" → resolve → inode=123456 → allocate file descriptor=3
// Line 37: // fd allocation: find first free slot in current->files[fd] → check limit RLIMIT_NOFILE=1024 → slot[3] empty → use it
// Line 38: // struct file allocation: slab cache get → kmalloc(256) → fill f_pos=0, f_op=open_inode_operations
// Line 39: // dentry cache: lookup in dcache → miss → read directory block from disk → add to cache → hit next time
// Line 40: // return path: rax=3 → restore user registers → return to user space at 0x100009

// Line 41: // Performance analysis:
// Line 42: // open() = ~1000-5000 cycles = 1-5 μs → dominated by disk I/O for file existence check
// Line 43: // syscall overhead = ~200 cycles → switch cr3, kernel stack save/restore, tlb flush, pt_regs copy
// Line 44: // dentry hit = ~50 cycles → fast open of recently accessed file → no disk I/O needed
// Line 45: // slab allocation = ~10 cycles → fast memory from pre-allocated kmem_cache → memory already mapped
// Line 46: // TLB miss = ~100 cycles → page walk required → 4-level page table traversal → PGD→PUD→PMD→PTE

// Line 47: // Complete call graph:
// Line 48: // main()→do_sys_openat()→do_filp_open()→path_openat()→do_last()→vfs_open()→may_open()→inode_permission()
// Line 49: // Each level: permission check, name lookup, inode lock → kernel spinlocks, rcu read locks, refcount inc
// Line 50: // Final result: fd=3 for "somefile", fd=4 for "otherfile" → success path → both files in /proc/self/fd/

// Failure predictions:
// ENOENT: file not exist → create file with touch → resolve -2 error code
// EACCES: permission denied → chmod 666 file → resolve -13 error code  
// EMFILE: fd table full → close unused fds → resolve -24 error code
// EINTR: signal interrupt → auto-retry syscall → resolve -4 error code