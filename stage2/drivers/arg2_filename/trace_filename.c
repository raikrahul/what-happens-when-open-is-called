/*
 * FIRST DRIVER: ARG2 - THE FILENAME
 * ==================================
 *
 * WHY FIRST:
 * 1. open("somefile", O_RDWR) → libc → openat(dfd=-100, filename=0x7ffe..,
 * flags=0x2, mode=0)
 * 2. Kernel receives 4 args: dfd, filename, flags, mode
 * 3. dfd=-100 → constant, nothing happens
 * 4. filename=0x7ffe.. → USER POINTER → MUST COPY TO KERNEL → getname() → FIRST
 * REAL WORK
 * 5. If getname() fails → ENOENT/EFAULT → nothing else runs
 * ∴ filename copy is the GATE → probe it first
 *
 * TARGET FUNCTION: getname(const char __user *filename)
 * SOURCE: fs/namei.c
 * PROBE TYPE: kretprobe (need return value)
 *
 * x86_64 ABI:
 * ┌──────────┬─────────┬──────────────────────────────────┐
 * │ Register │ Purpose │ Value at getname entry           │
 * ├──────────┼─────────┼──────────────────────────────────┤
 * │ RDI      │ Arg1    │ 0x7ffe1234 (user ptr to string)  │
 * │ RAX      │ Return  │ 0xffff8881.. (struct filename *) │
 * └──────────┴─────────┴──────────────────────────────────┘
 *
 * AXIOMS (from check_offsets.ko):
 * sizeof(struct filename) = 32 bytes
 * offsetof(name) = 0  → *(char**)(ptr + 0) = kernel string address
 * offsetof(uptr) = 8  → *(char**)(ptr + 8) = original user pointer
 *
 * MEMORY FLOW:
 * ┌─────────────────────────────────────────────────────────────┐
 * │ USER SPACE (< 0x8000_0000_0000)                             │
 * │ ┌─────────────────────┐                                     │
 * │ │ 0x7ffe1234: "somefile\0" │ ← RDI points here              │
 * │ └─────────────────────┘                                     │
 * └─────────────────────────────────────────────────────────────┘
 *                    │
 *                    │ getname() copies via strncpy_from_user()
 *                    ▼
 * ┌─────────────────────────────────────────────────────────────┐
 * │ KERNEL SPACE (> 0xffff_8000_0000_0000)                     │
 * │ ┌─────────────────────────────────────────────────────────┐ │
 * │ │ 0xffff888100500000: struct filename (32 bytes)          │ │
 * │ │   +0x00 [name]  = 0xffff888100500020 ─────────────────┐ │ │
 * │ │   +0x08 [uptr]  = 0x7ffe1234 (original user ptr)      │ │ │
 * │ │   +0x10 [refcnt]= 1                                   │ │ │
 * │ │   +0x18 [aname] = NULL                                │ │ │
 * │ └───────────────────────────────────────────────────────│─┘ │
 * │                                                         │   │
 * │ ┌───────────────────────────────────────────────────────▼─┐ │
 * │ │ 0xffff888100500020: "somefile\0" (9 bytes)              │ │
 * │ └─────────────────────────────────────────────────────────┘ │
 * └─────────────────────────────────────────────────────────────┘
 */

#include <linux/fs.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/ptrace.h>
#include <linux/sched.h>
#include <linux/string.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Your Name");
MODULE_DESCRIPTION("ARG2: Trace filename copy from user to kernel");

/*
 * DATA TO SAVE BETWEEN ENTRY AND RETURN:
 * ┌────────────────────────────────────────┐
 * │ struct my_data (24 bytes)              │
 * │   +0x00 [user_ptr] = 0x7ffe1234        │ ← save RDI at entry
 * │   +0x08 [comm]     = "minimal_open"    │ ← 16 bytes
 * │   +0x18 [pid]      = 12345             │ ← 4 bytes
 * └────────────────────────────────────────┘
 */
struct my_data {
  const char __user *user_ptr; /* 8 bytes @ +0x00 */
  char comm[16];               /* 16 bytes @ +0x08 */
  pid_t pid;                   /* 4 bytes @ +0x18 */
};

static struct kretprobe rp;

