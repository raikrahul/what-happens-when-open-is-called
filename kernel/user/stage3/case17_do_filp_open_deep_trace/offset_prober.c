#include <linux/fs.h>
#include <linux/module.h>
#include <linux/stddef.h>

static int __init offset_init(void) {
  printk(KERN_INFO "[OFFSET] struct file size: %zu\n", sizeof(struct file));
  printk(KERN_INFO "[OFFSET] f_path offset: %zu\n",
         offsetof(struct file, f_path));
  printk(KERN_INFO "[OFFSET] dentry offset in file: %zu\n",
         offsetof(struct file, f_path.dentry));
  return -1; // Prevent loading
}

module_init(offset_init);
MODULE_LICENSE("GPL");
