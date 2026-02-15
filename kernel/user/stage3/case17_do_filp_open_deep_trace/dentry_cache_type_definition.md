
# Type of First Argument (Dentry Cache)

Name: `dentry_cache`
Location: `fs/dcache.c:89`
Type: `struct kmem_cache *`

## Structure Definition (`mm/slab.h:234`)
```c
struct kmem_cache {
    struct kmem_cache_cpu __percpu *cpu_slab;
    slab_flags_t flags;
    unsigned long min_partial;
    unsigned int size;          /* Object size including metadata */
    unsigned int object_size;   /* Object size without metadata */
    struct reciprocal_value reciprocal_size;
    unsigned int offset;        /* Free pointer offset */
    unsigned int cpu_partial;
    unsigned int cpu_partial_slabs;
    struct kmem_cache_order_objects oo;
    struct kmem_cache_order_objects min;
    gfp_t allocflags;
    int refcount;
    void (*ctor)(void *object);
    unsigned int inuse;
    unsigned int align;
    unsigned int red_left_pad;
    const char *name;
    struct list_head list;      /* List of slab caches */
    struct kobject kobj;        /* For sysfs */
    unsigned long random;
    unsigned int remote_node_defrag_ratio;
    unsigned int *random_seq;
    struct kasan_cache kasan_info;
    unsigned int useroffset;
    unsigned int usersize;
    struct kmem_cache_node *node[MAX_NUMNODES];
};
```
