#include <linux/dcache.h>
#include <linux/errno.h>
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

// Utility to check if a filename matches
static bool is_target(const char *name) {
  if (!name)
    return false;
  return strncmp(name, TARGET_FILE, strlen(TARGET_FILE)) == 0;
}

// Trace Format: #Order. [ENTRY|EXIT]. Function. Data. Work. Caller:Line.
#define TRACE_FMT "DEEP_TRACE: #%d.%s. %s. Data=%px|0x%lx Work=%s Caller=%pS\n"

static atomic_t order = ATOMIC_INIT(0);

// Functions to probe - UPDATED based on kallsyms check:
// - d_alloc_parallel (Exists!)
// - lookup_open (Renamed to loopup_open.isra.0 in this kernel)
static const char *func_list[] = {
    "do_sys_openat2",     "do_filp_open",   "path_openat",
    "path_init",          "link_path_walk", "open_last_lookups",
    "lookup_open.isra.0", "lookup_fast",    "d_alloc_parallel",
    "__d_lookup_rcu",     "full_name_hash", "vfs_open"};

#define MAX_PROBES 12
static struct kretprobe probes[MAX_PROBES];
static int registered_probes = 0;

static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct kretprobe *rp;
  const char *func;
  void *arg1;
  unsigned long arg2;
  bool match = false;

  if (!ri || !get_kretprobe(ri))
    return 0;

  rp = get_kretprobe(ri);
  func = rp->kp.symbol_name;
  if (!func)
    return 0;

  arg1 = (void *)regs->di;
  arg2 = (unsigned long)regs->si;

  // Filtering logic
  if (strcmp(func, "do_sys_openat2") == 0) {
    // PREVENT MISTAKE #3: Use struct definition if available, else standard
    // offset 0 In 6.x, struct filename start with 'const char *name'
    struct filename *fname = (struct filename *)regs->si;
    // We access it carefully. Since we are in kprobe, we can read kernel memory
    // directly.
    const char *kernel_name = fname->name;

    if (kernel_name && !IS_ERR(kernel_name)) {
      if (is_target(kernel_name))
        match = true;
    }
  } else {
    // PREVENT MISTAKE #4: Use simpler task check for now, but acknowledge PID
    // limitation
    if (strncmp(current->comm, "user_deep", 9) == 0)
      match = true;
  }

  if (match) {
    printk(TRACE_FMT, atomic_inc_return(&order), "ENTRY", func, arg1, arg2,
           "Entering", (void *)regs->bp);
  }
  return 0;
}

static int ret_handler(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct kretprobe *rp;
  const char *func;

  // BUG FIX #4: Validate pointers
  if (!ri)
    return 0;

  rp = get_kretprobe(ri);
  if (!rp)
    return 0;

  func = rp->kp.symbol_name;
  if (!func)
    return 0;

  if (strncmp(current->comm, "user_deep", 9) == 0) {
    printk(TRACE_FMT, atomic_inc_return(&order), "EXIT", func, (void *)regs->ax,
           0L, "Resuming", (void *)regs->bp);
  }
  return 0;
}

static int __init case15_trace_init(void) {
  int i, ret;

  registered_probes = 0;

  for (i = 0; i < MAX_PROBES; i++) {
    probes[i].handler = ret_handler;
    probes[i].entry_handler = entry_handler;
    probes[i].kp.symbol_name = func_list[i];
    probes[i].maxactive = 64;
    ret = register_kretprobe(&probes[i]);
    if (ret) {
      printk(KERN_ERR "Failed to register %s (error %d)\n", func_list[i], ret);
      // BUG FIX #5: Clear symbol_name for failed probes so handler won't crash
      probes[i].kp.symbol_name = NULL;
    } else {
      printk(KERN_INFO "Successfully registered kretprobe on %s\n",
             func_list[i]);
      registered_probes++;
    }
  }

  if (registered_probes == 0) {
    printk(KERN_ERR "No probes registered, module init failed\n");
    return -EINVAL;
  }

  printk(KERN_INFO "case15_deep_trace: Loaded %d/%d probes\n",
         registered_probes, MAX_PROBES);
  return 0;
}

static void __exit case15_trace_exit(void) {
  int i;
  int unregistered = 0;

  for (i = 0; i < MAX_PROBES; i++) {
    // BUG FIX #6: Only unregister successfully registered probes
    if (probes[i].kp.symbol_name != NULL) {
      unregister_kretprobe(&probes[i]);
      unregistered++;
    }
  }

  printk(KERN_INFO "case15_deep_trace: Unloaded %d probes\n", unregistered);
}

module_init(case15_trace_init);
module_exit(case15_trace_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Case 15: Deep VFS trace for axiomatic proof");
MODULE_AUTHOR("R");
