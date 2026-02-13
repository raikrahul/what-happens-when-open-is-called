/*
 * test_vfs_trace.c - Simple program to test vfs_depth_probe module
 * 
 * Run with the module loaded to see VFS path walking in action:
 *   sudo insmod vfs_depth_probe.ko target_comm="test_vfs_trace"
 *   ./test_vfs_trace
 *   sudo dmesg | grep -E "\[LPW\]|\[WC\]"
 */

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char *argv[])
{
    int fd;
    const char *test_paths[] = {
        "/etc/passwd",
        "/usr/bin/ls",
        "/tmp/test_vfs_trace.txt",
        NULL
    };
    
    printf("Process name: %s (PID: %d)\n", argv[0], getpid());
    printf("Testing VFS depth tracing...\n\n");
    
    for (int i = 0; test_paths[i] != NULL; i++) {
        printf("Opening: %s\n", test_paths[i]);
        
        fd = open(test_paths[i], O_RDONLY);
        if (fd < 0) {
            perror("open");
        } else {
            printf("  -> Success (fd=%d)\n", fd);
            close(fd);
        }
    }
    
    // Test relative path
    printf("\nOpening relative path: ../some_relative_file.txt\n");
    fd = open("../some_relative_file.txt", O_RDONLY);
    if (fd < 0) {
        perror("open");
    } else {
        printf("  -> Success (fd=%d)\n", fd);
        close(fd);
    }
    
    printf("\nDone! Check dmesg for VFS trace output.\n");
    return 0;
}
