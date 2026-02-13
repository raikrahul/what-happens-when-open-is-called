/*
 * dcache_loop_analysis.c
 *
 * TASK: 01. Break Down the Code just like the following example with even more
 * nested tricks and details
 *
 * 01. HOMEWORK WORKFLOW: YOU fill boilerplate, I will fill puzzle/logical
 * parts. 02. Code MUST COMPILE ON ITS OWN with all boilerplate in place. 03.
 * Leave TODO blocks for: edge cases, core logic, tricky conditions, clever
 * tricks.
 *
 * Compiles with: gcc -O2 dcache_loop_analysis.c -o dcache_loop_analysis
 */

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

// -----------------------------------------------------------------------------
// [MOCK] Kernel Struct Definitions (Axiomatic Layout)
// -----------------------------------------------------------------------------

// struct seqcount: Just a counter.
// Size: 4 bytes.
typedef struct {
  unsigned sequence; // sequence = 42 → 0x2A = 101010 (Even=Stable)
} seqcount_t;

// struct qstr: "Quick String"
// Size: 16 bytes (64-bit system)
struct qstr {
  union {
    struct {
      uint32_t hash; // hash = 0x78a2c1d2
      uint32_t len;  // len = 4
    };
    uint64_t hash_len; // hash_len = 0x0000000478A2C1D2
  };
  const unsigned char *name; // pointer to "BETA"
};

// struct hlist_bl_node: Bit-Locked List Node
// Size: 16 bytes
struct hlist_bl_node {
  struct hlist_bl_node *next; // next = 0xffff888000005000 (GAMMA)
  struct hlist_bl_node *
      *pprev; // pprev = &head->first (with bit 0 set if locked)
};

// struct dentry: The Directory Entry (Simplified for Analysis)
// Base Address: 0xffff888000004000
struct dentry {
  unsigned int d_flags;        // Offset 0x00
  seqcount_t d_seq;            // Offset 0x04 → 42
  struct hlist_bl_node d_hash; // Offset 0x08 → 16 bytes
  struct dentry *d_parent;     // Offset 0x18 → 0xffff888000003000 (ALPHA)
  struct qstr d_name;          // Offset 0x20 → 16 bytes
  struct inode *d_inode;       // Offset 0x30
  unsigned char d_iname[32];   // Offset 0x38 → Inline name storage
};

// struct hlist_bl_head: The Bucket Head
struct hlist_bl_head {
  struct hlist_bl_node *first; // first = 0xffff888000004000 (BETA) | LOCK_BIT
};

// -----------------------------------------------------------------------------
// [MOCK] Kernel Macros & Functions (Axiomatic Logic)
// -----------------------------------------------------------------------------

#define LIST_BL_LOCKMASK 1UL

// READ_ONCE: Volatile read to prevent compiler reordering
#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))

static inline struct hlist_bl_node *
hlist_bl_first_rcu(struct hlist_bl_head *head) {
  // ptr = head->first (with potential lock bit)
  // ptr = 0xffff888000004001 (Locked)
  // mask = ~1UL = 0xfffffffffffffffe
  // result = 0xffff888000004000 (Clean Pointer)
  return (struct hlist_bl_node *)((unsigned long)READ_ONCE(head->first) &
                                  ~LIST_BL_LOCKMASK);
}

static inline unsigned raw_seqcount_begin(const seqcount_t *s) {
  // Reads sequence count.
  // If usage is odd (writer active), reader proceeds optimistically.
  // Barrier smp_rmb() implied here (simulated).
  return READ_ONCE(s->sequence);
}

static inline int d_unhashed(const struct dentry *dentry) {
  // If d_hash.pprev is NULL, dentry is dead/unhashed.
  return (dentry->d_hash.pprev == NULL);
}

static inline int dentry_cmp(const struct dentry *dentry, const char *str,
                             unsigned int len) {
  // Compare bytes.
  return memcmp(dentry->d_name.name, str, len);
}

// -----------------------------------------------------------------------------
// [ANALYSIS] The Loop Logic
// -----------------------------------------------------------------------------

struct dentry *__d_lookup_rcu_mock(const struct dentry *parent,
                                   const struct qstr *name,
                                   struct hlist_bl_head *b) {
  struct hlist_bl_node *node;
  struct dentry *dentry;
  unsigned seq;

  // TODO: USER, CALCULATE THE STARTING POINTER
  // head->first = 0xffff888000004000 | 0 = 0xffff888000004000
  // node = 0xffff888000004000
  for (node = hlist_bl_first_rcu(b); node;
       node = node->next) { // node moves to GAMMA (0xffff888000005000)

    // Calculate Dentry Address from Node
    // container_of(node, struct dentry, d_hash)
    // node addr = 0xffff888000004008 (address of d_hash field inside struct)
    // offset    = 0x08
    // dentry    = 0xffff888000004000
    dentry = (struct dentry *)((char *)node - 8);

    // 1. Optimistic Lock Check
    // seq = dentry->d_seq (Offset 0x04)
    // Val = 42 → Even → OK
    // Val = 43 → Odd → Racing (Caller will retry, we ignore)
    seq = raw_seqcount_begin(&dentry->d_seq);

    // 2. Parent Check (Fast 64-bit Integer Compare)
    // dentry->d_parent (Offset 0x18) vs parent (Arg)
    // 0xffff888000003000 == 0xffff888000003000 → Match ✓
    // If fail: continue (Next node in bucket)
    if (dentry->d_parent != parent)
      continue;

    // 3. Unhashed Check
    // dentry->d_hash.pprev (Offset 0x10)
    // If NULL → Zombie dentry → continue
    if (d_unhashed(dentry))
      continue;

    // 4. Hash & Length Check (Fast 64-bit Integer Compare)
    // dentry->d_name.hash_len (Offset 0x20)
    // name->hash_len (Arg)
    // 0x0000000478A2C1D2 == 0x0000000478A2C1D2 → Match ✓
    if (dentry->d_name.hash_len != name->hash_len)
      continue;

    // 5. String Compare (Slow Memory Scan)
    // dentry->d_name.name vs name->name
    // "BETA" vs "BETA" → 0 → Match ✓
    if (dentry_cmp(dentry, name->name, name->len) != 0)
      continue;

    // Found!
    // Return seq so caller can verify: "Did seq change from 42 to 43 while I
    // was reading?"
    return dentry;
  }

  return NULL;
}

// -----------------------------------------------------------------------------
// [TEST HARNESS]
// -----------------------------------------------------------------------------
int main() {
  // Boilerplate setup of real mock data
  struct dentry alpha = {0}; // Parent
  struct dentry beta = {0};  // Target
  struct qstr name = {
      .hash = 0x78a2c1d2, .len = 4, .name = (unsigned char *)"BETA"};

  // Setup Layout (Simulation of 0xffff888000004000)
  beta.d_parent = &alpha;
  beta.d_name = name;
  beta.d_seq.sequence = 42;
  beta.d_hash.next = NULL;
  beta.d_hash.pprev = (struct hlist_bl_node **)&alpha; // Just non-NULL

  struct hlist_bl_head bucket;
  bucket.first = &beta.d_hash; // Point to OFFSET 0x08

  printf("Starting Lookup...\n");
  __d_lookup_rcu_mock(&alpha, &name, &bucket);
  printf("Done.\n");

  return 0;
}
