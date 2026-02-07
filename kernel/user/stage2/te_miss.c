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
    const char *n2 = "/tmp/t_e.txt";

    close(creat(n2, 0644));
    drop_caches_if_root();
    sleep(1);

    (void)open(n2, O_RDONLY);
    return 0;
}
