# AXIOMATIC CURRICULUM: What Happens When Open Is Called

## THE RULES
1.  **NO MAGIC**: Every concept must be defined before use.
2.  **NO INFERENCE**: Do not assume the user knows "standard" things.
3.  **NO FLUFF**: No "In this section", "Let's dive in". Just Facts.
4.  **DERIVATION**: Line N must strictly follow from Lines 0..N-1.

## STAGE INDEX
- **STAGE 0**: Failure Predictions (The "Why")
- **STAGE 1**: The User Call (The "Input")
- **STAGE 2**: The Kernel Entry (The "Transition")
- **STAGE 3**: The Path Walk (The "Search")
- **STAGE 4**: The Allocation (The "Creation")
- **STAGE 5**: The Return (The "Output")

---

## STAGE 0: FAILURE PREDICTIONS
**Goal**: You cannot fix what you cannot predict.
**Tools**: `strace`, `man`.
**Axioms**:
- F1: File Does Not Exist (ENOENT).
- F2: Permission Denied (EACCES).
- F3: File Descriptor Table Full (EMFILE).
- F4: Interrupted System Call (EINTR).

## STAGE 1: THE USER CALL
**Goal**: Transform "file.txt" (String) into Registers (Hardware).
**Tools**: `gcc -S`, `objdump`.
**Axioms**:
- A01: A string is a sequence of bytes ending in 0.
- A02: A register is a 64-bit storage location.
- A03: The ABI (Application Binary Interface) dictates where arguments go.
    - RDI = Arg 1 (Filename pointer)
    - RSI = Arg 2 (Flags)
    - RDX = Arg 3 (Mode)
    - RAX = Syscall Number (2 for Open)

## STAGE 2: THE KERNEL ENTRY
**Goal**: Cross the boundary from Ring 3 (User) to Ring 0 (Kernel).
**Tools**: `gdb` (if possible), `Documentation/x86/entry_64.rst`.
**Axioms**:
- B01: CPU Mode (Ring) determines privilege.
- B02: `syscall` instruction acts as a wormhole (Trap).
- B03: `MSR_LSTAR` holds the kernel's landing address.

## STAGE 3: THE PATH WALK
**Goal**: Find the Inode Number on Disk.
**Tools**: `debugfs`, `stat`.
**Axioms**:
- C01: A Dir is a file mapping Name -> Inode.
- C02: "Walking" = Reading Dir -> Finding Name -> Reading Next Inode.
- C03: Optimization = Dentry Cache (RAM).

## STAGE 4: THE ALLOCATION
**Goal**: Create the `struct file` in RAM.
**Tools**: `slabtop`, `/proc/slabinfo`.
**Axioms**:
- D01: Everything in Kernel is a Struct (Block of Memory).
- D02: `struct file` holds the Position (cursor).
- D03: Inode holds the Content.
- D04: `fd` is just an index into an array.

## STAGE 5: THE RETURN
**Goal**: Hand the Integer back to User.
**Tools**: `/proc/self/fd`.
**Axioms**:
- E01: Return value goes in RAX.
- E02: Negative values are Errors (errno).
- E03: `sys_exit` restores User Registers.

---

## PROOF MANIFEST
1.  `proofs/00_register_dump.c`: View CPU registers before syscall.
2.  `proofs/01_path_walk_simulator.c`: Mimic kernel path walking in user space.
3.  `proofs/02_fd_exhaustion.c`: Prove the table limit.
