#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>

/*
 * Proof by Instruction Offset
 * We derived from objdump that offset +314 is inside the AT_FDCWD branch.
 * 0x454a (mov %gs:...) - 0x4410 (start) = 0x13a = 314.
 */
#define PROBE_OFFSET 314

static struct kprobe kp = {
    .symbol_name = "path_init",
    .offset = PROBE_OFFSET,
};

static int handler_pre(struct kprobe *p, struct pt_regs *regs) {
  if (current->comm[0] == 'd' &&
      current->comm[1] == 'e') { // Filter for "demo_..."
    pr_info("[PROOF] path_init+314 EXECUTION DETECTED! pid=%d comm=%s\n",
            current->pid, current->comm);
    pr_info("[PROOF] This proves we entered the AT_FDCWD branch.\n");
  }
  return 0;
}

static int __init kprobe_init(void) {
  kp.pre_handler = handler_pre;
  int ret = register_kprobe(&kp);
  if (ret < 0) {
    pr_err("[PROOF] register_kprobe failed, returned %d\n", ret);
    return ret;
  }
  pr_info("[PROOF] Probed path_init at offset %d\n", PROBE_OFFSET);
  return 0;
}

static void __exit kprobe_exit(void) {
  unregister_kprobe(&kp);
  pr_info("[PROOF] Probe unregister_kprobe at offset %d\n", PROBE_OFFSET);
}

module_init(kprobe_init) module_exit(kprobe_exit) MODULE_LICENSE("GPL");
