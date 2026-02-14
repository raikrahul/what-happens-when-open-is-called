#include <linux/dcache.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/namei.h>
#include <linux/sched.h>
#include <linux/string.h>
#include <linux/types.h>
#include <linux/uaccess.h>

#define TARGET_FILE "somefileNew.txt"
#define LOG_SIZE 4096

struct log_state {
  char buffer[LOG_SIZE];
  int pos;
  bool active;
};

static struct log_state __percpu *log_data;

static void log_append(const char *func, const char *msg, void *ptr) {
  struct log_state *ls = this_cpu_ptr(log_data);
  if (!ls->active || ls->pos >= LOG_SIZE - 64)
    return;
  ls->pos += snprintf(ls->buffer + ls->pos, LOG_SIZE - ls->pos, " [%s: %s %px]",
                      func, msg, ptr);
}

static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct kretprobe *rp = get_kretprobe(ri);
  const char *func = rp->kp.symbol_name;
  struct log_state *ls = this_cpu_ptr(log_data);

  if (strcmp(func, "do_sys_openat2") == 0) {
    // FIXED: Do NOT use copy_from_user in kprobe handlers (atomic context)
    // The pathname is already in kernel space via struct filename
    const char *kernel_name = *(const char **)regs->si;
    if (kernel_name && !IS_ERR(kernel_name)) {
      if (strncmp(kernel_name, TARGET_FILE, 10) == 0) {
        ls->active = true;
        ls->pos = 0;
        log_append(func, "START", (void *)regs->si);
      }
    }
  } else if (ls->active) {
    log_append(func, "HIT", (void *)regs->di);
  }
  return 0;
}

static int ret_handler(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct kretprobe *rp = get_kretprobe(ri);
  const char *func = rp->kp.symbol_name;
  struct log_state *ls = this_cpu_ptr(log_data);

  if (ls->active) {
    log_append(func, "RET", (void *)regs->ax);
    if (strcmp(func, "do_sys_openat2") == 0) {
      printk("DEEP_TRACE_LOG: CPU%d %s\n", smp_processor_id(), ls->buffer);
      ls->active = false;
    }
  }
  return 0;
}

static const char *func_list[] = {
    "do_sys_openat2", "path_openat", "path_init",     "link_path_walk",
    "lookup_open",    "lookup_fast", "__d_lookup_rcu"};
static struct kretprobe probes[7];

static int __init case15_smart_init(void) {
  int i, ret;
  log_data = alloc_percpu(struct log_state);
  if (!log_data)
    return -ENOMEM;
  for (i = 0; i < 7; i++) {
    probes[i].handler = ret_handler;
    probes[i].entry_handler = entry_handler;
    probes[i].kp.symbol_name = func_list[i];
    probes[i].maxactive = 64;
    ret = register_kretprobe(&probes[i]);
  }
  return 0;
}

static void __exit case15_smart_exit(void) {
  int i;
  for (i = 0; i < 7; i++)
    unregister_kretprobe(&probes[i]);
  free_percpu(log_data);
}

module_init(case15_smart_init);
module_exit(case15_smart_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Case 15 Smart Trace: Safe VFS tracing");
