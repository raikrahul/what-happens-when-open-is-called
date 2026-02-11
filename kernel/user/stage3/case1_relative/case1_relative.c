#include <fcntl.h>
#include <unistd.h>

int main(void) { open("some_relative_file.txt", O_CREAT | O_WRONLY, 0644); }
