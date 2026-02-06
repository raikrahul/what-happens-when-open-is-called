# Home

Welcome to the **What Happens When Open Is Called** wiki!

This repository provides a comprehensive, axiomatic approach to understanding what happens when you call the `open()` system call in Linux. The project combines theoretical understanding with practical demonstrations.

## 🎯 Learning Objectives

After completing this curriculum, you will understand:
- How user-space code transitions to kernel-space
- The complete path from `open()` call to file descriptor
- Memory management and allocation in the kernel
- Error handling and return mechanisms
- Permission checking and security boundaries

## 📚 Curriculum Structure

### Core Components

1. **Proof Programs** (`proofs/`)
   - Executable demonstrations of core concepts
   - Minimal, focused examples
   - Each program proves one specific axiom

2. **Axiomatic Lessons** (`axiomatic_lessons/`)
   - Stage-by-stage learning progression
   - No prior knowledge assumed
   - Each concept built from first principles

3. **Error Demonstrations** (`error_demos/`)
   - Systematic exploration of failure cases
   - Understanding errno codes
   - Real-world error handling

## 🚀 Quick Start

### Build Everything
```bash
make all
```

### Run Integration Tests
```bash
./integration_test.sh
```

### Run Individual Examples
```bash
# Basic proof programs
./proofs/register_dump
./proofs/path_walk_simulator /etc/passwd

# Axiomatic lessons
./axiomatic_lessons/00_failure_predictions/lesson_demo
./axiomatic_lessons/01_the_syscall_interface/lesson_demo

# Error demonstrations
./error_demo_enoent
./error_demo_eacces
./error_demo_emfile
```

## 📖 Learning Path

### Stage 0: Failure Predictions
**Goal**: You cannot fix what you cannot predict.
- Learn common failure modes
- Understand errno codes
- Practice defensive programming

### Stage 1: The User Call  
**Goal**: Transform "file.txt" (String) into Registers (Hardware).
- Understand ABI conventions
- Learn register usage
- See the syscall interface

### Stage 2: The Kernel Entry
**Goal**: Cross the boundary from Ring 3 (User) to Ring 0 (Kernel).
- Understand CPU rings and privilege levels
- Learn about the syscall instruction
- See the transition mechanism

### Stage 3: The Path Walk
**Goal**: Find the Inode Number on Disk.
- Understand directory structure
- Learn about path resolution
- See caching mechanisms

### Stage 4: The Allocation
**Goal**: Create the `struct file` in RAM.
- Understand kernel memory management
- Learn about file descriptor tables
- See allocation mechanisms

### Stage 5: The Return
**Goal**: Hand the Integer back to User.
- Understand return value handling
- Learn about error propagation
- See the user-space return

## 🔧 Development

### Building Components
- `make proofs` - Build proof programs only
- `make axiomatic` - Build lesson demos only  
- `make errors` - Build error demonstrations only
- `make clean` - Clean all built files

### Testing
- `make test` - Quick test of all programs
- `./integration_test.sh` - Comprehensive integration testing

### Dependencies
- GCC compiler
- Basic Linux utilities (strace, gdb recommended)
- Kernel headers (for some demonstrations)

## 📝 Contributing

This project follows strict axiomatic principles:
1. **NO MAGIC**: Every concept must be defined before use
2. **NO INFERENCE**: Do not assume prior knowledge
3. **NO FLUFF**: Just facts and demonstrations
4. **DERIVATION**: Each step follows from previous steps

When contributing:
- Keep examples minimal and focused
- Explain every concept from first principles
- Test all code with the integration script
- Follow the existing code style

## 📄 License

MIT License - see LICENSE file for details.

## 🔗 Related Resources

- [Linux System Call Table](https://chromium.googlesource.com/chromiumos/docs/+/HEAD/constants/syscalls.md)
- [Linux Kernel Documentation](https://www.kernel.org/doc/html/latest/)
- [Man Pages: open(2)](https://man7.org/linux/man-pages/man2/open.2.html)

---

**Remember**: The goal is understanding from first principles, not memorization. Every concept should be derivable from basic axioms.