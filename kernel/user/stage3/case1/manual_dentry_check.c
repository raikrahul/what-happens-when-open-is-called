/*
 * manual_dentry_check.c
 *
 * GOAL: Manually calculate the path resolution for "dirA/common/file.txt".
 * NO MAGIC. NO ASSUMPTIONS. RAW ARITHMETIC ONLY.
 *
 * DATA SOURCE:
 * - d_hash_shift = 11
 * - Total Buckets = 2097152 (2^21)
 *
 * SCENARIO:
 * - Starting at PWD: /home/r/case1 (Address: 0xffff8b41a44eeb40)
 * - Resolving: "dirA"
 *
 * COMPILE: gcc manual_dentry_check.c -o manual_dentry_check
 */

#include <stdint.h>
#include <stdio.h>
#include <string.h>

// -----------------------------------------------------------------------------
// REAL KERNEL STRUCTURES (Simplified for User Logic)
// -----------------------------------------------------------------------------

struct dentry {
  struct dentry *d_parent; // Pointer to father
  struct qstr {
    unsigned int hash;         // 32-bit Hash
    unsigned int len;          // Length of name
    const unsigned char *name; // Text name
  } d_name;
  int d_flags; // State flags (hashed/unhashed)
};

// -----------------------------------------------------------------------------
// THE MAIN PUZZLE
// -----------------------------------------------------------------------------

int main() {
  // 1. THE STARTING POINT (The Briefcase 'nd')
  // FILLED FROM TRACE: Address of 'case1' folder
  struct dentry *parent = (struct dentry *)0xffff8b41a44eeb40;

  // 2. THE TARGET COMPONENT (The String to Resolve)
  // FILLED FROM AXIOM: "dirA"
  const char *target_name = "dirA";
  unsigned int target_hash = 0x03e4bb97; // Validated from Trace
  unsigned int target_len = 4;

  // 3. THE GLOBAL SETTINGS (The Environment)
  // FILLED FROM AXIOM: d_hash_shift = 11
  unsigned int d_hash_shift = 11;
  // CALCULATE: 2^(32-11) = 2^21 = 2097152
  unsigned long total_buckets = 2097152;

  // 4. THE BUCKET CALCULATION (The Jump)
  // TODO: User calculates the Bucket ID manually
  // FORMULA: hash >> (32 - shift)
  unsigned int bucket_id = 0;

  // 5. THE CANDIDATES (The Bucket Content)
  // We have 3 candidates in this bucket. Which one is the winner?

  // CANDIDATE A: A file named "dirA" but inside 'dirB' (Sibling Collision)
  // Address of dirB = 0xffff8b410b51a480 (from trace)
  struct dentry candidate_A = {
      .d_parent = (struct dentry *)0xffff8b410b51a480, // WRONG PARENT
      .d_name = {.hash = 0x03e4bb97, .len = 4, .name = "dirA"},
      .d_flags = 0 // Valid
  };

  // CANDIDATE B: The REAL "dirA" inside our case1 folder
  // Address of case1 = 0xffff8b41a44eeb40 (from trace)
  struct dentry candidate_B = {
      .d_parent = (struct dentry *)0xffff8b41a44eeb40, // CORRECT PARENT
      .d_name = {.hash = 0x03e4bb97, .len = 4, .name = "dirA"},
      .d_flags = 0 // Valid
  };

  // CANDIDATE C: "common" inside dirA vs "common" inside dirB
  // TRACE SHOWS:
  // common/dirA hash = 0x0c0d6fc1
  // common/dirB hash = 0xe5443054
  // AXIOM: Different Parents cause Different Hashes (Salted).
  // BUT: Imagine a hash collision where 0x0c0d6fc1 == 0xe5443054.
  // Address of dirA = 0xffff8b4170e3ecc0
  // Address of dirB = 0xffff8b410b51a480

  struct dentry candidate_collision = {
      .d_parent = (struct dentry *)0xffff8b410b51a480, // Parent is dirB
      .d_name = {.hash = 0x0c0d6fc1,
                 .len = 6,
                 .name = "common"}, // Hash matches common/dirA?
      .d_flags = 0                  // Valid
  };

  // CANDIDATE D: A hash collision "diRA" inside our case1 folder
  // Address of case1 = 0xffff8b41a44eeb40 (from trace)
  struct dentry candidate_D = {
      .d_parent = (struct dentry *)0xffff8b41a44eeb40, // CORRECT PARENT
      .d_name = {.hash = 0x03e4bb97, .len = 4, .name = "diRA"}, // WRONG NAME
      .d_flags = 0                                              // Valid
  };

  // 6. THE COMPARISON LOGIC (The Execution)
  printf("--- STARTING LOOKUP ---\n");
  printf("Target Hash: 0x%08x\n", target_hash);
  printf("Details: Parent=%p, Name='%s'\n\n", parent, target_name);

  // TODO: User writes the IF statements to check Candidate A
  // HINT: Check Parent, then Hash, then Name

  // TODO: User writes the IF statements to check Candidate B

  // TODO: User writes the IF statements to check Candidate C

  return 0;
}
