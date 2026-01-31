#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

/*
 * LESSON 03 PROOF: PATH WALKING
 * Axiom: To access /a/b/c, you must resolve /a, then /a/b, then /a/b/c.
 */

int main(int argc, char *argv[]) {
  if (argc < 2) {
    printf("Usage: %s /path/to/file\n", argv[0]);
    return 1;
  }

  char *path = strdup(argv[1]);
  char *token = strtok(path, "/");
  char current_path[1024] = "";
  struct stat sb;

  printf("WALKING: /\n");
  if (stat("/", &sb) < 0) {
    perror("stat /");
    return 1;
  }
  printf("  Inode: %lu\n", sb.st_ino);

  while (token != NULL) {
    strcat(current_path, "/");
    strcat(current_path, token);

    printf("WALKING: %s\n", current_path);

    if (stat(current_path, &sb) < 0) {
      printf("  FAILURE: Could not find component '%s'\n", token);
      return 1;
    }

    printf("  Inode: %lu\n", sb.st_ino);
    token = strtok(NULL, "/");
  }

  printf("SUCCESS: Destination Inode Found.\n");
  free(path);
  return 0;
}
