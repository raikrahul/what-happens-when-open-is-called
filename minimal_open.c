#include <fcntl.h>
#include <unistd.h>

int main() { int fd = open("somefile", O_RDWR); }
