#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>

int main(void)
{
    const char *path = "./case1_intensity_probe_target.txt";
    int fd = open(path, O_RDONLY);
    if (fd >= 0) close(fd);
    printf("[case1] addon open rc=%d errno=%d\n", fd, errno);
    return 0;
}
