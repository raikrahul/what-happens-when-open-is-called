#include <fcntl.h>
#include <unistd.h>

int main() {
  open("somefile", O_RDWR);
  int fd = open("someOtherFile", O_RDWR);
}
