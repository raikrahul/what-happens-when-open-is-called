/*
 * user_create.c
 * 
 * Creates a file using O_CREAT flag.
 * This triggers the VFS creation path including:
 * - d_alloc() - allocate new dentry
 * - vfs_create() - filesystem create operation
 * - d_instantiate() - link dentry to inode
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>

#define PROGRAM_NAME "user_create"

int main(int argc, char *argv[]) {
    const char *filename;
    int fd;
    mode_t mode = 0644;  // rw-r--r--
    int flags = O_CREAT | O_WRONLY | O_TRUNC;
    
    if (argc < 2) {
        filename = "test_file.txt";
    } else {
        filename = argv[1];
    }
    
    // Remove file if it exists to ensure creation path
    unlink(filename);
    
    printf("[%s] Creating file: %s\n", PROGRAM_NAME, filename);
    printf("[%s] Flags: O_CREAT | O_WRONLY | O_TRUNC (0x%x)\n", PROGRAM_NAME, flags);
    
    // This call triggers the full creation path in VFS
    fd = open(filename, flags, mode);
    
    if (fd < 0) {
        perror("open");
        printf("[%s] FAILED: errno=%d\n", PROGRAM_NAME, errno);
        return 1;
    }
    
    printf("[%s] SUCCESS: fd=%d\n", PROGRAM_NAME, fd);
    
    // Write some data
    const char *data = "Test data created by user_create\n";
    ssize_t written = write(fd, data, strlen(data));
    
    if (written < 0) {
        perror("write");
    } else {
        printf("[%s] Wrote %zd bytes\n", PROGRAM_NAME, written);
    }
    
    close(fd);
    
    printf("[%s] File created and closed successfully\n", PROGRAM_NAME);
    return 0;
}
