#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <errno.h>
#include <string.h>
#include <sys/syscall.h>

int main() {
    printf("STAGE 5: THE RETURN\n");
    printf("====================\n\n");
    
    printf("E01: Return value goes in RAX\n");
    printf("E02: Negative values are Errors (errno)\n");
    printf("E03: sys_exit restores User Registers\n\n");
    
    // Demonstrate successful return
    printf("STEP 1: Successful open() call\n");
    int fd = open("/tmp/return_demo.txt", O_CREAT | O_RDWR, 0644);
    
    if (fd >= 0) {
        printf("   Success: fd = %d (non-negative)\n", fd);
        printf("   This positive value will be placed in RAX register\n");
        
        // Write something and close
        ssize_t written = write(fd, "test", 4);
        if (written == -1) {
            printf("   Write failed: %s\n", strerror(errno));
        }
        close(fd);
        unlink("/tmp/return_demo.txt");
    }
    
    // Demonstrate error returns
    printf("\nSTEP 2: Error return values\n");
    
    // ENOENT case
    fd = open("/nonexistent_file_12345", O_RDONLY);
    printf("   Open nonexistent file: fd = %d\n", fd);
    if (fd == -1) {
        printf("   Return value: -1 (indicates error)\n");
        printf("   errno: %d (%s)\n", errno, strerror(errno));
        printf("   Kernel sets RAX = -1, errno = %d\n", errno);
    }
    
    // EACCES case
    fd = open("/etc/shadow", O_RDONLY);
    printf("   Open restricted file: fd = %d\n", fd);
    if (fd == -1) {
        printf("   Return value: -1 (indicates error)\n");
        printf("   errno: %d (%s)\n", errno, strerror(errno));
        printf("   Kernel sets RAX = -1, errno = %d\n", errno);
    }
    
    // Demonstrate register usage with syscall
    printf("\nSTEP 3: Direct syscall demonstration\n");
    printf("   Using syscall() wrapper to see return value handling\n");
    
    // Successful syscall
    long result = syscall(SYS_open, "/tmp/return_demo2.txt", O_CREAT | O_RDWR, 0644);
    printf("   syscall(SYS_open) returned: %ld\n", result);
    
    if (result >= 0) {
        printf("   Success: kernel placed %ld in RAX\n", result);
        close(result);
        unlink("/tmp/return_demo2.txt");
    }
    
    // Failed syscall
    result = syscall(SYS_open, "/nonexistent_98765", O_RDONLY);
    printf("   syscall(SYS_open) for nonexistent file: %ld\n", result);
    if (result == -1) {
        printf("   Error: kernel placed -1 in RAX, errno = %d\n", errno);
    }
    
    // Demonstrate different error codes
    printf("\nSTEP 4: Common error codes\n");
    
    struct {
        char *description;
        char *path;
        int flags;
    } test_cases[] = {
        {"Nonexistent file", "/nonexistent_abc", O_RDONLY},
        {"Permission denied", "/root/.ssh", O_RDONLY},
        {"Invalid flag", "/tmp/test", 999999},
        {NULL, NULL, 0}
    };
    
    for (int i = 0; test_cases[i].description; i++) {
        fd = open(test_cases[i].path, test_cases[i].flags);
        if (fd == -1) {
            printf("   %s: errno %d (%s)\n", 
                   test_cases[i].description, errno, strerror(errno));
        }
    }
    
    printf("\nSTEP 5: Return path summary\n");
    printf("   Kernel -> RAX register -> User space return value\n");
    printf("   Success: RAX = fd (0, 1, 2, 3, ...)\n");
    printf("   Error:   RAX = -1, errno set\n");
    printf("   sys_exit restores user registers and switches back to Ring 3\n");
    
    printf("\n=== RETURN COMPLETE ===\n");
    return 0;
}