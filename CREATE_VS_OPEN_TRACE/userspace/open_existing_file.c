/*******************************************************************************
 * USER PROGRAM B: Open Existing Test File
 * Filename: open_existing_file.c
 * Purpose: Open file that was created by create_test_file to trace open path
 * Process Name: open_test (for driver filtering)
 * 
 * This program opens a file that ALREADY EXISTS and reads from it.
 * The kernel takes a different code path compared to file creation:
 * - No vfs_create() call
 * - No d_alloc() for new dentry (uses existing)
 * - No d_instantiate()
 * - lookup_fast() returns existing dentry immediately
 ******************************************************************************/

#define _GNU_SOURCE
#include <stdio.h>      // printf, fprintf, perror
#include <stdlib.h>     // exit, malloc, free
#include <string.h>     // strcpy, strcmp, strerror, memcmp
#include <time.h>       // time
#include <unistd.h>     // getpid, close, getopt
#include <fcntl.h>      // open, O_RDONLY
#include <errno.h>      // errno
#include <sys/stat.h>   // stat, struct stat
#include <sys/types.h>  // mode_t

/* 
 * Buffer for reading file content
 * Size: 256 bytes on stack
 * Address: 0x7fff...d000 (example)
 */
static char read_buffer[256];

/*
 * Expected data prefix
 * "CREATE_TEST_" - 12 bytes
 * Used to verify this is the file created by create_test_file
 */
static const char expected_prefix[] = "CREATE_TEST_";

/*
 * Function: verify_file_exists
 * Purpose: Ensure target file exists before opening
 * Parameters: pathname - const char *
 * Returns: 0 if exists, 1 if not
 * 
 * System call: stat(pathname, &st)
 * Expected: st.st_ino != 0 (file has inode)
 *           st.st_size > 0 (file has content)
 */
static int verify_file_exists(const char *pathname)
{
    struct stat st;     // 144 bytes on stack at 0x7fff...c000
    int ret;            // 4 bytes on stack
    
    /* stat() syscall:
     * vfs_statx(AT_FDCWD, pathname, STATX_BASIC_STATS, ...)
     * Returns: 0 on success, -1 on error
     */
    ret = stat(pathname, &st);
    
    if (ret < 0) {
        /* File doesn't exist:
         * errno = ENOENT (2)
         * This is an ERROR for this program - we expect file to exist
         */
        if (errno == ENOENT) {
            fprintf(stderr, "ERROR: File does not exist: %s\n", pathname);
            fprintf(stderr, "       Run create_test_file first to create it.\n");
        } else {
            fprintf(stderr, "ERROR: stat() failed: %s (errno=%d)\n", 
                    strerror(errno), errno);
        }
        return 1;
    }
    
    /* File exists - verify attributes:
     * st.st_ino: inode number (e.g., 12345678)
     * st.st_size: file size in bytes (should be > 0)
     * st.st_nlink: number of hard links (should be >= 1)
     */
    if (st.st_ino == 0) {
        fprintf(stderr, "ERROR: File has no inode!\n");
        return 1;
    }
    
    if (st.st_size == 0) {
        fprintf(stderr, "ERROR: File has zero size!\n");
        return 1;
    }
    
    printf("VERIFIED FILE EXISTS:\n");
    printf("  inode: %lu\n", (unsigned long)st.st_ino);
    printf("  size: %ld bytes\n", (long)st.st_size);
    printf("  mode: 0%o\n", st.st_mode & 0777);
    printf("  links: %lu\n", (unsigned long)st.st_nlink);
    
    return 0;
}

