#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>

/*
 * PREDICTION P3: THE FULL TABLE (EMFILE)
 * Axiom: The process has a finite array of file descriptors.
 */

int main() {
    int count = 0;
    while (1) {
        // Open /dev/null (it is harmless, but consumes a slot)
        int fd = open("/dev/null", O_RDONLY);
        
        if (fd < 0) {
            // WE PREDICT THIS WILL HAPPEN
            printf("--- FAILURE POINT REACHED ---\n");
            printf("Count: %d\n", count);
            printf("Errno: %d (%s)\n", errno, strerror(errno));
            
            if (errno == EMFILE) {
                printf("PREDICTION VERIFIED: EMFILE (Too many open files)\n");
                return 0; 
            } else {
                printf("PREDICTION FAILED: Unexpected error.\n");
                return 1;
            }
        }
        count++;
        // Do not close fd. That is the point.
    }
    return 0;
}
