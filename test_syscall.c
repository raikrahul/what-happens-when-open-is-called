#include <fcntl.h>
#include <unistd.h>

int main() {
    int fd = open("/tmp/test.txt", O_CREAT | O_WRONLY, 0644);
    close(fd);
    return 0;
}
