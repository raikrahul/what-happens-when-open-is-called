#include <linux/dcache.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/sched.h>

static struct kprobe kp = {
    .symbol_name = "full_name_hash",
};

static int handler_pre(struct kprobe *p, struct pt_regs *regs) {
  const void *salt = (const void *)regs->di;
  const char *name = (const char *)regs->si;
  unsigned int len = (unsigned int)regs->dx;

  if (name && strncmp(name, "avalanche_", 10) == 0) {
    printk(KERN_INFO "PROBE_Y_AXIOM: Name='%s' Salt(y)=%px\n", name, salt);
  }
  return 0;
}

static int __init kprobe_init(void) {
  kp.pre_handler = handler_pre;
  return register_kprobe(&kp);
}

static void __exit kprobe_exit(void) { unregister_kprobe(&kp); }

module_init(kprobe_init) module_exit(kprobe_exit) MODULE_LICENSE("GPL");
