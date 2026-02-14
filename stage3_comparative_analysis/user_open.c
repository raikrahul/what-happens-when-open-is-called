/*
 * user_open.c
 * 
 * Opens an existing file (no O_CREAT).
 * This triggers the VFS lookup path including:
 * - lookup_fast() - cache lookup (HIT)
 * - __d_lookup_rcu() - RCU dentry lookup
 * - d_revalidate() - verify dentry
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>

#define PROGRAM_NAME "user_open"

int main(int argc, char *argv[]) {
    const char *filename;
    int fd;
    int flags = O_RDONLY;
    struct stat st;
    
    if (argc < 2) {
        filename = "test_file.txt";
    } else {
        filename = argv[1];
    }
    
    // Check if file exists
    if (stat(filename, &st) < 0) {
        printf("[%s] ERROR: File '%s' does not exist\n", PROGRAM_NAME, filename);
        printf("[%s] Run user_create first to create the file\n", PROGRAM_NAME);
        return 1;
    }
    
    printf("[%s] Opening existing file: %s\n", PROGRAM_NAME, filename);
    printf("[%s] Flags: O_RDONLY (0x%x)\n", PROGRAM_NAME, flags);
    printf("[%s] File size: %ld bytes\n", PROGRAM_NAME, (long)st.st_size);
    
    // This call triggers the lookup path in VFS (cache should hit)
    fd = open(filename, flags);
    
    if (fd < 0) {
        perror("open");
        printf("[%s] FAILED: errno=%d\n", PROGRAM_NAME, errno);
        return 1;
    }
    
    printf("[%s] SUCCESS: fd=%d\n", PROGRAM_NAME, fd);
    
    // Read some data
    char buffer[256];
    ssize_t n = read(fd, buffer, sizeof(buffer) - 1);
    
    if (n < 0) {
        perror("read");
    } else {
        buffer[n] = '\0';
        printf("[%s] Read %zd bytes: %s", PROGRAM_NAME, n, buffer);
    }
    
    close(fd);
    
    printf("[%s] File opened and closed successfully\n", PROGRAM_NAME);
    return 0;
}
