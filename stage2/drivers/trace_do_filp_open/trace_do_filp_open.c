/*
 * TRACE: do_filp_open
 * ===================
 *
 * FUNCTION SIGNATURE (from fs/namei.c):
 * struct file *do_filp_open(int dfd, struct filename *pathname,
 *                           const struct open_flags *op)
 *
 * AXIOM 0: ARGUMENT REGISTERS (x86_64 Calling Convention)
 * RDI = Arg1 = int dfd
 * RSI = Arg2 = struct filename *pathname
 * RDX = Arg3 = const struct open_flags *op
 *
 * AXIOM 0.1: RETURN REGISTER (x86_64 Calling Convention)
 * RAX = Return Value (struct file *)
 *
 * AXIOM 1: POINTER VALIDATION
 * Kernel pointers (x86_64) > 0xffff800000000000
 * Userspace pointers (x86_64) < 0x0000800000000000
 *
 * AXIOM 2: STRUCT OPEN_FLAGS LAYOUT (Found in previous steps)
 * Size: 20 bytes
 * +0x00 open_flag (int)
 * +0x04 mode      (umode_t)
 * +0x08 acc_mode  (int)
 * +0x0C intent    (int)
 * +0x10 lookup_flags (int)
 */

#include <linux/fs.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/ptrace.h>
#include <linux/sched.h> // for current
#include <linux/string.h>
#include <linux/types.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("User");
MODULE_DESCRIPTION("Trace do_filp_open arguments and return value");

/*
 * BOILERPLATE: Redefining struct open_flags because it is private to fs/
 */
struct open_flags {
  int open_flag;
  umode_t mode;
  int acc_mode;
  int intent;
  int lookup_flags;
};

static struct kprobe kp;
static struct kretprobe rp;

static int entry_handler(struct kprobe *p, struct pt_regs *regs) {
  struct task_struct *task = current;
  // Context filter: Only trace our specific test program
  if (strcmp(task->comm, "minimal_open") != 0)
    return 0;

  /*
   * ═══════════════════════════════════════════════════════════════════════
   * TODO #1: EXTRACT ARGUMENTS FROM REGISTERS
   * ═══════════════════════════════════════════════════════════════════════
   * AXIOM: x86_64 passes first 3 integer/pointer args in RDI, RSI, RDX.
   *
   * 1. Define 'int dfd'.
   * 2. Define 'struct filename *pathname'.
   * 3. Define 'struct open_flags *op'.
   * 4. CAST reg values to these types.
   *
   * DATA:
   * regs->di holds Arg1
   * regs->si holds Arg2
   * regs->dx holds Arg3
   */

  // int dfd = (int)regs->di; // Unused
  struct filename *pathname = (struct filename *)regs->si;
  struct open_flags *op = (struct open_flags *)regs->dx;

  /*
   * ═══════════════════════════════════════════════════════════════════════
   * TODO #2: VALIDATE POINTERS
   * ═══════════════════════════════════════════════════════════════════════
   * AXIOM: pathname and op should be KERNEL pointers (0xffff...).
   *
   * 1. Check if pathname > 0xffff000000000000.
   * 2. Check if op > 0xffff000000000000.
   * 3. Use pr_info() to print them with %px.
   */

  if ((unsigned long)pathname > 0xffff000000000000) {
    pr_info("pathname is a kernel pointer: %px\n", pathname);
  } else {
    pr_info("pathname is a userspace pointer: %px (UNEXPECTED)\n", pathname);
  }

  if ((unsigned long)op > 0xffff000000000000) {
    pr_info("op is a kernel pointer: %px\n", op);
  } else {
    pr_info("op is a userspace pointer: %px (UNEXPECTED)\n", op);
  }

  /*
   * ═══════════════════════════════════════════════════════════════════════
   * TODO #3: DEREFERENCE AND PRINT
   * ═══════════════════════════════════════════════════════════════════════
   * AXIOM: We are in kernel space. We can read kernel memory directly.
   *
   * 1. Print the string: pathname->name (Use %s).
   * 2. Print ope->open_flag (expect 0x8002 for O_RDWR | O_LARGEFILE).
   * 3. Print op->acc_mode (expect 0x6 for MAY_READ | MAY_WRITE).
   */

  pr_info("pathname->name ptr: %px\n", pathname->name);
  pr_info("pathname->name: %s\n", pathname->name);
  pr_info("op->open_flag: 0x%x\n", op->open_flag);
  pr_info("op->acc_mode: 0x%x\n", op->acc_mode);

  return 0;
}

