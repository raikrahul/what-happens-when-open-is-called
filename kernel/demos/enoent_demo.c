#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

int main() {
    printf("ERROR DEMO: ENOENT (No such file or directory)\n");
    printf("===============================================\n\n");
    
    const char *nonexistent_files[] = {
        "/nonexistent/file/path.txt",
        "/tmp/missing_file_12345",
        "/does/not/exist/absolutely",
        NULL
    };
    
    for (int i = 0; nonexistent_files[i]; i++) {
        printf("Attempting to open: %s\n", nonexistent_files[i]);
        
        int fd = open(nonexistent_files[i], O_RDONLY);
        if (fd == -1) {
            printf("  Result: FAILED\n");
            printf("  errno: %d\n", errno);
            printf("  strerror: %s\n", strerror(errno));
            printf("  Meaning: File or directory does not exist\n\n");
        } else {
            printf("  Result: UNEXPECTED SUCCESS (fd=%d)\n", fd);
            close(fd);
        }
    }
    
    printf("ENOENT occurs when:\n");
    printf("- The file path does not exist\n");
    printf("- A component in the directory path does not exist\n");
    printf("- The file was deleted after the path was resolved\n");
    printf("- Permission to access a parent directory is denied\n");
    
    return 0;
}