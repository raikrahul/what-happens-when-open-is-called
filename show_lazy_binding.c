#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>

int main() {
    // Use only a few functions
    printf("Hello\n");                    // Will be resolved
    malloc(100);                         // Will be resolved
    time(NULL);                          // Will be resolved
    
    // But glibc has thousands of functions we DON'T use:
    // cos(), sin(), tan(), fopen(), fclose(), getpid(), etc.
    // These will NOT be resolved (no cost!)
    
    return 0;
}