/*
 * ============================================================================
 * ENTRY HANDLER: CALLED WHEN getname() IS ENTERED
 * ============================================================================
 *
 * REGISTERS AT ENTRY:
 * RDI = 0x7ffe1234 (user pointer to "somefile")
 *
 * YOUR JOB:
 * 1. Check if task->comm == "minimal_open" → if not, return 1 (skip)
 * 2. Save RDI into ri->data for use in ret_handler
 * 3. Save comm and pid for logging
 *
 * AXIOM: regs->di = first argument (x86_64 calling convention)
 * AXIOM: current = pointer to current task_struct
 * AXIOM: ri->data = per-instance storage (we allocated sizeof(my_data))
 */
static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct my_data *data = (struct my_data *)ri->data;
  struct task_struct *task = current;

  /* ═══════════════════════════════════════════════════════════════════════
   * TODO #1: FILTER - Skip if not our process (2 lines)
   *
   * AXIOM: strcmp(a,b)=0 → match, strcmp(a,b)!=0 → no match
   * AXIOM: return 1 → skip ret_handler
   * AXIOM: return 0 → call ret_handler after function returns
   * ═══════════════════════════════════════════════════════════════════════
   */
  // if (strcmp(task->comm, "minimal_open") != 0) return 1;

  /* ═══════════════════════════════════════════════════════════════════════
   * TODO #2: SAVE USER POINTER from RDI register (1 line)
   *
   * AXIOM: regs->di = 0x7ffe1234 (first arg in x86_64)
   * AXIOM: Cast needed: (const char __user *)
   * ═══════════════════════════════════════════════════════════════════════
   */
  // data->user_ptr = ...

  /* BOILERPLATE: Save task info for logging (Keep this for debugging) */
  get_task_comm(data->comm, task);
  data->pid = task->pid;

  return 0;
}

/*
 * ============================================================================
 * RETURN HANDLER: CALLED WHEN getname() RETURNS
 * ============================================================================
 *
 * REGISTERS AT RETURN:
 * RAX = 0xffff888100500000 (struct filename * OR error pointer)
 *
 * MEMORY LAYOUT OF RETURN VALUE:
 * ┌─────────────────────────────────────────────────────────────┐
 * │ 0xffff888100500000: struct filename                        │
 * │   +0x00 [name]  = 0xffff888100500020 → "somefile\0"        │
 * │   +0x08 [uptr]  = 0x7ffe1234 (should match saved user_ptr) │
 * └─────────────────────────────────────────────────────────────┘
 *
 * YOUR JOB:
 * 1. Get RAX from regs->ax
 * 2. Check if IS_ERR(rax) → if error, print error and return
 * 3. Cast RAX to struct filename *
 * 4. Print: user_ptr, kernel_ptr, fn->name, fn->uptr, string content
 * 5. Verify fn->uptr == saved data->user_ptr (axiom check)
 *
 * ERROR POINTER CHECK:
 * IS_ERR(ptr) = true if ptr > 0xfffffffffffff000 (last 4KB)
 * Example: -EFAULT = 0xfffffffffffffff2 → IS_ERR returns true
 * PTR_ERR(ptr) = extract error code = -14
 */
