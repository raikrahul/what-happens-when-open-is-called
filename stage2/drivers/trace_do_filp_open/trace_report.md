# Trace Report: do_filp_open

## 1. Axiomatic Verification of Function Address
**Goal**: Verify we are tracing the correct function in kernel memory.

- **Command**: `grep do_filp_open /proc/kallsyms`
- **Output**: `ffffffff959de3a0 T do_filp_open`
- **Axiom**: The symbol address `0xffffffff959de3a0` corresponds to the function entry point in the running kernel image.

## 2. Argument Verification
**Goal**: Verify arguments passed to `do_filp_open` adhere to x86_64 calling conventions and point to valid kernel memory.

- **Register Mapping**:
  - `RDI` (Arg 1): `dfd`
  - `RSI` (Arg 2): `struct filename *pathname`
  - `RDX` (Arg 3): `struct open_flags *op`

- **Trace Data (dmesg)**:
  ```
  [ 5372.791719] pathname is a kernel pointer: ffff8a0240fe1000
  [ 5372.791724] op is a kernel pointer: ffffcb3942f67e14
  [ 5372.791726] pathname->name: somefile
  [ 5372.791727] op->open_flag: 0x8002
  ```
- **Derivation**:
  1. `pathname` address `0xffff8a0240fe1000` > `0xffff800000000000` -> **Valid Kernel Pointer**.
  2. `op` address `0xffffcb3942f67e14` > `0xffff800000000000` -> **Valid Kernel Pointer** (Likely stack/vmalloc).
  3. `pathname->name` dereference yields "somefile", matching the input in `minimal_open.c`.
  4. `op->open_flag` is `0x8002`.
     - `O_RDWR` = 0x2
     - `O_LARGEFILE` = 0x8000 (Implicitly added by glibc open/kernel defaults on 64-bit)
     - `0x8000 | 0x2 = 0x8002` -> **Verified**.

## 3. struct file Layout & The Case of the Missing f_count
**Goal**: Verify `struct file` fields and reference counting mechanism.

- **Observation**: `trace_do_filp_open.c` failed to compile with `f_count` access.
- **Investigation**: strict inspection of `struct file` in `vmlinux-6.14.0-37-generic`.
- **GDB Proof**:
  ```
  type = struct file {
      file_ref_t f_ref;  <-- CHANGED from atomic_long_t f_count
      spinlock_t f_lock;
      fmode_t f_mode;
      ...
  }
  ```
- **Axiom**: In Linux 6.14, `f_count` has been replaced by `f_ref`. Accessing the count requires the `file_count(f)` macro.
- **Verification**:
  - Code updated to use `file_count(ret_file)`.
  - Trace Output: `ret_file->f_count: 1`
  - Derivation: A newly opened file (or library) starts with a refcount of 1.

## 4. Return Value Analysis
**Goal**: Verify return values for success and failure.

- **Case 1: libc.so.6 (Success)**
  - `ret_file`: `ffff8a0410a78d80` (Valid Pointer)
  - `IS_ERR`: False.
  - `d_name.name` pointer: Verified Kernel Address (`0xffff...`)
  - `d_name.name`: "libc.so.6"

- **Case 2: "somefile" (Failure)**
  - `ret_file`: `-2`
  - `IS_ERR`: True.
  - `PTR_ERR`: -2 corresponds to `-ENOENT` (No such file or directory).
  - `pathname->name` pointer: Verified Kernel Address (`0xffff...`)
  - Derivation: `include/uapi/asm-generic/errno-base.h`: `#define ENOENT 2`.

## 5. Conclusion
We have axiomatically traced `do_filp_open` from arguments to return value, identifying and adapting to a kernel API change (`f_ref`) using standard debugging tools (`gdb`, `vmlinux`, `kallsyms`). The trace driver now correctly extracts and validates all targeted data.
