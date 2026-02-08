#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

int main(void) {
    const char *path = "/tmp/alpha/beta/gamma/delta.txt";

    mkdir("/tmp/alpha", 0755);
    mkdir("/tmp/alpha/beta", 0755);
    mkdir("/tmp/alpha/beta/gamma", 0755);

    int fd = open(path, O_RDWR | O_CREAT, 0644);
    printf("fd=%d\n", fd);
    if (fd >= 0) close(fd);
    return 0;
}
