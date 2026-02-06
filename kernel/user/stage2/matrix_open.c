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

  close(creat(n1, 0644));          // create local file for real inode
  close(creat(n2, 0644));          // /tmp prefix -> basename shift (+5)
  drop_caches_if_root();           // clear dcache before first opens
  sleep(1);                        // allow eviction to complete

  printf("1\n");
  f[0] = open(n1, O_RDONLY);       // local existing file
  printf("2\n");
  f[1] = open(n2, O_RDONLY);       // /tmp existing file (basename copy)
  printf("3\n");
  f[2] = open(n3, O_RDONLY);       // /tmp missing file (miss path)
  printf("4\n");
  f[3] = open(n1, O_RDONLY);       // local hit
  printf("5\n");
  f[4] = open(n4, O_RDONLY);       // local missing file

  printf("6\n");
  f[5] = open(n5, O_RDONLY);       // loopback ext2 short name

  close_if_open(&f[0]);
  printf("7\n");
  f[0] = open(n1, O_RDONLY);       // repeat hit

  sleep(2);                        // allow hit probes before deletion
  close_if_open(&f[0]);
  close_if_open(&f[1]);
  close_if_open(&f[2]);
  close_if_open(&f[3]);
  close_if_open(&f[4]);
  close_if_open(&f[5]);

  printf("8\n");
  unlink(n1);                      // deletion path (d_delete)
  unlink(n2);
  close(creat(n1, 0644));          // recreate for rebuild tests
  close(creat(n2, 0644));
  f[0] = open(n1, O_RDONLY);       // reopen after deletion
  f[1] = open(n2, O_RDONLY);

  close_if_open(&f[0]);
  close_if_open(&f[1]);

  printf("9\n");
  drop_caches_if_root();           // eviction path (__dentry_kill)
  sleep(1);                        // allow eviction to complete
  f[0] = open(n1, O_RDONLY);       // reopen after eviction
  f[1] = open(n2, O_RDONLY);
  close_if_open(&f[0]);
  close_if_open(&f[1]);

  return 0;
}
