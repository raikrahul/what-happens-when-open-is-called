#include <linux/dcache.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/sched.h>

static struct kprobe kp = {
    .symbol_name = "__d_lookup_rcu",
};

static int handler_pre(struct kprobe *p, struct pt_regs *regs) {
  struct dentry *parent = (struct dentry *)regs->di;
  struct qstr *name = (struct qstr *)regs->si;

  if (strncmp(current->comm, "user_", 5) == 0) {
    if (name && name->name) {
      printk(KERN_INFO "PROBE_LOOKUP: Comm=%s PID=%d\n", current->comm,
             current->pid);
      printk(KERN_INFO "PROBE_LOOKUP: Parent=%px\n", parent);
      printk(KERN_INFO "PROBE_LOOKUP: Name='%s' Len=%u Hash=0x%08x\n",
             name->name, name->len, name->hash);
    }
  }
  return 0;
}

static int __init kprobe_init(void) {
  kp.pre_handler = handler_pre;
  return register_kprobe(&kp);
}

static void __exit kprobe_exit(void) { unregister_kprobe(&kp); }

module_init(kprobe_init) module_exit(kprobe_exit) MODULE_LICENSE("GPL");
