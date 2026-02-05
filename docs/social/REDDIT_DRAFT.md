**Title**: What Happens When open() is Called: Stage 2b - Tracing do_filp_open() Return Value (Axiomatic Kernel Tracing)

**Body**:

I am writing an axiomatic, step-by-step deconstruction of the Linux `open()` system call.

**Current Stage (2b)**: Tracing the return value of `do_filp_open()` in Kernel 6.14.

**The Goal**:
Verify that `do_filp_open` returns a valid `struct file *` and inspecting its reference count and internal fields without assumptions.

**The Axioms (Derived from Source)**:

1.  **Symbol Address**: `do_filp_open` is at `0xffffffff959de3a0` (via `kallsyms`).
2.  **Kernel Memory Layout**: Valid kernel pointers must be `> 0xffff800000000000`.
3.  **API Change (Kernel 6.14)**:
    -   **Observation**: Compilation of standard `f_count` access failed.
    -   **Reality**: `struct file` in 6.14 replaced `atomic_long_t f_count` with `file_ref_t f_ref`.
    -   **Proof**: GDB dump of `vmlinux` `ptype struct file`.
    -   **Fix**: Usage of `file_count()` macro is mandatory.

**The Trace Results (dmesg)**:

1.  **Success Case (`libc.so.6`)**:
    -   `ret_file`: `ffff8a0410a78d80` (Valid Pointer)
    -   `f_count`: 1 (Freshly opened)
    -   `d_name.name`: "libc.so.6"

2.  **Failure Case (ENOENT)**:
    -   `ret_file`: `-2` (`0xfffffffffffffffe`)
    -   `IS_ERR`: True
    -   `PTR_ERR`: -2 maps to `ENOENT` defined in `include/uapi/asm-generic/errno-base.h`.

**Artifacts**:
-   **Blog (Axiomatic Walkthrough)**: [Link to your gh-pages/stage2_return.html]
-   **Driver Source (Strict 0-Warning)**: [Link to your master/stage2/drivers/trace_do_filp_open/trace_do_filp_open.c]

Zero magic. Zero assumptions. Just code and memory.
