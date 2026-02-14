#include <linux/dcache.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/sched.h>

static struct kprobe kp = {.symbol_name = "full_name_hash"};

static int handler_pre(struct kprobe *p, struct pt_regs *regs) {
  const void *salt = (const void *)regs->di;
  const char *name = (const char *)regs->si;
  if (name && strncmp(name, "break_", 6) == 0) {
    printk(KERN_INFO "PROBE_SYMMETRY: Salt=%px Name='%s' Hash=0x%08x\n", salt,
           name,
           (u32)regs->ax); // ax might not be hash yet in pre, but we see later
  }
  return 0;
}

static int __init symmetry_init(void) {
  kp.pre_handler = handler_pre;
  return register_kprobe(&kp);
}

static void __exit symmetry_exit(void) { unregister_kprobe(&kp); }

module_init(symmetry_init) module_exit(symmetry_exit) MODULE_LICENSE("GPL");