/*
 * Function: open_existing_file
 * Purpose: Open file that already exists
 * Parameters: pathname - const char *
 * Returns: file descriptor or -1 on error
 * 
 * Open flags: O_RDONLY = 0x00 (read-only, no O_CREAT!)
 * 
 * Kernel path for existing file (NO O_CREAT):
 * 1. do_sys_openat2(AT_FDCWD, pathname, O_RDONLY)
 * 2. do_filp_open()
 * 3. path_openat()
 * 4. path_init()
 * 5. alloc_empty_file()
 * 6. init_file()
 * 7. link_path_walk()
 * 8. lookup_fast() -> returns EXISTING dentry
 * 9. lookup_open() -> dentry->d_inode != NULL, returns immediately
 * 10. may_open() -> permission check on existing inode
 * 11. finish_open() -> link file to existing dentry
 * 12. fd_install()
 * 13. return fd
 * 
 * KEY DIFFERENCE: lookup_open returns early when file exists!
 */
static int open_existing_file(const char *pathname)
{
    int fd;         // File descriptor (4 bytes on stack)
    int flags;      // Open flags (4 bytes on stack)
    
    flags = O_RDONLY;
    /* Binary: 0x00
     * No O_CREAT flag!
     * This tells kernel to fail if file doesn't exist
     */
    
    printf("OPEN FLAGS: 0x%x (%d) = O_RDONLY ONLY (NO O_CREAT)\n", flags, flags);
    printf("MODE: Not specified (file already exists)\n");
    
    /* open() syscall:
     * do_sys_openat2(AT_FDCWD=-100, pathname, flags=0, mode=0)
     */
    fd = open(pathname, flags);
    
    if (fd < 0) {
        /* Open failed:
         * errno = ENOENT (2) - shouldn't happen (we verified file exists)
         * errno = EACCES (13) - permission denied
         * errno = EISDIR (21) - path is directory
         */
        fprintf(stderr, "ERROR: open() failed: %s (errno=%d)\n", 
                strerror(errno), errno);
        return -1;
    }
    
    /* Success:
     * fd = 3 (first available after stdin=0, stdout=1, stderr=2)
     * current->files->fd_array[3] = struct file*
     * file->f_path.dentry = existing dentry (not newly allocated)
     */
    printf("SUCCESS: File opened, fd=%d\n", fd);
    printf("        Using EXISTING dentry and inode\n");
    
    return fd;
}

/*
 * Function: read_and_verify
 * Purpose: Read file content and verify it's our test data
 * Parameters: fd - file descriptor
 *             expected_size - size to read and verify
 * Returns: 0 on success, -1 on error
 */
static int read_and_verify(int fd, off_t expected_size)
{
    ssize_t bytes_read;     // 8 bytes on stack
    size_t to_read;         // 8 bytes on stack
    
    /* Determine read size:
     * Read minimum of: buffer size (256) or file size
     */
    to_read = (expected_size < sizeof(read_buffer)) ? 
              expected_size : sizeof(read_buffer);
    
    printf("READING: %zu bytes from fd=%d\n", to_read, fd);
    
    /* read() syscall:
     * vfs_read(fd, read_buffer, to_read, &pos)
     * pos starts at 0
     */
    bytes_read = read(fd, read_buffer, to_read);
    
    if (bytes_read < 0) {
        fprintf(stderr, "ERROR: read() failed: %s\n", strerror(errno));
        return -1;
    }
    
    if (bytes_read == 0) {
        fprintf(stderr, "ERROR: EOF reached (file empty?)\n");
        return -1;
    }
    
    printf("READ: %zd bytes\n", bytes_read);
    
    /* Verify data:
     * Check for expected prefix "CREATE_TEST_"
     */
    if (bytes_read >= strlen(expected_prefix)) {
        if (memcmp(read_buffer, expected_prefix, strlen(expected_prefix)) == 0) {
            printf("VERIFIED: File contains expected test data\n");
            printf("DATA: %.60s...\n", read_buffer);
            return 0;
        }
    }
    
    fprintf(stderr, "ERROR: File data doesn't match expected format\n");
    fprintf(stderr, "Expected prefix: %s\n", expected_prefix);
    fprintf(stderr, "Got: %.20s...\n", read_buffer);
    return -1;
}

