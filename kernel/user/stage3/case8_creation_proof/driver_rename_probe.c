#include <linux/dcache.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/sched.h>

static struct kprobe kp = {
    .symbol_name = "d_move",
};

static int handler_pre(struct kprobe *p, struct pt_regs *regs) {
  struct dentry *dentry = (struct dentry *)regs->di;
  struct dentry *target = (struct dentry *)regs->si;

  if (strncmp(current->comm, "user_", 5) == 0) {
    printk(KERN_INFO "PROBE_RENAME: Comm=%s PID=%d\n", current->comm,
           current->pid);
    printk(KERN_INFO "PROBE_RENAME: Dentry=%px (Invariance Check)\n", dentry);
    printk(KERN_INFO "PROBE_RENAME: OLD: Name='%s' Hash=0x%08x\n",
           dentry->d_name.name, dentry->d_name.hash);
    printk(KERN_INFO "PROBE_RENAME: NEW: Name='%s' Hash=0x%08x\n",
           target->d_name.name, target->d_name.hash);
  }
  return 0;
}

static int __init kprobe_init(void) {
  kp.pre_handler = handler_pre;
  return register_kprobe(&kp);
}

static void __exit kprobe_exit(void) { unregister_kprobe(&kp); }

module_init(kprobe_init) module_exit(kprobe_exit) MODULE_LICENSE("GPL");
