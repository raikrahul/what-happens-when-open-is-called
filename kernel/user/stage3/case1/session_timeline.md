# Session Timeline: Path Resolution & Branch Proof
**Date**: 2026-02-12
**Scope**: Stage 3 - Tracing `open()` -> `path_init()` logic and proving branch execution.

---

### **[15:00 - 15:30] Foundation & Object Identity**
- **Task**: Analyze `init_file` and `alloc_empty_file` to understand the lifecycle of `struct file`.
- **Finding**: Confirmed that the file descriptor (FD) is reserved *before* the file object is fully initialized, but linked *after* `path_openat` returns.
- **Artifacts**: 
  - `trace_pseudo_debugger_alloc_complete.txt`
  - `trace_pseudo_debugger_init_file.txt`
- **Proof of Identity**: Proved that the kernel distinguishes directories by dentry pointer address, not by string name.
- **Action**: Created `demo_dup_names.c` (creating two dirs named "common") and verified distinct pointers in kernel logs.
- **Artifacts**: `demo_dup_names.c`, `proof_dup_names.txt`.

### **[15:51] Deep Dive into `path_init` Branching**
- **Task**: Identify which code path `path_init` takes during a relative `open()` call with `AT_FDCWD`.
- **Logic**: For `open("usr/lib/...")`, the path is not absolute (`/`), and `dfd` is `-100`. This maps to the `AT_FDCWD` branch.
- **Artifact**: `trace_pseudo_debugger_path_init_complete.txt`.

### **[15:55 - 16:05] The Search for Physical Proof**
- **Challenge**: The user requested a "non-magic" proof using instruction traces (offsets) rather than deductive reasoning.
- **Obstacle**: `perf probe` and `gdb` on live memory were hindered by missing debug symbols in the running kernel.
- **Resolution**:
  - Installed `libdw-dev`, `libdwarf-dev`, and `libelf-dev`.
  - Compiled `fs/namei.o` from source to generate an object file with full DWARF info.
  - Used `objdump` to find that the `AT_FDCWD` branch starts at offset **+314** (Instruction: `mov %gs:0x0...`).

### **[16:06 - 16:10] The Ultimate Execution Proof**
- **Action**: Created a specialized kernel module `trace_offset_proof.c` targeting exactly `path_init + 314`.
- **Verification (addr2line)**: Used `addr2line` to map offset `0x454a` (+314) back to code.
- **Result**: `addr2line` confirmed this offset is `fs/namei.c:2578`.
- **Execution**: Ran `demo_dup_names`. The probe fired!
- **Log**: `[17288.590763] [PROOF] path_init+314 EXECUTION DETECTED!`
- **Artifacts**: `trace_offset_proof.c`, `proof_addr2line.txt`.

### **[16:11 - 16:13] Synthesis & Non-Circularity**
- **Task**: Verify that the logic is not circular.
- **Conclusion**: The proof is linear. Static analysis defined the map (Offset +314 = Inside Branch); runtime observation proved the arrival (CPU at +314).
- **Artifact**: `proof_non_circular.txt`.

---
**Status at 16:13**: All proofs committed. `path_init` branch execution verified at the instruction level.
