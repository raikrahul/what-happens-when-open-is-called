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

    unlink(n1);
    unlink(n2);
    return 0;
}
