#include <linux/dcache.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/uaccess.h>

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Safe VFS depth probe using verified offsets");

static char target_comm[TASK_COMM_LEN] = "";
module_param_string(target_comm, target_comm, sizeof(target_comm), 0644);

/* Verified byte offsets from pahole/BTF analysis */
#define OFF_PATH_DENTRY 0x08 /* nd->path.dentry */
#define OFF_LAST_NAME 0x18   /* nd->last.name */
#define OFF_INODE 0x30       /* nd->inode */
#define OFF_FLAGS 0x38       /* nd->flags */
#define OFF_DEPTH 0x54       /* nd->depth */

static inline int safe_read_ptr(void *dst, void *src) {
  return copy_from_kernel_nofault(dst, src, sizeof(void *));
}

static inline int safe_read_u32(void *dst, void *src) {
  return copy_from_kernel_nofault(dst, src, sizeof(u32));
}

static const char *get_dentry_name(struct dentry *d) {
  if (!d)
    return "NULL";
  return "(ptr)";
}

static int handler_link_path_walk(struct kprobe *p, struct pt_regs *regs) {
  void *nd = (void *)regs->si;
  /* link_path_walk(name, nd) -> name is %rdi, nd is %rsi */
  const char *target = (const char *)regs->di;
  struct dentry *parent = NULL;
  u32 salt = 0;

  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  if (safe_read_ptr(&parent, nd + OFF_PATH_DENTRY) != 0)
    parent = NULL;

  if (parent) {
    safe_read_u32(&salt, (void *)parent + 0x20);
  }

  if (target && parent) {
    unsigned long h = salt;
    const char *ptr = target;
    char c;

    pr_info("[B1] Parent=%px Salt=0x32_0x%x TargetP=%px\n", parent, salt,
            target);
    while (copy_from_kernel_nofault(&c, ptr, 1) == 0 && c != '\0' && c != '/') {
      h = (h + (c << 4) + (c >> 4)) * 11;
      pr_info("[B2] Char: %c Hash: 0x%lx\n", c, h);
      ptr++;
    }
  }

  return 0;
}

static int handler_walk_component(struct kprobe *p, struct pt_regs *regs) {
  void *nd = (void *)regs->di;
  struct dentry *parent = NULL;
  const char *target = NULL;
  u32 depth = 0;
  int wc_flags = (int)regs->si;

  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  if (safe_read_ptr(&parent, nd + OFF_PATH_DENTRY) != 0)
    parent = NULL;

  if (safe_read_ptr((void *)&target, nd + OFF_LAST_NAME) != 0)
    target = NULL;

  safe_read_u32(&depth, nd + OFF_DEPTH);

  pr_info("[WC] Parent=%px TargetP=%px flags=0x%x depth=%u\n", parent, target,
          wc_flags, depth);

  return 0;
}

static struct kprobe kp_link_path = {
    .symbol_name = "link_path_walk",
    .pre_handler = handler_link_path_walk,
};

static struct kprobe kp_walk_comp = {
    .symbol_name = "walk_component",
    .pre_handler = handler_walk_component,
};

static int __init vfs_depth_init(void) {
  int ret;
  ret = register_kprobe(&kp_link_path);
  if (ret < 0)
    return ret;
  ret = register_kprobe(&kp_walk_comp);
  if (ret < 0) {
    unregister_kprobe(&kp_link_path);
    return ret;
  }
  pr_info("vfs_depth_probe: loaded\n");
  return 0;
}

static void __exit vfs_depth_exit(void) {
  unregister_kprobe(&kp_walk_comp);
  unregister_kprobe(&kp_link_path);
  pr_info("vfs_depth_probe: unloaded\n");
}

module_init(vfs_depth_init);
module_exit(vfs_depth_exit);
