#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

int main() {
    printf("ERROR DEMO: EACCES (Permission denied)\n");
    printf("======================================\n\n");
    
    // Test 1: Try to read a file we don't have permission for
    printf("Test 1: Reading restricted file\n");
    int fd = open("/etc/shadow", O_RDONLY);
    if (fd == -1) {
        printf("  Result: FAILED (expected)\n");
        printf("  errno: %d\n", errno);
        printf("  strerror: %s\n", strerror(errno));
        printf("  Meaning: Permission denied to read file\n\n");
    } else {
        printf("  Result: UNEXPECTED SUCCESS (fd=%d)\n", fd);
        close(fd);
    }
    
    // Test 2: Try to write to a read-only location
    printf("Test 2: Writing to read-only location\n");
    fd = open("/etc/hosts", O_WRONLY);
    if (fd == -1) {
        printf("  Result: FAILED (expected)\n");
        printf("  errno: %d\n", errno);
        printf("  strerror: %s\n", strerror(errno));
        printf("  Meaning: Permission denied to write file\n\n");
    } else {
        printf("  Result: UNEXPECTED SUCCESS (fd=%d)\n", fd);
        close(fd);
    }
    
    // Test 3: Try to access a directory without execute permission
    printf("Test 3: Creating a file without directory permission\n");
    fd = open("/root/test_file", O_CREAT | O_WRONLY, 0644);
    if (fd == -1) {
        printf("  Result: FAILED (expected)\n");
        printf("  errno: %d\n", errno);
        printf("  strerror: %s\n", strerror(errno));
        printf("  Meaning: Permission denied to create file in directory\n\n");
    } else {
        printf("  Result: UNEXPECTED SUCCESS (fd=%d)\n", fd);
        close(fd);
        unlink("/root/test_file");
    }
    
    printf("EACCES occurs when:\n");
    printf("- File exists but user lacks read permission (O_RDONLY)\n");
    printf("- File exists but user lacks write permission (O_WRONLY)\n");
    printf("- Directory lacks execute permission for path traversal\n");
    printf("- Directory lacks write permission for file creation\n");
    printf("- File exists but user lacks search permission\n");
    
    return 0;
}