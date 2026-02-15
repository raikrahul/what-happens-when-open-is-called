The macro kmem_cache_alloc_lru expands to alloc_hooks wrapping kmem_cache_alloc_lru_noprof.
kmem_cache_alloc_lru_noprof calls slab_alloc_node with arguments s, lru, gfp, NUMA_NO_NODE, _RET_IP_, and s->object_size.
slab_alloc_node calls slab_pre_alloc_hook with s and gfp, returning s.
slab_alloc_node calls kfence_alloc with s, s->object_size, and gfp.
kfence_alloc returns 0.
slab_alloc_node calls __slab_alloc_node with s, gfp, NUMA_NO_NODE, 0, and s->object_size.
__slab_alloc_node returns a valid object pointer obj.
slab_alloc_node calls slab_post_alloc_hook with s, lru, gfp, 1, address of obj, 0, and s->object_size.
slab_post_alloc_hook calls memcg_kmem_online.
memcg_kmem_online returns true.
slab_post_alloc_hook calls memcg_slab_post_alloc_hook with s, lru, gfp, 1, and address of obj.
memcg_slab_post_alloc_hook calls current_obj_cgroup.
current_obj_cgroup returns a valid objcg pointer.
lru is not NULL.
memcg_slab_post_alloc_hook calls memcg_list_lru_alloc with objcg->memcg, lru, and gfp.
memcg_list_lru_alloc calls list_lru_memcg_aware with lru.
list_lru_memcg_aware returns true.
memcg_list_lru_alloc calls memcg_list_lru_allocated with objcg->memcg and lru.
memcg_list_lru_allocated returns false.
memcg_list_lru_alloc calls memcg_init_list_lru_one with lru and gfp.
memcg_init_list_lru_one allocates and returns a new mlru structure.
memcg_list_lru_alloc stores mlru in lru->xa at index objcg->memcg->css.id.
memcg_slab_post_alloc_hook calls virt_to_slab with obj.
virt_to_slab returns the slab structure.
memcg_slab_post_alloc_hook calls alloc_slab_obj_exts with slab, s, gfp, and false.
memcg_slab_post_alloc_hook calls obj_cgroup_charge_account with objcg, gfp, obj_full_size(s), slab_pgdat(slab), and cache statistics index.
obj_cgroup_charge_account returns 0 (success).
memcg_slab_post_alloc_hook calculates the offset using obj_to_index for s, slab, and obj.
memcg_slab_post_alloc_hook stores objcg in slab_obj_exts(slab)[offset].objcg.
memcg_slab_post_alloc_hook returns true.
slab_post_alloc_hook returns.
slab_alloc_node returns obj.
kmem_cache_alloc_lru_noprof returns obj.
