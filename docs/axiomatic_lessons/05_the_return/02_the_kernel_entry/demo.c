#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

int main() {
    printf("STAGE 2: THE KERNEL ENTRY\n");
    printf("==========================\n\n");
    
    printf("B01: CPU Mode (Ring) determines privilege\n");
    printf("   Current mode: Ring 3 (User Space)\n");
    printf("   Target mode: Ring 0 (Kernel Space)\n");
    
    printf("\nB02: syscall instruction acts as a wormhole (Trap)\n");
    printf("   The 'syscall' instruction transitions from Ring 3 to Ring 0\n");
    printf("   MSR_LSTAR holds the kernel's landing address\n");
    
    printf("\nB03: Demonstration of the boundary crossing:\n");
    printf("   Before syscall: User space registers\n");
    printf("   After syscall: Kernel space execution\n");
    
    // Show the difference between user space and kernel space
    printf("\nTesting user space memory access:\n");
    void *user_addr = malloc(100);
    printf("   User space address: %p\n", user_addr);
    
    // Try to access kernel memory (this will fail)
    printf("   Attempting to access kernel memory...\n");
    void *kernel_addr = (void*)0xffffffff81000000; // Typical kernel address
    
    // This will cause a segmentation fault if we try to access it
    printf("   Kernel address: %p (cannot access from user space)\n", kernel_addr);
    
    printf("\nComparing system call overhead:\n");
    
    // Time a normal function call
    clock_t start = clock();
    for (int i = 0; i < 100000; i++) {
        // Dummy operation
        volatile int unused = i * 2;
    }
    clock_t end = clock();
    printf("   User space loop time: %f seconds\n", ((double)(end - start)) / CLOCKS_PER_SEC);
    
    // Time system calls
    start = clock();
    for (int i = 0; i < 10000; i++) {
        getpid(); // Simple system call
    }
    end = clock();
    printf("   System call loop time: %f seconds\n", ((double)(end - start)) / CLOCKS_PER_SEC);
    
    free(user_addr);
    
    printf("\n=== KERNEL ENTRY COMPLETE ===\n");
    return 0;
}