static int ret_handler(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct my_data *data = (struct my_data *)ri->data;
  struct filename *fn;
  unsigned long retval;

  /* ═══════════════════════════════════════════════════════════════════════
   * TODO #3: GET RETURN VALUE from RAX register (1 line)
   *
   * AXIOM: regs->ax = return value in x86_64
   * AXIOM: Store in 'retval' as unsigned long first
   * ═══════════════════════════════════════════════════════════════════════
   */
  // retval = ...

  /* ═══════════════════════════════════════════════════════════════════════
   * TODO #4: CAST to struct filename pointer (1 line)
   *
   * AXIOM: fn = (struct filename *)retval
   * ═══════════════════════════════════════════════════════════════════════
   */
  // fn = ...

  /* ═══════════════════════════════════════════════════════════════════════
   * TODO #5: ERROR CHECK - if IS_ERR(fn), print error and return 0 (4 lines)
   *
   * AXIOM: IS_ERR(0xfffffffffffffff2) = true
   * AXIOM: PTR_ERR(0xfffffffffffffff2) = -14 (EFAULT)
   *
   * Pattern:
   * if (IS_ERR(fn)) {
   *     pr_info("#2. getname. FAIL. user_ptr=0x%px. err=%ld\n",
   *             data->user_ptr, PTR_ERR(fn));
   *     return 0;
   * }
   * ═══════════════════════════════════════════════════════════════════════
   */

  /* ═══════════════════════════════════════════════════════════════════════
   * TODO #6: SUCCESS PATH - Print all the data (1 pr_info with multiple lines)
   *
   * PRINT FORMAT:
   * #2. getname. SUCCESS.
   *     user_ptr (RDI saved) = 0x7ffe1234
   *     fn (RAX)             = 0xffff888100500000
   *     fn->name (+0x00)     = 0xffff888100500020
   *     fn->uptr (+0x08)     = 0x7ffe1234
   *     string               = "somefile"
   *
   * AXIOM: fn->name = *(char**)(fn + 0) = kernel string pointer
   * AXIOM: fn->uptr = *(char**)(fn + 8) = original user pointer
   * ═══════════════════════════════════════════════════════════════════════
   */

  /* ═══════════════════════════════════════════════════════════════════════
   * TODO #7: AXIOM VERIFICATION - Check fn->uptr == data->user_ptr (3 lines)
   *
   * If match: pr_info("    [✓] AXIOM: fn->uptr == saved RDI\n");
   * If no match: pr_info("    [✗] AXIOM FAIL: fn->uptr != saved RDI\n");
   * ═══════════════════════════════════════════════════════════════════════
   */

  return 0;
}

/* ============================================================================
 * BOILERPLATE: Module init/exit (you don't write this)
 * ============================================================================
 */
static int __init trace_filename_init(void) {
  int ret;

  rp.handler = ret_handler;
  rp.entry_handler = entry_handler;
  rp.data_size = sizeof(struct my_data);
  rp.kp.symbol_name = "getname";

  ret = register_kretprobe(&rp);
  if (ret < 0) {
    pr_err("ARG2: register_kretprobe failed, returned %d\n", ret);
    return ret;
  }

  pr_info("ARG2: Module loaded. Probing getname(). sizeof(my_data)=%lu\n",
          sizeof(struct my_data));
  return 0;
}

static void __exit trace_filename_exit(void) {
  unregister_kretprobe(&rp);
  pr_info("ARG2: Module unloaded. Missed %d probes.\n", rp.nmissed);
}

module_init(trace_filename_init);
module_exit(trace_filename_exit);

/*
 * ════════════════════════════════════════════════════════════════════════════
 * FAILURE PREDICTIONS
 * ════════════════════════════════════════════════════════════════════════════
 *
 * F1: COMPILE ERROR - "implicit declaration of strcmp"
 *     Cause: forgot #include <linux/string.h>
 *     Expected: clean compile
 *     Actual: error at strcmp line
 *     Fix: add #include <linux/string.h> → already in boilerplate ✓
 *
 * F2: RUNTIME - "module not found" on insmod
 *     Cause: no Makefile in directory
 *     Expected: insmod succeeds
 *     Actual: "module not found"
 *     Fix: create Makefile with obj-m += trace_filename.o
 *
 * F3: NO OUTPUT in dmesg
 *     Cause: strcmp filter wrong → skipping all probes
 *     Expected: see "#2. getname" lines
 *     Actual: only "Module loaded"
 *     Debug: temporarily remove filter → if output appears, filter is wrong
 *
 * F4: KERNEL OOPS on fn->name access
 *     Cause: fn is error pointer but IS_ERR check missing
 *     Expected: graceful "FAIL" message
 *     Actual: kernel panic
 *     Fix: add IS_ERR check before dereferencing fn
 *
 * F5: fn->uptr != data->user_ptr
 *     Cause: kretprobe instance reused between different calls
 *     Expected: pointers match
 *     Actual: pointers differ
 *     Debug: print both values, check if they're from different open() calls
 *
 * F6: Wrong register name (regs->di vs regs->rdi)
 *     Cause: kernel version difference in pt_regs struct
 *     Expected: compile success
 *     Actual: "struct pt_regs has no member named 'di'"
 *     Fix: use regs_get_register(regs, ...) or check kernel headers
 *
 * ════════════════════════════════════════════════════════════════════════════
 */
