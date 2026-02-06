#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

int main() {
  int f[6];
  char n1[] = "l_e.txt";
  char n2[] = "/tmp/t_e.txt";
  char n3[] = "/tmp/t_m.txt";
  char n4[] = "l_m.txt";
  char n5[] = "/mnt/loopfs/a.txt";

  printf("PID: %d\n", getpid());

  close(creat(n1, 0644));
  close(creat(n2, 0644));

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

  close(f[0]);
  printf("7\n");
  f[0] = open(n1, O_RDONLY);

  sleep(2);
  unlink(n1);
  unlink(n2);
  return 0;
}
