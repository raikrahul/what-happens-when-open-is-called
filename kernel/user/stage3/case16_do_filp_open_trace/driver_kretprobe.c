#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/namei.h>
#include <linux/sched.h>

static char *target_comm = "user_trigger";

struct my_data {
  unsigned long entry_timestamp;
};

static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct my_data *data;

  if (strncmp(current->comm, target_comm, strlen(target_comm)) != 0)
    return 1; // Skip

  data = (struct my_data *)ri->data;
  data->entry_timestamp = jiffies;

  pr_info("KRETPROBE_ENTRY: comm=%s pid=%d dfd=%ld pathname_ptr=%px\n",
          current->comm, current->pid, regs->di, (void *)regs->si);

  return 0;
}

static int ret_handler(struct kretprobe_instance *ri, struct pt_regs *regs) {
  unsigned long retval = regs_return_value(regs);
  struct my_data *data = (struct my_data *)ri->data;

  if (strncmp(current->comm, target_comm, strlen(target_comm)) != 0)
    return 0; // Skip if it somehow got here (shouldn't due to entry return 1)

  pr_info("KRETPROBE_RET: comm=%s pid=%d rax=%lx duration=%lu\n", current->comm,
          current->pid, retval, jiffies - data->entry_timestamp);

  return 0;
}

static struct kretprobe my_kretprobe = {
    .handler = ret_handler,
    .entry_handler = entry_handler,
    .data_size = sizeof(struct my_data),
    .maxactive = 20,
};

static int __init kretprobe_init(void) {
  int ret;

  my_kretprobe.kp.symbol_name = "do_filp_open";
  ret = register_kretprobe(&my_kretprobe);
  if (ret < 0) {
    pr_err("register_kretprobe failed, returned %d\n", ret);
    return ret;
  }
  pr_info("Kretprobe Registered at %s: %px\n", my_kretprobe.kp.symbol_name,
          my_kretprobe.kp.addr);
  return 0;
}

static void __exit kretprobe_exit(void) {
  unregister_kretprobe(&my_kretprobe);
  pr_info("Kretprobe at %s unregistered\n", my_kretprobe.kp.symbol_name);
}

module_init(kretprobe_init) module_exit(kretprobe_exit) MODULE_LICENSE("GPL");
