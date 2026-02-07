#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

static void close_if_open(int *fd) {
    if (*fd >= 0) {
        close(*fd);
        *fd = -1;
    }
}

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
    const char *n1 = "l_e.txt";
    const char *n2 = "/tmp/t_e.txt";
    int f1 = -1, f2 = -1;

    close(creat(n1, 0644));
    close(creat(n2, 0644));

    f1 = open(n1, O_RDONLY);
    f2 = open(n2, O_RDONLY);
    close_if_open(&f1);
    close_if_open(&f2);

    drop_caches_if_root();
    sleep(1);
    return 0;
}
