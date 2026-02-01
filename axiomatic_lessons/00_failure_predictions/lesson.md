# LESSON 00: FAILURE PREDICTIONS
> **Goal**: Predict how `open()` will fail before you write a single line of code.

01. **Axiom of Finity**: The computer is finite.
02. **Axiom of Authority**: The OS owns the hardware. You are a guest.
03. **Axiom of State**: The world changes between lines of code.

## THE PREDICTIONS

### P1: THE MISSING FILE (ENOENT)
01. You ask for "ghost.txt".
02. The OS looks at the disk directory.
03. The name "ghost.txt" is not found.
04. **Result**: `open` returns -1. `errno` is set to 2 (ENOENT).
05. **Math**: `File ∈ Directory` is FALSE.

### P2: THE FORBIDDEN FILE (EACCES)
01. You ask for "/etc/shadow" (The Password Hash File).
02. The OS checks the Inode Owner.
03. Owner is Root (0). You are User (1000).
04. Mode is 0600 (Only Owner Read/Write).
05. **Result**: `open` returns -1. `errno` is set to 13 (EACCES).
06. **Math**: `UserID == OwnerID` is FALSE.

### P3: THE FULL TABLE (EMFILE)
01. Process has a limit. See `ulimit -n`. Usually 1024.
02. You open 1024 files in a loop. Do not close them.
03. You try to open 1025th file.
04. **Result**: `open` returns -1. `errno` is set to 24 (EMFILE).
05. **Math**: `Used_Slots < Total_Slots` is FALSE.

## YOUR JOB
1.  Go to `proofs/02_fd_exhaustion.c`.
2.  Prove Prediction P3 by running the code.
