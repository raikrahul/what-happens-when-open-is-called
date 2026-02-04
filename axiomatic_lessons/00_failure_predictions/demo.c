#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

int main() {
    printf("STAGE 0: FAILURE PREDICTIONS\n");
    printf("============================\n\n");
    
    // F1: File Does Not Exist (ENOENT)
    printf("F1: Testing ENOENT - File Does Not Exist\n");
    int fd1 = open("/nonexistent/file/path", O_RDONLY);
    if (fd1 == -1) {
        printf("   Result: %s (errno=%d)\n", strerror(errno), errno);
    }
    
    // F2: Permission Denied (EACCES)
    printf("\nF2: Testing EACCES - Permission Denied\n");
    int fd2 = open("/etc/shadow", O_RDONLY);
    if (fd2 == -1) {
        printf("   Result: %s (errno=%d)\n", strerror(errno), errno);
    }
    
    // F3: File Descriptor Table Full (EMFILE)
    printf("\nF3: Testing EMFILE - File Descriptor Table Full\n");
    printf("   (This would require opening many files - demonstration skipped for safety)\n");
    
    // F4: Interrupted System Call (EINTR)
    printf("\nF4: Testing EINTR - Interrupted System Call\n");
    printf("   (Requires signal handling - demonstration skipped for simplicity)\n");
    
    printf("\n=== FAILURE PREDICTION COMPLETE ===\n");
    return 0;
}