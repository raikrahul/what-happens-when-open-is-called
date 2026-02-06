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

int main() {
  int f[6];
  char n1[] = "l_e.txt";
  char n2[] = "/tmp/t_e.txt";
  char n3[] = "/tmp/t_m.txt";
  char n4[] = "l_m.txt";
  char n5[] = "/mnt/loopfs/a.txt";

  for (int i = 0; i < 6; i++)
    f[i] = -1;

  printf("PID: %d\n", getpid());

  close(creat(n1, 0644));
  close(creat(n2, 0644));
  drop_caches_if_root();
  sleep(1);

  printf("1\n");
  f[0] = open(n1, O_RDONLY);
  printf("2\n");
  f[1] = open(n2, O_RDONLY);
  printf("3\n");
  f[2] = open(n3, O_RDONLY);
  printf("4\n");
  f[3] = open(n1, O_RDONLY);
  printf("5\n");
  f[4] = open(n4, O_RDONLY);

  printf("6\n");
  f[5] = open(n5, O_RDONLY);

  close_if_open(&f[0]);
  printf("7\n");
  f[0] = open(n1, O_RDONLY);

  sleep(2);
  close_if_open(&f[0]);
  close_if_open(&f[1]);
  close_if_open(&f[2]);
  close_if_open(&f[3]);
  close_if_open(&f[4]);
  close_if_open(&f[5]);

  printf("8\n");
  unlink(n1);
  unlink(n2);
  close(creat(n1, 0644));
  close(creat(n2, 0644));
  f[0] = open(n1, O_RDONLY);
  f[1] = open(n2, O_RDONLY);

  close_if_open(&f[0]);
  close_if_open(&f[1]);

  printf("9\n");
  drop_caches_if_root();
  sleep(1);
  f[0] = open(n1, O_RDONLY);
  f[1] = open(n2, O_RDONLY);
  close_if_open(&f[0]);
  close_if_open(&f[1]);

  return 0;
}
