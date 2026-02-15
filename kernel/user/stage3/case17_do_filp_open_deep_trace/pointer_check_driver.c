#include <linux/dcache.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/uaccess.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("rahultest");
MODULE_DESCRIPTION("Case17 pointer check driver (safe nofault reads + sanity)");

static unsigned long target_dentry_addr = 0xffff89900a337480UL;
module_param(target_dentry_addr, ulong, 0644);
MODULE_PARM_DESC(target_dentry_addr, "Hardcoded dentry pointer to inspect");

static int safe_read(const void *src, void *dst, size_t n)
{
	return copy_from_kernel_nofault(dst, src, n);
}

static int __init pointer_check_init(void)
{
	int rc;
	unsigned long qword0 = 0;
	unsigned int d_flags = 0;
	int d_count = 0;
	struct super_block *d_sb = NULL;
	struct dentry *d_parent = NULL;
	struct inode *d_inode = NULL;
	unsigned int name_len = 0;
	unsigned int name_hash = 0;
	const unsigned char *name_ptr = NULL;
	char name_buf[64];
	unsigned int parent_name_len = 0;
	const unsigned char *parent_name_ptr = NULL;
	char parent_name_buf[64];
	size_t ncopy = 0;
	size_t parent_ncopy = 0;

	memset(name_buf, 0, sizeof(name_buf));
	memset(parent_name_buf, 0, sizeof(parent_name_buf));

	printk(KERN_INFO "[PTRCHK] init target_dentry_addr=%px\n",
	       (void *)target_dentry_addr);
	if (!target_dentry_addr || (target_dentry_addr & 0x7UL)) {
		printk(KERN_ERR "[PTRCHK] invalid address: null or unaligned\n");
		return -EINVAL;
	}

	rc = safe_read((const void *)target_dentry_addr, &qword0, sizeof(qword0));
	printk(KERN_INFO "[PTRCHK] read qword0 rc=%d value=0x%lx\n", rc, qword0);

	rc = safe_read((const void *)(target_dentry_addr +
				      offsetof(struct dentry, d_flags)),
		       &d_flags, sizeof(d_flags));
	printk(KERN_INFO "[PTRCHK] read d_flags rc=%d value=0x%x\n", rc, d_flags);

	rc = safe_read((const void *)(target_dentry_addr +
				      offsetof(struct dentry, d_lockref) +
				      offsetof(struct lockref, count)),
		       &d_count, sizeof(d_count));
	printk(KERN_INFO "[PTRCHK] read d_lockref.count rc=%d value=%d\n", rc,
	       d_count);

	rc = safe_read((const void *)(target_dentry_addr +
				      offsetof(struct dentry, d_sb)),
		       &d_sb, sizeof(d_sb));
	printk(KERN_INFO "[PTRCHK] read d_sb rc=%d value=%px\n", rc, d_sb);

	rc = safe_read((const void *)(target_dentry_addr +
				      offsetof(struct dentry, d_parent)),
		       &d_parent, sizeof(d_parent));
	printk(KERN_INFO "[PTRCHK] read d_parent rc=%d value=%px self_eq=%d\n",
	       rc, d_parent, d_parent == (struct dentry *)target_dentry_addr ? 1 : 0);
	if (rc) {
		printk(KERN_WARNING
		       "[PTRCHK] base dentry unreadable; likely stale/freed pointer\n");
		return 0;
	}

	rc = safe_read((const void *)(target_dentry_addr +
				      offsetof(struct dentry, d_inode)),
		       &d_inode, sizeof(d_inode));
	printk(KERN_INFO "[PTRCHK] read d_inode rc=%d value=%px\n", rc, d_inode);

	rc = safe_read((const void *)(target_dentry_addr +
				      offsetof(struct dentry, d_name) +
				      offsetof(struct qstr, len)),
		       &name_len, sizeof(name_len));
	printk(KERN_INFO "[PTRCHK] read d_name.len rc=%d value=%u\n", rc, name_len);

	rc = safe_read((const void *)(target_dentry_addr +
				      offsetof(struct dentry, d_name) +
				      offsetof(struct qstr, hash)),
		       &name_hash, sizeof(name_hash));
	printk(KERN_INFO "[PTRCHK] read d_name.hash rc=%d value=0x%x\n", rc,
	       name_hash);

	rc = safe_read((const void *)(target_dentry_addr +
				      offsetof(struct dentry, d_name) +
				      offsetof(struct qstr, name)),
		       &name_ptr, sizeof(name_ptr));
	printk(KERN_INFO "[PTRCHK] read d_name.name rc=%d value=%px\n", rc, name_ptr);

	if (!rc && name_ptr && name_len > 0 && name_len <= 4096) {
		ncopy = name_len;
		if (ncopy > sizeof(name_buf) - 1)
			ncopy = sizeof(name_buf) - 1;
		rc = safe_read(name_ptr, name_buf, ncopy);
		printk(KERN_INFO
		       "[PTRCHK] read name bytes rc=%d ncopy=%zu text=%s\n",
		       rc, ncopy, !rc ? name_buf : "<nofault-read-failed>");
	} else if (name_len > 4096) {
		printk(KERN_WARNING
		       "[PTRCHK] skip name bytes: suspicious name_len=%u\n",
		       name_len);
	}

	if (d_parent && d_parent != (struct dentry *)target_dentry_addr) {
		rc = safe_read((const void *)((unsigned long)d_parent +
					      offsetof(struct dentry, d_name) +
					      offsetof(struct qstr, len)),
			       &parent_name_len, sizeof(parent_name_len));
		printk(KERN_INFO
		       "[PTRCHK] parent d_name.len rc=%d value=%u\n",
		       rc, parent_name_len);

		rc = safe_read((const void *)((unsigned long)d_parent +
					      offsetof(struct dentry, d_name) +
					      offsetof(struct qstr, name)),
			       &parent_name_ptr, sizeof(parent_name_ptr));
		printk(KERN_INFO
		       "[PTRCHK] parent d_name.name rc=%d value=%px\n",
		       rc, parent_name_ptr);

		if (!rc && parent_name_ptr && parent_name_len > 0 &&
		    parent_name_len <= 4096) {
			parent_ncopy = parent_name_len;
			if (parent_ncopy > sizeof(parent_name_buf) - 1)
				parent_ncopy = sizeof(parent_name_buf) - 1;
			rc = safe_read(parent_name_ptr, parent_name_buf,
				       parent_ncopy);
			printk(KERN_INFO
			       "[PTRCHK] parent name bytes rc=%d ncopy=%zu text=%s\n",
			       rc, parent_ncopy,
			       !rc ? parent_name_buf : "<nofault-read-failed>");
		}
	}

	return 0;
}

static void __exit pointer_check_exit(void)
{
	printk(KERN_INFO "[PTRCHK] exit\n");
}

module_init(pointer_check_init);
module_exit(pointer_check_exit);
