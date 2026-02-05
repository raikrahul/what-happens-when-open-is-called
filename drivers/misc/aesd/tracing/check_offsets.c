#include <linux/fs.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/namei.h>
#include <linux/sched.h>
// We need to define struct open_flags manually since it's in fs/internal.h
// Copying EXACT definition from fs/internal.h check
struct open_flags {
  int open_flag;
  umode_t mode;
  int acc_mode;
  int intent;
  int lookup_flags;
};

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Axiom Source: Check Offsets");

static int __init check_init(void) {
  pr_info("AXIOM: O_RDWR = 0x%x\n", O_RDWR);
  pr_info("AXIOM: O_LARGEFILE = 0x%x\n", O_LARGEFILE);
  pr_info("AXIOM: sizeof(struct filename) = %lu\n", sizeof(struct filename));
  pr_info("AXIOM: offsetof(struct filename, name) = %lu\n",
          offsetof(struct filename, name));
  pr_info("AXIOM: offsetof(struct filename, uptr) = %lu\n",
          offsetof(struct filename, uptr));

  pr_info("AXIOM: sizeof(struct open_flags) = %lu\n",
          sizeof(struct open_flags));
  pr_info("AXIOM: offsetof(struct open_flags, open_flag) = %lu\n",
          offsetof(struct open_flags, open_flag));
  pr_info("AXIOM: offsetof(struct open_flags, acc_mode) = %lu\n",
          offsetof(struct open_flags, acc_mode));

  pr_info("AXIOM: sizeof(struct file) = %lu\n", sizeof(struct file));
  pr_info("AXIOM: offsetof(struct file, f_op) = %lu\n",
          offsetof(struct file, f_op));
  pr_info("AXIOM: offsetof(struct file, f_inode) = %lu\n",
          offsetof(struct file, f_inode));

  return 0;
}

static void __exit check_exit(void) {}

module_init(check_init);
module_exit(check_exit);
