#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <time.h>
#include <unistd.h>

#define ITERATIONS 500000
#define FILE_COUNT 100

int main() {
  struct stat st;
  struct timespec start, end;
  long long total_ns;
  int fds[FILE_COUNT];
  char paths[FILE_COUNT][64];
  char names[FILE_COUNT][32];
  int dir_fd = open("/tmp/bench_data", O_RDONLY | O_DIRECTORY);

  // Setup: Prepare 100 different files to pollute the dcache
  for (int i = 0; i < FILE_COUNT; i++) {
    sprintf(paths[i], "/tmp/bench_data/file_%d", i);
    sprintf(names[i], "file_%d", i);
    fds[i] = open(paths[i], O_RDONLY);
  }

  printf(
      "Starting Random Benchmark (%d total iterations, %d unique files)...\n\n",
      ITERATIONS, FILE_COUNT);

  // 1. stat (Rotated)
  clock_gettime(CLOCK_MONOTONIC, &start);
  for (int i = 0; i < ITERATIONS; i++) {
    stat(paths[i % FILE_COUNT], &st);
  }
  clock_gettime(CLOCK_MONOTONIC, &end);
  total_ns =
      (end.tv_sec - start.tv_sec) * 1000000000L + (end.tv_nsec - start.tv_nsec);
  printf("stat(\"/tmp/bench_data/file_X\"): %lld ns per call\n",
         total_ns / ITERATIONS);

  // 2. fstatat (Rotated)
  clock_gettime(CLOCK_MONOTONIC, &start);
  for (int i = 0; i < ITERATIONS; i++) {
    fstatat(dir_fd, names[i % FILE_COUNT], &st, 0);
  }
  clock_gettime(CLOCK_MONOTONIC, &end);
  total_ns =
      (end.tv_sec - start.tv_sec) * 1000000000L + (end.tv_nsec - start.tv_nsec);
  printf("fstatat(dirfd, \"file_X\"): %lld ns per call\n",
         total_ns / ITERATIONS);

  // 3. fstat (Fixed FD - benchmark entry cost)
  // We use a fixed FD because fstat's logic is constant regardless of file
  // identity
  clock_gettime(CLOCK_MONOTONIC, &start);
  for (int i = 0; i < ITERATIONS; i++) {
    fstat(fds[0], &st);
  }
  clock_gettime(CLOCK_MONOTONIC, &end);
  total_ns =
      (end.tv_sec - start.tv_sec) * 1000000000L + (end.tv_nsec - start.tv_nsec);
  printf("fstat(fds[0]): %lld ns per call\n", total_ns / ITERATIONS);

  for (int i = 0; i < FILE_COUNT; i++)
    close(fds[i]);
  close(dir_fd);
  return 0;
}
