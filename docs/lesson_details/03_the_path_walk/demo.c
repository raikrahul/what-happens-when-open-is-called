#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <errno.h>
#include <string.h>
#include <dirent.h>
#include <time.h>

int main() {
    printf("STAGE 3: THE PATH WALK\n");
    printf("======================\n\n");
    
    printf("C01: A Directory is a file mapping Name -> Inode\n");
    printf("C02: Walking = Reading Dir -> Finding Name -> Reading Next Inode\n");
    printf("C03: Optimization = Dentry Cache (RAM)\n\n");
    
    // Demonstrate path walking step by step
    const char *target_path = "/etc/passwd";
    printf("Walking path: %s\n\n", target_path);
    
    // Start from root
    printf("STEP 1: Root directory (/)\n");
    struct stat root_stat;
    if (stat("/", &root_stat) == 0) {
        printf("   Root inode: %ld\n", root_stat.st_ino);
        printf("   Root mode: %o\n", root_stat.st_mode);
    }
    
    printf("\nSTEP 2: Navigate to /etc\n");
    struct stat etc_stat;
    if (stat("/etc", &etc_stat) == 0) {
        printf("   /etc inode: %ld\n", etc_stat.st_ino);
        printf("   /etc mode: %o\n", etc_stat.st_mode);
        
        // Show directory contents
        DIR *etc_dir = opendir("/etc");
        if (etc_dir) {
            printf("   Sample entries in /etc:\n");
            struct dirent *entry;
            int count = 0;
            while ((entry = readdir(etc_dir)) != NULL && count < 5) {
                printf("     %s -> inode %ld\n", entry->d_name, entry->d_ino);
                count++;
            }
            closedir(etc_dir);
        }
    }
    
    printf("\nSTEP 3: Find /etc/passwd\n");
    struct stat passwd_stat;
    if (stat("/etc/passwd", &passwd_stat) == 0) {
        printf("   /etc/passwd inode: %ld\n", passwd_stat.st_ino);
        printf("   /etc/passwd mode: %o\n", passwd_stat.st_mode);
        printf("   /etc/passwd size: %ld bytes\n", passwd_stat.st_size);
    }
    
    printf("\nSTEP 4: Demonstrate cache effect\n");
    printf("   First stat() call (cache miss): ");
    clock_t start = clock();
    stat("/etc/passwd", &passwd_stat);
    clock_t end = clock();
    printf("%f ms\n", ((double)(end - start)) * 1000 / CLOCKS_PER_SEC);
    
    printf("   Second stat() call (cache hit): ");
    start = clock();
    stat("/etc/passwd", &passwd_stat);
    end = clock();
    printf("%f ms\n", ((double)(end - start)) * 1000 / CLOCKS_PER_SEC);
    
    printf("\nSTEP 5: Error cases\n");
    int fd = open("/nonexistent/path/file", O_RDONLY);
    if (fd == -1) {
        printf("   Nonexistent path: %s (errno=%d)\n", strerror(errno), errno);
    }
    
    printf("\n=== PATH WALK COMPLETE ===\n");
    return 0;
}