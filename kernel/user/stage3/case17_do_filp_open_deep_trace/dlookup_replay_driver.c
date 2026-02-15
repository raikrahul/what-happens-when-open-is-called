#include <linux/dcache.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/string.h>
#include <linux/uaccess.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("rahultest");
MODULE_DESCRIPTION("Case17: replay d_lookup(parent,qstr) with captured data");

/*
 * Defaults from prior capture; can be overridden at insmod time.
 * Example:
 *   sudo insmod dlookup_replay_driver.ko \
 *        parent_addr=0xffff899181570c00 \
 *        child_name=missing_case17_raw_syscall.txt \
 *        child_hash=0x4101d47
 */
static unsigned long parent_addr = 0xffff899181570c00UL;
module_param(parent_addr, ulong, 0644);
MODULE_PARM_DESC(parent_addr, "Captured parent dentry pointer");

static char child_name[128] = "missing_case17_raw_syscall.txt";
module_param_string(child_name, child_name, sizeof(child_name), 0644);
MODULE_PARM_DESC(child_name, "Captured qstr name bytes");

static unsigned int child_hash = 0x04101d47U;
module_param(child_hash, uint, 0644);
MODULE_PARM_DESC(child_hash, "Captured qstr hash");

static int safe_read(const void *src, void *dst, size_t n)
{
	return copy_from_kernel_nofault(dst, src, n);
}

static int __init dlookup_replay_init(void)
{
	struct dentry *parent = (struct dentry *)parent_addr;
	struct dentry *hit;
	struct qstr q;
	unsigned int parent_flags = 0;
	int rc;

	printk(KERN_INFO
	       "[DLOOKUP_REPLAY] init parent=%px child_name=%s child_hash=0x%x\n",
	       parent, child_name, child_hash);

	if (!parent_addr || (parent_addr & 0x7UL)) {
		printk(KERN_ERR "[DLOOKUP_REPLAY] invalid parent_addr\n");
		return -EINVAL;
	}

	rc = safe_read((const void *)(parent_addr + offsetof(struct dentry, d_flags)),
		       &parent_flags, sizeof(parent_flags));
	if (rc) {
		printk(KERN_ERR
		       "[DLOOKUP_REPLAY] parent read failed rc=%d (stale pointer?)\n",
		       rc);
		return -EFAULT;
	}

	q.name = child_name;
	q.len = strnlen(child_name, sizeof(child_name));
	q.hash = child_hash;

	hit = d_lookup(parent, &q);
	if (!hit) {
		printk(KERN_INFO
		       "[DLOOKUP_REPLAY] d_lookup MISS parent=%px name=%s hash=0x%x\n",
		       parent, child_name, child_hash);
		return 0;
	}

	printk(KERN_INFO
	       "[DLOOKUP_REPLAY] d_lookup HIT dentry=%px inode=%px negative=%d unhashed=%d\n",
	       hit, hit->d_inode, d_is_negative(hit) ? 1 : 0, d_unhashed(hit) ? 1 : 0);
	dput(hit);
	return 0;
}

static void __exit dlookup_replay_exit(void)
{
	printk(KERN_INFO "[DLOOKUP_REPLAY] exit\n");
}

module_init(dlookup_replay_init);
module_exit(dlookup_replay_exit);
