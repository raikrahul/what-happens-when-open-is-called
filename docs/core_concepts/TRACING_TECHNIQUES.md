# TRACE DRIVER TECHNICAL IMPLEMENTATION
## No MBA Words. Pure Derivation.

---

## AXIOM 1: KERNEL SPACE BOUNDARY

Kernel space starts at 0xffff800000000000.  
User space ends at 0x00007fffffffffff.  
Addresses between are invalid.  
∴ Check: (unsigned long)ptr > 0xffff000000000000

---

## AXIOM 2: INTERRUPT CONTEXT CONSTRAINT

Kprobe handlers run with interrupts disabled.  
Page faults in interrupt context → kernel panic.  
∴ Never dereference unchecked pointers.  
∴ Never use %s format specifier (causes page fault on bad pointer).

---

## AXIOM 3: x86_64 CALLING CONVENTION

Arguments: RDI, RSI, RDX, RCX, R8, R9  
Return value: RAX  
∴ regs->si = RSI = argument 2  
∴ regs->ax = RAX = return value

---

## TRICK 1: STRUCT FILENAME EXTRACTION

Input: regs->si (RSI register)  
Operation: Cast to struct pointer  
Output: struct my_filename *f

```c
struct my_filename {
  const char *name;        // offset +0
  const __user char *uptr; // offset +8
  int refcnt;              // offset +16
};

struct my_filename *f = (struct my_filename *)regs->si;
```

Validation chain:  
f != NULL → (unsigned long)f > 0xffff000000000000 → f->name != NULL → (unsigned long)f->name > 0xffff000000000000

---

## TRICK 2: MANUAL OFFSET CALCULATION (STRUCT FILE CHAIN)

Base: file_ptr = (void *)regs->ax  
Step 1: path_ptr = file_ptr + 64  
∵ struct file.f_path at offset +64

Step 2: dentry_ptr = *(void **)(path_ptr + 8)  
∵ struct path.dentry at offset +8

Step 3: qstr_ptr = dentry_ptr + 32  
∵ struct dentry.d_name at offset +32

Step 4: name = *(char **)(qstr_ptr + 8)  
∵ struct qstr.name at offset +8

Total arithmetic: 64 + 8 + 32 + 8 = 108 bytes traversed  
Dereferences: 2 (dentry_ptr, name)

Pointer casting trick:  
(void **) → tells compiler: "this address holds a pointer"  
*(void **) → dereference to get the pointer value  
(char **) → cast to char pointer pointer  
*(char **) → dereference to get char pointer

---

## TRICK 3: STRUCT QSTR EXTRACTION

Input: regs->si (second argument to __d_alloc)  
Operation: Cast + offset  
Output: char *name

```c
void *qstr_ptr = (void *)regs->si;
char **name_ptr = (char **)((unsigned long)qstr_ptr + 8);
char *name = *name_ptr;
```

Why +8?  
struct qstr layout:  
+0: u32 hash  
+4: u32 len  
+8: const char *name  
∴ name pointer at offset +8

---

## TRICK 4: DENTRY NAME EXTRACTION

Input: regs->ax (returned struct dentry *)  
Operation: Single dereference at calculated offset  
Output: void *dname_ptr

```c
void *dentry_ptr = (void *)regs->ax;
void *dname_ptr = *(void **)((unsigned long)dentry_ptr + 40);
```

Why +40?  
struct dentry.d_name at offset +32  
struct qstr.name at offset +8  
∴ 32 + 8 = 40

Pointer arithmetic:  
(unsigned long)dentry_ptr → convert pointer to integer for math  
+ 40 → add offset  
(void **) → cast address to "pointer to pointer"  
*(void **) → dereference to get the name pointer

---

## TRICK 5: PROCESS FILTERING

Axiom: current is global pointer to current task_struct  
Axiom: current->comm is process name (16 bytes)  
Axiom: current->pid is process ID (integer)

Optimization:  
Check PID first (integer compare = 1 CPU cycle)  
Then check comm (strcmp = multiple cycles)  
∴ Early bail-out saves cycles in interrupt context

```c
if (target_pid != -1 && current->pid != target_pid)
  return 0;
return (strcmp(current->comm, target_comm) == 0);
```

---

## TRICK 6: ERROR POINTER DETECTION

MAX_ERRNO = 4095 = 0xFFF  
-MAX_ERRNO in two's complement = 0xfffffffffffff001  
Error range: [0xfffffffffffff001, 0xffffffffffffffff]

IS_ERR(x) macro:  
(unsigned long)x >= (unsigned long)-MAX_ERRNO  
∴ Checks if pointer is in error range

Usage:  
if (IS_ERR(ptr)) → ptr is error code, not valid pointer  
∴ Must check before dereferencing

---

## DERIVATION: COMPLETE TRACE CHAIN

Input: do_filp_open receives filename  
↓
RSI = pointer to struct filename  
↓
filename->name = pointer to string  
↓
[PROBE 1: Input Addr captured]
↓
path lookup → dentry cache miss  
↓
__d_alloc called  
↓
RSI = pointer to struct qstr  
↓
qstr->name = same pointer as filename->name  
↓
[PROBE 2: Copy Source captured]
↓
memcpy(dname, name->name, name->len)  
↓
dentry->d_name.name = pointer to copied string  
↓
[PROBE 3: Copy Dest captured]
↓
__d_alloc returns dentry  
↓
do_filp_open returns struct file  
↓
file->f_path.dentry->d_name.name = Copy Dest pointer  
↓
[PROBE 4: Result Addr captured]

---

## VERIFICATION MATH

Input = Copy Source → ✓ (same pointer)
Copy Dest = Result → ✓ (same pointer)  
Copy Source ≠ Copy Dest → ✓ (memcpy occurred)

---

## TYPE CASTING SUMMARY

1. (struct my_filename *)regs->si  
   Purpose: Treat register as struct pointer

2. (void *)((unsigned long)ptr + offset)  
   Purpose: Convert pointer to integer, add offset, convert back

3. *(void **)(address)  
   Purpose: Treat address as containing a pointer, dereference it

4. (char **)ptr  
   Purpose: Treat as pointer to char pointer (for string access)

5. (void *)regs->ax  
   Purpose: Treat return value register as void pointer

---

## MODULE PARAMETER TRICK

static char *target_comm = "minimal_open";  
module_param(target_comm, charp, 0644);  

This creates:  
/sys/module/trace_do_filp_open/parameters/target_comm  
∴ Runtime configurable without recompile

---

## SAFETY CHECK CHAIN

Every probe uses:
1. is_target() → process filter
2. NULL check → ptr != NULL  
3. Kernel space check → (unsigned long)ptr > 0xffff000000000000  
4. IS_ERR check (for return values) → !IS_ERR(ptr)

∴ 3-4 validation layers before dereference

---

## ACTUAL CAPTURED DATA

Input:       0xffff88c500f5a020  
Copy Source: 0xffff88c500f5a020  ∴ MATCH  
Copy Dest:   0xffff88c50d08e6f8  
Result:      0xffff88c50d08e6f8  ∴ MATCH  

Difference: 0xffff88c50d08e6f8 - 0xffff88c500f5a020 = 0xd08c6d8  
∴ Different memory pages  
∴ Copy actually occurred

---

END OF TECHNICAL DOCUMENTATION
