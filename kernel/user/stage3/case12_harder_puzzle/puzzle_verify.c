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

static u32 fold_hash(u64 x, u64 y) {
  y ^= x * GOLDEN_RATIO_64;
  y *= GOLDEN_RATIO_64;
  return (u32)(y >> 32);
}

u32 calculate(u64 salt, const char *name) {
  u64 x = 0, y = salt;
  u64 a = 0;
  int len = strlen(name);
  const char *p = name;

  // "puzzle_target.txt" = 17 bytes
  // Word 1 (8): "puzzle_t"
  // Word 2 (8): "arget.tx"
  // Word 3 (1): "t"

  memcpy(&a, p, 8);
  HASH_MIX(x, y, a);
  p += 8;

  memcpy(&a, p, 8);
  HASH_MIX(x, y, a);
  p += 8;

  a = 0;
  memcpy(&a, p, 1);
  x ^= a;

  return fold_hash(x, y);
}

int main() {
  printf("Target A: 0x%08x\n",
         calculate(0xffff8887bd88e780ULL, "puzzle_target.txt"));
  printf("Target B: 0x%08x\n",
         calculate(0xffff8887bd88e900ULL, "puzzle_target.txt"));
  return 0;
}
