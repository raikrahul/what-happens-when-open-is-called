#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/time.h>
#include <sys/resource.h>

int main() {
    printf("ERROR DEMO: EMFILE (Too many open files)\n");
    printf("========================================\n\n");
    
    printf("Testing file descriptor limits...\n");
    
    // Get current resource limits
    struct rlimit rl;
    if (getrlimit(RLIMIT_NOFILE, &rl) == 0) {
        printf("Current file descriptor limits:\n");
        printf("  Soft limit: %lu\n", rl.rlim_cur);
        printf("  Hard limit: %lu\n", rl.rlim_max);
        printf("\n");
    }
    
    // Count currently open file descriptors
    int initial_count = 0;
    for (int i = 0; i < 1024; i++) {
        char fd_path[32];
        snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", i);
        if (access(fd_path, F_OK) == 0) {
            initial_count++;
        }
    }
    printf("Currently open file descriptors: %d\n", initial_count);
    
    // Try to open many files to demonstrate EMFILE
    printf("Opening files until limit is reached...\n");
    
    int fds[1000];
    int opened = 0;
    
    // Open files until we hit the limit
    for (int i = 0; i < 1000; i++) {
        fds[i] = open("/dev/null", O_RDONLY);
        if (fds[i] == -1) {
            printf("Failed to open file %d: %s (errno=%d)\n", 
                   i, strerror(errno), errno);
            break;
        }
        opened++;
        
        if (i % 50 == 49) {
            printf("  Opened %d files...\n", i + 1);
        }
    }
    
    printf("Successfully opened %d files\n", opened);
    
    // Try to open one more - this should fail with EMFILE
    printf("Attempting to open one more file (should fail)...\n");
    int extra_fd = open("/dev/null", O_RDONLY);
    if (extra_fd == -1) {
        printf("Expected failure:\n");
        printf("  errno: %d\n", errno);
        printf("  strerror: %s\n", strerror(errno));
        
        if (errno == EMFILE) {
            printf("  ✓ Got EMFILE as expected\n");
        } else {
            printf("  ✗ Got unexpected error code\n");
        }
    } else {
        printf("Unexpected success - file descriptor limit not reached\n");
        close(extra_fd);
    }
    
    // Clean up
    printf("\nCleaning up opened files...\n");
    for (int i = 0; i < opened; i++) {
        close(fds[i]);
    }
    printf("Closed %d files\n", opened);
    
    printf("\nEMFILE occurs when:\n");
    printf("- Process has reached its file descriptor limit\n");
    printf("- Check with 'ulimit -n' or getrlimit(RLIMIT_NOFILE)\n");
    printf("- Default is typically 1024 or higher\n");
    printf("- System-wide limit is /proc/sys/fs/file-max\n");
    
    return 0;
}