static int ret_handler(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct task_struct *task = current;
  if (strcmp(task->comm, "minimal_open") != 0)
    return 0;

  /*
   * ═══════════════════════════════════════════════════════════════════════
   * TODO #4: EXTRACT RETURN VALUE
   * ═══════════════════════════════════════════════════════════════════════
   * AXIOM: x86_64 return value is in RAX.
   *
   * 1. Define 'struct file *ret_file'.
   * 2. Assign from regs->ax.
   *
   * CHECK: IS_ERR(ret_file)?
   * If so, print PTR_ERR(ret_file).
   * Else, print pointer address.
   */

  struct file *ret_file = (struct file *)regs->ax;
  if (IS_ERR(ret_file)) {
    pr_info("ret_file is an error: %ld\n", PTR_ERR(ret_file));
  } else {
    pr_info("ret_file is a pointer: %px\n", ret_file);

    /*
     * ═══════════════════════════════════════════════════════════════════
     * TODO #5: PRINT STRUCT FILE FIELDS (Bonus)
     * ═══════════════════════════════════════════════════════════════════
     * We have a valid 'struct file *'. Let's see what's inside!
     *
     * 1. Print ret_file->f_pos  (offset)
     * 2. Print ret_file->f_flags (flags)
     * 3. Print ret_file->f_mode  (mode)
     * 4. Print atomic_long_read(&ret_file->f_count) (refcount)
     */

    pr_info("ret_file->f_pos: %lld\n", ret_file->f_pos);
    pr_info("ret_file->f_flags: 0x%x\n", ret_file->f_flags);
    pr_info("ret_file->f_mode: 0x%x\n", ret_file->f_mode);
    pr_info("ret_file->f_count: %ld\n", (long)file_count(ret_file));

    /*
     * ═══════════════════════════════════════════════════════════════════
     * TODO #6: VERIFY FILENAME MATCH
     * ═══════════════════════════════════════════════════════════════════
     * AXIOM: do_filp_open finds the file corresponding to 'pathname'.
     *
     * 1. Print ret_file->f_path.dentry->d_name.name address (%px)
     * 2. Print ret_file->f_path.dentry->d_name.name string (%s)
     * 3. Compare with what we saw in entry_handler.
     */
    pr_info("ret_file->f_path.dentry->d_name.name ptr: %px\n",
            ret_file->f_path.dentry->d_name.name);
    pr_info("ret_file->f_path.dentry->d_name.name: %s\n",
            ret_file->f_path.dentry->d_name.name);
  }

  return 0;
}

static int __init trace_do_filp_open_init(void) {
  int ret;

  // 1. KPROBE (Entry)
  kp.symbol_name = "do_filp_open";
  kp.pre_handler = entry_handler;
  ret = register_kprobe(&kp);
  if (ret < 0) {
    pr_err("register_kprobe failed, returned %d\n", ret);
    return ret;
  }
  pr_info("kprobe registered for do_filp_open\n");

  // 2. KRETPROBE (Return)
  rp.kp.symbol_name = "do_filp_open";
  rp.handler = ret_handler;
  rp.maxactive = 20; // Allow tracing recursion up to 20 deep (standard)
  ret = register_kretprobe(&rp);
  if (ret < 0) {
    pr_err("register_kretprobe failed, returned %d\n", ret);
    unregister_kprobe(&kp); // Cleanup
    return ret;
  }
  pr_info("kretprobe registered for do_filp_open\n");

  return 0;
}

static void __exit trace_do_filp_open_exit(void) {
  unregister_kretprobe(&rp);
  unregister_kprobe(&kp);
  pr_info("kprobe/kretprobe unregistered\n");
}

module_init(trace_do_filp_open_init);
module_exit(trace_do_filp_open_exit);