/*
 * Function: print_usage
 * Purpose: Print command line usage
 */
static void print_usage(const char *progname)
{
    printf("Usage: %s <filename>\n", progname);
    printf("\n");
    printf("Open an existing test file to trigger kernel open path tracing.\n");
    printf("\n");
    printf("ARGUMENTS:\n");
    printf("  filename    Path to file created by create_test_file\n");
    printf("\n");
    printf("EXAMPLES:\n");
    printf("  %s /tmp/test_create_20260213_191201.txt\n", progname);
    printf("\n");
    printf("NOTE:\n");
    printf("  Run create_test_file first to create the file.\n");
}

/*******************************************************************************
 * MAIN FUNCTION
 ******************************************************************************/

int main(int argc, char *argv[])
{
    const char *filename;       // 8 bytes on stack - pointer to pathname
    int fd;                     // 4 bytes on stack - file descriptor
    struct stat st;            // 144 bytes on stack - file stats
    int ret;                   // 4 bytes on stack - return value
    
    /* Check arguments:
     * argc must be >= 2 (program name + filename)
     * argv[1] = pathname
     */
    if (argc < 2) {
        fprintf(stderr, "ERROR: Missing filename argument\n\n");
        print_usage(argv[0]);
        return 1;
    }
    
    if (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0) {
        print_usage(argv[0]);
        return 0;
    }
    
    filename = argv[1];
    
    printf("========================================\n");
    printf("OPEN EXISTING FILE - TRIGGER OPEN PATH\n");
    printf("========================================\n");
    printf("Process: PID=%d COMM=%s\n", getpid(), argv[0]);
    printf("Target file: %s\n", filename);
    printf("========================================\n\n");
    
    /* Step 1: Verify file exists
     * File MUST exist - this is the "existing file" test
     */
    printf("STEP 1: Verify file exists\n");
    if (verify_file_exists(filename) != 0) {
        fprintf(stderr, "FAIL: File doesn't exist or error\n");
        return 1;
    }
    printf("\n");
    
    /* Get file size for verification:
     * We need this to know how much to read
     */
    ret = stat(filename, &st);
    if (ret < 0) {
        fprintf(stderr, "ERROR: stat() failed: %s\n", strerror(errno));
        return 1;
    }
    
    /* Step 2: Open file
     * NO O_CREAT flag - expect file to exist
     * Kernel takes "open existing" path
     */
    printf("STEP 2: Open existing file (O_RDONLY only)\n");
    fd = open_existing_file(filename);
    if (fd < 0) {
        fprintf(stderr, "FAIL: File open failed\n");
        return 1;
    }
    printf("\n");
    
    /* Step 3: Read and verify
     * Read content and verify it matches what create_test_file wrote
     */
    printf("STEP 3: Read and verify file content\n");
    if (read_and_verify(fd, st.st_size) != 0) {
        close(fd);
        return 1;
    }
    printf("\n");
    
    /* Step 4: Close file
     * fput() in kernel releases reference
     * dentry reference count decremented
     */
    printf("STEP 4: Close file (fd=%d)\n", fd);
    ret = close(fd);
    if (ret < 0) {
        fprintf(stderr, "ERROR: close() failed: %s\n", strerror(errno));
        return 1;
    }
    printf("File closed successfully\n\n");
    
    /* Success */
    printf("========================================\n");
    printf("SUCCESS: Existing file opened and read\n");
    printf("  Path: %s\n", filename);
    printf("  Size: %ld bytes\n", (long)st.st_size);
    printf("  Inode: %lu\n", (unsigned long)st.st_ino);
    printf("\n");
    printf("Compare traces between:\n");
    printf("  1. create_test_file (creation path) - traces vfs_create, d_alloc, etc.\n");
    printf("  2. open_existing_file (open path) - no vfs_create, faster lookup\n");
    printf("========================================\n");
    
    return 0;
}
