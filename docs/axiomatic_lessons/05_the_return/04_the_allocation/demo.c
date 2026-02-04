#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <errno.h>
#include <string.h>

int main() {
    printf("STAGE 4: THE ALLOCATION\n");
    printf("=======================\n\n");
    
    printf("D01: Everything in Kernel is a Struct (Block of Memory)\n");
    printf("D02: struct file holds the Position (cursor)\n");
    printf("D03: Inode holds the Content\n");
    printf("D04: fd is just an index into an array\n\n");
    
    // Demonstrate file descriptor allocation
    printf("STEP 1: File descriptor allocation\n");
    printf("   Current process PID: %d\n", getpid());
    
    // Open a file and get its descriptor
    int fd = open("/tmp/demo_file.txt", O_CREAT | O_RDWR, 0644);
    if (fd == -1) {
        printf("   Failed to create demo file: %s\n", strerror(errno));
        return 1;
    }
    
    printf("   Opened file with fd: %d\n", fd);
    
    // Write some content
    const char *content = "Hello, this is a test file for demonstrating struct file allocation.";
    ssize_t written = write(fd, content, strlen(content));
    if (written == -1) {
        printf("   Write failed: %s\n", strerror(errno));
    } else {
        printf("   Wrote %zd bytes to file\n", written);
    }
    
    // Show file descriptor information from /proc
    printf("\nSTEP 2: File descriptor information\n");
    char fd_path[256];
    snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", fd);
    
    struct stat fd_stat;
    if (stat(fd_path, &fd_stat) == 0) {
        printf("   FD %d points to: %s\n", fd, fd_path);
        printf("   File inode: %ld\n", fd_stat.st_ino);
        printf("   File size: %ld bytes\n", fd_stat.st_size);
        printf("   File mode: %o\n", fd_stat.st_mode);
    }
    
    // Demonstrate file position (cursor)
    printf("\nSTEP 3: File position (struct file->f_pos)\n");
    off_t pos = lseek(fd, 0, SEEK_CUR);
    printf("   Current file position: %ld\n", pos);
    
    // Reset to beginning
    lseek(fd, 0, SEEK_SET);
    printf("   After SEEK_SET: %ld\n", lseek(fd, 0, SEEK_CUR));
    
    // Read some data to advance position
    char buffer[20];
    ssize_t bytes_read = read(fd, buffer, sizeof(buffer) - 1);
    if (bytes_read != -1) {
        buffer[bytes_read] = '\0';
        printf("   Read %zd bytes: '%s'\n", bytes_read, buffer);
        printf("   New position: %ld\n", lseek(fd, 0, SEEK_CUR));
    }
    
    // Show file descriptor table usage
    printf("\nSTEP 4: File descriptor table usage\n");
    printf("   Open file descriptors:\n");
    for (int i = 0; i < 10; i++) {
        snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", i);
        if (access(fd_path, F_OK) == 0) {
            printf("     fd %d: exists\n", i);
        }
    }
    
    // Clean up
    close(fd);
    unlink("/tmp/demo_file.txt");
    
    printf("\n=== ALLOCATION COMPLETE ===\n");
    return 0;
}