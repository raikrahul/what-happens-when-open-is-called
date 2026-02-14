#include <linux/fprobe.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/namei.h>
#include <linux/sched.h>

static char *target_comm = "user_trigger";

static int fprobe_entry_handler(struct fprobe *fp, unsigned long entry_ip,
                                unsigned long ret_ip, struct ftrace_regs *regs,
                                void *entry_data) {
  struct pt_regs *pt_regs = ftrace_get_regs(regs);

  if (!pt_regs || strncmp(current->comm, target_comm, strlen(target_comm)) != 0)
    return 0;

  pr_info("FPROBE_ENTRY: comm=%s pid=%d dfd=%ld pathname_ptr=%px\n",
          current->comm, current->pid, pt_regs->di, (void *)pt_regs->si);
  return 0;
}

static void fprobe_exit_handler(struct fprobe *fp, unsigned long entry_ip,
                                unsigned long ret_ip, struct ftrace_regs *regs,
                                void *entry_data) {
  struct pt_regs *pt_regs = ftrace_get_regs(regs);
  unsigned long retval;

  if (!pt_regs || strncmp(current->comm, target_comm, strlen(target_comm)) != 0)
    return;

  retval = regs_return_value(pt_regs);
  pr_info("FPROBE_RET: comm=%s pid=%d rax=%lx\n", current->comm, current->pid,
          retval);
}

static struct fprobe my_fprobe = {
    .entry_handler = fprobe_entry_handler,
    .exit_handler = fprobe_exit_handler,
};

static int __init fprobe_init(void) {
  int ret;
  const char *symbol = "do_filp_open";

  ret = register_fprobe(&my_fprobe, symbol, NULL);
  if (ret < 0) {
    pr_err("register_fprobe failed, returned %d\n", ret);
    return ret;
  }
  pr_info("Fprobe Registered at %s\n", symbol);
  return 0;
}

static void __exit fprobe_exit(void) {
  unregister_fprobe(&my_fprobe);
  pr_info("Fprobe unregistered\n");
}

module_init(fprobe_init);
module_exit(fprobe_exit);
MODULE_LICENSE("GPL");
