#include <fcntl.h>
#include <unistd.h>

int main() {
  int fd = open("somefile", O_RDWR);
  int fd2 = open("otherfile", O_RDWR);
}
