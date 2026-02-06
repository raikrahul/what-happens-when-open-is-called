#include <linux/dcache.h>
#include <linux/fs.h>
#include <linux/module.h>
#include <linux/path.h>

static int __init audit_init(void) {
  pr_info("[audit] struct file size: %zu\n", sizeof(struct file));
  pr_info("[audit] struct file -> f_path offset: %zu\n",
          offsetof(struct file, f_path));
  pr_info("[audit] struct path -> dentry offset: %zu\n",
          offsetof(struct path, dentry));

  pr_info("[audit] struct dentry size: %zu\n", sizeof(struct dentry));
  pr_info("[audit] struct dentry -> d_name offset: %zu\n",
          offsetof(struct dentry, d_name));
  pr_info("[audit] struct qstr -> name offset: %zu\n",
          offsetof(struct qstr, name));
  pr_info("[audit] struct dentry -> d_iname offset: %zu\n",
          offsetof(struct dentry, d_iname));

  return -ENOTTY; // Error return to prevent loading, but prints are flushed
}

static void __exit audit_exit(void) {}

module_init(audit_init);
module_exit(audit_exit);

MODULE_LICENSE("GPL");
