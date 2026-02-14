#include <linux/dcache.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/sched.h>

static struct kprobe kp_parallel = {
    .symbol_name = "d_alloc_parallel",
};

static struct kprobe kp_alloc = {
    .symbol_name = "d_alloc",
};

static int handler_pre(struct kprobe *p, struct pt_regs *regs) {
  struct dentry *parent = (struct dentry *)regs->di;
  struct qstr *name = (struct qstr *)regs->si;

  // Filter by comm prefix "user_"
  if (strncmp(current->comm, "user_", 5) == 0) {
    if (name && name->name) {
      printk(KERN_INFO "PROBE_CREATION [%s]: Comm=%s PID=%d\n", p->symbol_name,
             current->comm, current->pid);
      printk(KERN_INFO "PROBE_CREATION [%s]: Parent=%px Dentry=%px\n",
             p->symbol_name, parent,
             (void *)regs->ax); // In d_alloc_parallel, dentry is returned/known
      printk(KERN_INFO "PROBE_CREATION [%s]: qstr_ptr=%px name_ptr=%px\n",
             p->symbol_name, name, name->name);
      printk(KERN_INFO "PROBE_CREATION [%s]: Name='%s' Hash=0x%08x\n",
             p->symbol_name, name->name, name->hash);
    }
  }
  return 0;
}

static int __init kprobe_init(void) {
  kp_parallel.pre_handler = handler_pre;
  kp_alloc.pre_handler = handler_pre;

  register_kprobe(&kp_parallel);
  register_kprobe(&kp_alloc);

  printk(KERN_INFO "PROBE_CREATION: Drivers loaded (parallel + alloc)\n");
  return 0;
}

static void __exit kprobe_exit(void) {
  unregister_kprobe(&kp_parallel);
  unregister_kprobe(&kp_alloc);
}

module_init(kprobe_init) module_exit(kprobe_exit) MODULE_LICENSE("GPL");
