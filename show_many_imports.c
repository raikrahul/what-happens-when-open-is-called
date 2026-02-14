#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/stat.h>
#include <dirent.h>
#include <signal.h>
#include <pthread.h>

int main() {
    // Program imports MANY functions (see includes above)
    // But we only use 3:
    printf("Test\n");
    malloc(100);
    getpid();
    
    // NOT used: cos(), sin(), tan(), pthread_create(), opendir(), signal(), etc.
    // These will NOT be resolved (lazy binding saves time/memory)
    
    return 0;
}
