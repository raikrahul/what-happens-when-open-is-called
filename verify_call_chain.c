#include <fcntl.h>
#include <unistd.h>

int main() {
    // This will call open() which goes through PLT/GOT
    int fd = open("/tmp/test.txt", O_CREAT | O_WRONLY, 0644);
    close(fd);
    return 0;
}
