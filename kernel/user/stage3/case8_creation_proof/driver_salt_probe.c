#include <linux/dcache.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/sched.h>

static struct kprobe kp = {
    .symbol_name = "full_name_hash",
};

/*
 * full_name_hash(const void *salt, const char *name, unsigned int len)
 * RDI = salt
 * RSI = name
 * RDX = len
 */
static int handler_pre(struct kprobe *p, struct pt_regs *regs) {
  const void *salt = (const void *)regs->di;
  const char *name = (const char *)regs->si;
  unsigned int len = (unsigned int)regs->dx;

  if (name) {
    // Filter: Only log for our specific proof files "creation_proof"
    // We can check first few chars.
    // Since 'name' is just char*, we need to be careful reading it.
    // It resides in kernel memory usually (if called from kernel path walking).
    // Let's check first 8 bytes.

    char buf[16];
    // We can't safely copy_from_user if it's user memory, but full_name_hash is
    // usually called on kernel buffer linked from nameidata or dentry. However,
    // safely reading 8 chars is tricky if we don't know it's valid. But for
    // this debug driver, we assume it's valid kernel memory for now. We will
    // match "creation" prefix.

    if (name[0] == 'c' && name[1] == 'r' && name[2] == 'e' && name[3] == 'a' &&
        name[4] == 't' && name[5] == 'i' && name[6] == 'o' && name[7] == 'n') {

      printk(KERN_INFO "PROBE_SALT: Comm=%s PID=%d\n", current->comm,
             current->pid);
      printk(KERN_INFO "PROBE_SALT: Salt=%p\n", salt);
      printk(KERN_INFO "PROBE_SALT: Name='%.*s' Len=%u\n", 15, name, len);
    }
  }

  return 0;
}

static int __init kprobe_init(void) {
  kp.pre_handler = handler_pre;
  int ret = register_kprobe(&kp);
  if (ret < 0) {
    printk(KERN_INFO "PROBE_SALT: full_name_hash failed (maybe inlined?)\n");
    // Fallback or just fail? The user wants 4 drivers.
    // If it fails, we admit it.
    return ret;
  }
  printk(KERN_INFO "PROBE_SALT: Planted kprobe at %s\n", kp.symbol_name);
  return 0;
}

static void __exit kprobe_exit(void) {
  unregister_kprobe(&kp);
  printk(KERN_INFO "PROBE_SALT: kprobe unregistered\n");
}

module_init(kprobe_init) module_exit(kprobe_exit) MODULE_LICENSE("GPL");
