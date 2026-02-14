#include <stdint.h>
#include <stdio.h>
#include <string.h>

typedef uint32_t u32;
typedef uint64_t u64;

#define GOLDEN_RATIO_64 0x61C8864680B583EBull

static inline u64 rol64(u64 word, unsigned int shift) {
  return (word << shift) | (word >> (64 - shift));
}

#define HASH_MIX(x, y, a)                                                      \
  (x ^= (a), y ^= x, x = rol64(x, 12), x += y, y = rol64(y, 45), y *= 9)

static inline u32 fold_hash(u64 x, u64 y) {
  y ^= x * GOLDEN_RATIO_64;
  y *= GOLDEN_RATIO_64;
  return (u32)(y >> 32);
}

int main() {
  u64 salt = 0xffff888893e6e180ULL;
  const char *name = "creation_proof_27977.txt";
  u32 target_hash = 0x1c1080d1;

  u64 x = 0, y = salt;
  u64 a;
  int len = strlen(name);
  const char *p = name;

  while (len >= 8) {
    memcpy(&a, p, 8);
    HASH_MIX(x, y, a);
    printf("Word: 0x%016llx -> x:0x%016llx y:0x%016llx\n", a, x, y);
    p += 8;
    len -= 8;
  }

  u32 calculated_hash = fold_hash(x, y);
  printf("Fold: 0x%08x\n", calculated_hash);
  return 0;
}
