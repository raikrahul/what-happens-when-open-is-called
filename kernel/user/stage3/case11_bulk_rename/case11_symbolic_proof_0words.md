ffff8887d8c29240 -> parent_addr ✓
child_50.txt -> target_child ✓
open("bulk_old/child_50.txt") -> lookup_1 ✓
lookup_1 -> hash:0x90463a29 parent:ffff8887d8c29240 ✓
rename("bulk_old", "bulk_new") -> operation ✓
open("bulk_new/child_50.txt") -> lookup_2 ✓
lookup_2 -> hash:0x90463a29 parent:ffff8887d8c29240 ✓
hash_1 == hash_2 ✓
parent_1 == parent_2 ✓
∴ Child_Dentry_Persistence -> ✓
∴ Parent_Name_Independence -> ✓
∴ Salt_Invariance_Proven -> ✓
