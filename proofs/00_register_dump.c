#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <sys/syscall.h>
#include <unistd.h>

/*
 * LESSON 01 PROOF: THE REGISTERS
 * We manually invoke the syscall using assembly to prove the ABI.
 */

int main() {
  const char *filename = "/dev/null";
  long ret;

  /*
   * AXIOM:
   * RAX = 2 (SYS_open)
   * RDI = filename
   * RSI = O_RDONLY (0)
   * RDX = 0
   */
  asm volatile("mov $2, %%rax\n\t"          // Sycall Number: open
               "mov %1, %%rdi\n\t"          // Arg 1: filename
               "mov $0, %%rsi\n\t"          // Arg 2: flags
               "mov $0, %%rdx\n\t"          // Arg 3: mode
               "syscall\n\t"                // THE TRAP
               "mov %%rax, %0"              // Capture return value
               : "=r"(ret)                  // Output
               : "r"(filename)              // Input
               : "rax", "rdi", "rsi", "rdx" // Clobbered registers
  );

  if (ret >= 0) {
    printf("SUCCESS: Syscall returned FD %ld\n", ret);
    close(ret);
  } else {
    printf("FAILURE: Syscall returned %ld\n", ret);
  }

  return 0;
}
