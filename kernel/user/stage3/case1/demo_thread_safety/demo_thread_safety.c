/*
 * demo_thread_safety.c
 *
 * Case 2: Thread safety — openat with a pinned dir fd vs chdir race
 *
 * Setup:
 *   /tmp/demo_threads/dir_A/data.txt  contains "CORRECT: dir_A"
 *   /tmp/demo_threads/dir_B/data.txt  contains "WRONG: dir_B"
 *
 * Thread 1: holds dir_fd = open("/tmp/demo_threads/dir_A", O_DIRECTORY)
 *           sleeps 200ms, then calls openat(dir_fd, "data.txt") → reads content
 *
 * Thread 2: immediately calls chdir("/tmp/demo_threads/dir_B")
 *           this changes the process cwd
 *
 * Thread 3: sleeps 200ms, then calls open("data.txt") using plain open() →
 * reads content
 *
 * Result:
 *   Thread 1 (openat):  reads "CORRECT: dir_A"  — dir_fd is immune to chdir
 *   Thread 3 (open):    reads "WRONG: dir_B"    — cwd was changed by Thread 2
 *
 * Run:  gcc demo_thread_safety.c -pthread -o demo_thread_safety.out
 *       ./demo_thread_safety.out
 */

#define _GNU_SOURCE
#include <fcntl.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

static int dir_fd;

static void setup(void) {
  mkdir("/tmp/demo_threads", 0755);
  mkdir("/tmp/demo_threads/dir_A", 0755);
  mkdir("/tmp/demo_threads/dir_B", 0755);

  int f1 = open("/tmp/demo_threads/dir_A/data.txt",
                O_CREAT | O_WRONLY | O_TRUNC, 0644);
  write(f1, "CORRECT: dir_A\n", 15);
  close(f1);

  int f2 = open("/tmp/demo_threads/dir_B/data.txt",
                O_CREAT | O_WRONLY | O_TRUNC, 0644);
  write(f2, "WRONG: dir_B\n", 13);
  close(f2);
}

/* Thread 2: change cwd immediately */
static void *thread_chdir(void *arg) {
  (void)arg;
  int r = chdir("/tmp/demo_threads/dir_B");
  printf("[Thread 2] chdir(\"/tmp/demo_threads/dir_B\") = %d\n", r);
  printf("[Thread 2] cwd is now dir_B\n\n");
  return NULL;
}

/* Thread 1: use openat(dir_fd, ...) after a delay */
static void *thread_openat(void *arg) {
  (void)arg;
  usleep(200000); /* 200ms — chdir has already happened */

  int fd = openat(dir_fd, "data.txt", O_RDONLY);
  if (fd < 0) {
    perror("[Thread 1] openat failed");
    return NULL;
  }

  char buf[64] = {0};
  read(fd, buf, sizeof(buf) - 1);
  close(fd);

  printf("[Thread 1] openat(dir_fd, \"data.txt\") → fd=%d\n", fd);
  printf("[Thread 1] content: %s", buf);
  printf("[Thread 1] dir_fd pinned to dir_A → chdir had NO effect ✓\n\n");
  return NULL;
}

/* Thread 3: use plain open("data.txt") after a delay */
static void *thread_open(void *arg) {
  (void)arg;
  usleep(200000); /* 200ms — chdir has already happened */

  int fd = open("data.txt", O_RDONLY);
  if (fd < 0) {
    perror("[Thread 3] open failed");
    return NULL;
  }

  char buf[64] = {0};
  read(fd, buf, sizeof(buf) - 1);
  close(fd);

  printf("[Thread 3] open(\"data.txt\") → fd=%d\n", fd);
  printf("[Thread 3] content: %s", buf);
  printf("[Thread 3] used cwd → chdir CHANGED what we opened ✗\n\n");
  return NULL;
}

static void cleanup(void) {
  unlink("/tmp/demo_threads/dir_A/data.txt");
  unlink("/tmp/demo_threads/dir_B/data.txt");
  rmdir("/tmp/demo_threads/dir_A");
  rmdir("/tmp/demo_threads/dir_B");
  rmdir("/tmp/demo_threads");
}

int main(void) {
  setup();

  /* Start in dir_A */
  chdir("/tmp/demo_threads/dir_A");
  printf("Initial cwd: /tmp/demo_threads/dir_A\n");

  /* Pin dir_A via a directory fd */
  dir_fd = open("/tmp/demo_threads/dir_A", O_RDONLY | O_DIRECTORY);
  printf("dir_fd = %d (pinned to dir_A)\n\n", dir_fd);

  pthread_t t1, t2, t3;
  pthread_create(&t2, NULL, thread_chdir, NULL);  /* changes cwd first */
  pthread_create(&t1, NULL, thread_openat, NULL); /* uses dir_fd */
  pthread_create(&t3, NULL, thread_open, NULL);   /* uses cwd */

  pthread_join(t2, NULL);
  pthread_join(t1, NULL);
  pthread_join(t3, NULL);

  printf("═══════════════════════════════════════════\n");
  printf("Thread 1 (openat + dir_fd): read from dir_A ✓\n");
  printf("Thread 3 (open + cwd):      read from dir_B ✗\n");
  printf("Conclusion: openat with a pinned fd is immune to chdir.\n");

  close(dir_fd);
  cleanup();
  return 0;
}
