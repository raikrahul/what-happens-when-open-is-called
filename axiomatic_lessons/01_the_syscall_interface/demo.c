#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <errno.h>
#include <string.h>

int main() {
    printf("STAGE 1: THE SYSCALL INTERFACE\n");
    printf("==============================\n\n");
    
    printf("A01: String is sequence of bytes ending in 0\n");
    char *filename = "test_file.txt";
    printf("   Filename: '%s' (length: %zu)\n", filename, strlen(filename));
    
    printf("\nA02: Registers are 64-bit storage locations\n");
    printf("   RAX = Syscall Number (2 for open)\n");
    printf("   RDI = Arg 1 (Filename pointer): %p\n", (void*)filename);
    printf("   RSI = Arg 2 (Flags): %d (O_RDWR)\n", O_RDWR);
    printf("   RDX = Arg 3 (Mode): %d\n", 0644);
    
    printf("\nA03: ABI dictates where arguments go\n");
    printf("   Testing direct syscall...\n");
    
    // Use direct syscall to show register mapping
    long result = syscall(SYS_open, filename, O_RDWR, 0644);
    if (result == -1) {
        printf("   Syscall failed: %s (errno=%d)\n", strerror(errno), errno);
    } else {
        printf("   Syscall success: fd=%ld\n", result);
        close(result);
    }
    
    printf("\nTesting wrapper function vs direct syscall:\n");
    
    // Wrapper function
    int fd_wrapper = open(filename, O_RDWR, 0644);
    printf("   open() wrapper returned: %d\n", fd_wrapper);
    
    if (fd_wrapper != -1) {
        close(fd_wrapper);
    }
    
    printf("\n=== SYSCALL INTERFACE COMPLETE ===\n");
    return 0;
}