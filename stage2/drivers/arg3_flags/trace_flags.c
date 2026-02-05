/*
 * SECOND DRIVER: ARG3 - THE FLAGS
 * ================================
 *
 * PREVIOUS STEP: getname() copied "somefile" to kernel memory.
 * THIS STEP: do_filp_open() processes the flags (O_RDWR).
 *
 * WHY THIS STEP:
 * 1. Filename is now safe in kernel space.
 * 2. Kernel must decide: Read? Write? Apppend? Create?
 * 3. O_RDWR (0x2) is a user-space constant.
 * 4. Kernel converts this to 'struct open_flags' internally.
 * 5. We verify this transformation to prove we understand permission bits.
 *
 * TARGET FUNCTION: do_filp_open(int dfd, struct filename *pathname, const
 * struct open_flags *op) SOURCE: fs/namei.c PROBE TYPE: kprobe (entry)
 *
 * ARGUMENTS AT ENTRY (x86_64):
 * RDI (Arg1) = dfd (-100)
 * RSI (Arg2) = struct filename * (from getname result)
 * RDX (Arg3) = const struct open_flags *op
 *
 * AXIOMS (from check_offsets.ko):
 * sizeof(struct open_flags) = 20 bytes
 * +0x00 open_flag (4 bytes): Kernel internal flag representation
 * +0x04 mode      (4 bytes): File mode (permissions)
 * +0x08 acc_mode  (4 bytes): Access mode (MAY_READ, MAY_WRITE)
 * +0x0C intent    (4 bytes): Operation intent
 *
 * MATH (Flag Transformation):
 * User O_RDWR = 0x2
 * Kernel adds O_LARGEFILE (0x8000) automatically on 64-bit?
 * Expected open_flag = 0x2 | 0x8000 = 0x8002
 *
 * ACC_MODE Calculation:
 * O_RDWR usually maps to MAY_READ | MAY_WRITE.
 * MAY_READ = 0x4, MAY_WRITE = 0x2.
 * Expected acc_mode = 0x6.
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
MODULE_DESCRIPTION("ARG3: Trace flag conversion (O_RDWR -> internal)");

/*
 * STRUCT DEFINITION (Private in fs/internal.h, must replicate)
 * Based on AXIOM Check: 20 bytes.
 */
struct open_flags {
  int open_flag;    /* 0x00 */
  umode_t mode;     /* 0x04 */
  int acc_mode;     /* 0x08 */
  int intent;       /* 0x0C */
  int lookup_flags; /* 0x10 */
};

static struct kprobe kp;

/*
 * ENTRY HANDLER:
 * Capture RDX (pointer to struct open_flags)
 */
static int entry_handler(struct kprobe *p, struct pt_regs *regs) {
  struct task_struct *task = current;
  struct open_flags *op;

  /*
   * ═══════════════════════════════════════════════════════════════════════
   * TODO #1: FILTER - Skip if not "minimal_open" (2 lines)
   * ═══════════════════════════════════════════════════════════════════════
   */
  if (strcmp(task->comm, "minimal_open") != 0)
    return 0;

  /*
   * ═══════════════════════════════════════════════════════════════════════
   * TODO #2: CAST RDX to struct open_flags * (1 line)
   * ═══════════════════════════════════════════════════════════════════════
   */
  op = (struct open_flags *)regs->dx;

  /*
   * ═══════════════════════════════════════════════════════════════════════
   * TODO #3: PRINT DATA (Pseudo-Debugger Format)
   *
   * Format:
   * #3. do_filp_open. op_ptr=0x...
   *     open_flag=0x... (matches 0x8002?)
   *     acc_mode=0x...  (matches 0x4|0x2 = 0x6?)
   *     intent=0x...
   *
   * Verify the AXIOM: O_RDWR (0x2) -> open_flag (0x8002)
   * ═══════════════════════════════════════════════════════════════════════
   */
  pr_info("#3. do_filp_open. op_ptr=0x%px.\n", op);
  pr_info("    open_flag=0x%x (Expected 0x8002)\n", op->open_flag);
  pr_info("    acc_mode=0x%x  (Expected 0x6)\n", op->acc_mode);
  pr_info("    intent=0x%x\n", op->intent);

  /*
   * LOGIC CHECK:
   * Check if op->open_flag == (O_RDWR | O_LARGEFILE)
   * O_RDWR=0x2, O_LARGEFILE=0x8000
   */
  if (op->open_flag == (0x2 | 0x8000)) {
    pr_info("    [✓] AXIOM: open_flag == O_RDWR | O_LARGEFILE\n");
  } else {
    pr_info("    [✗] AXIOM FAIL: open_flag mismatch. Got 0x%x\n",
            op->open_flag);
  }

  if (op->acc_mode == 6) { // 4 | 2
    pr_info("    [✓] AXIOM: acc_mode == MAY_READ | MAY_WRITE\n");
  } else {
    pr_info("    [✗] AXIOM FAIL: acc_mode mismatch. Got 0x%x\n", op->acc_mode);
  }

  return 0;
}

static int __init trace_flags_init(void) {
  int ret;
  kp.symbol_name = "do_filp_open";
  kp.pre_handler = entry_handler;

  ret = register_kprobe(&kp);
  if (ret < 0) {
    pr_err("ARG3: register_kprobe failed, returned %d\n", ret);
    return ret;
  }
  pr_info("ARG3: Module loaded. Probing do_filp_open().\n");
  return 0;
}

static void __exit trace_flags_exit(void) {
  unregister_kprobe(&kp);
  pr_info("ARG3: Module unloaded.\n");
}

module_init(trace_flags_init);
module_exit(trace_flags_exit);
