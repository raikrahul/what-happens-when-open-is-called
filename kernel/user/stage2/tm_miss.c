#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

static void drop_caches_if_root(void) {
    int fd;
    if (geteuid() != 0)
        return;
    sync();
    fd = open("/proc/sys/vm/drop_caches", O_WRONLY);
    if (fd >= 0) {
        ssize_t w = write(fd, "2\n", 2);
        (void)w;
        close(fd);
    }
}

int main(void) {
    const char *n3 = "/tmp/t_m.txt";

    drop_caches_if_root();
    sleep(1);

    int fd1 = open(n3, O_RDONLY);
    printf("tm_miss first open fd=%d\n", fd1);
    fflush(stdout);
    if (fd1 >= 0)
        close(fd1);

    int fd2 = open(n3, O_RDONLY);
    printf("tm_miss second open fd=%d\n", fd2);
    fflush(stdout);
    if (fd2 >= 0)
        close(fd2);
    return 0;
}
