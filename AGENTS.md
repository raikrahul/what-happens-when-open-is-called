# AGENTS.md

## Build and Test Commands

### Single Test Compilation
```bash
# Build specific demo
make kernel/user/stage3/case1/case1_relative/case1_relative.out

# Build with debug symbols
make kernel/user/stage3/case1/case1_relative/case1_relative.out CFLAGS="-g -DDEBUG"
```

### Kernel Module Build/Load
```bash
# Build module
make kernel/drivers/stage3/case1/trace_path_init/trace_path_init.ko

# Load with target filter, run test, capture dmesg, unload
sudo insmod kernel/drivers/stage3/case1/trace_path_init/trace_path_init.ko target_comm="demo_name"
./demo_name.out
sudo dmesg | grep -E "PATH_INIT|PATH_WALK"
sudo rmmod trace_path_init

# Run all case1 tests
make test-case1
```

### Site
```bash
make build-site    # Generate HTML
make publish MSG="message"  # Publish to gh-pages
```

---

## Code Style

### Kernel Modules
```c
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/uaccess.h>

static char target_comm[TASK_COMM_LEN] = "";
module_param_string(target_comm, target_comm, sizeof(target_comm), 0644);

static int probe_handler(struct kprobe *p, struct pt_regs *regs)
{
    if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
        return 0;
    // Use probe_kernel_read() for memory access
    // Use %px for pointers, %s for strings in atomic context
    return 0;
}

static struct kprobe kp_function = {
    .symbol_name = "do_sys_openat2",
    .pre_handler = probe_handler,
};

module_init(trace_init);
module_exit(trace_cleanup);
MODULE_LICENSE("GPL");
```

### Userspace Programs
```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>

#define MAX_PATH 256

static void log_error(const char *op, int err)
{
    fprintf(stderr, "[ERROR] %s failed: %s (%d)\n", op, strerror(err), err);
}

int main(int argc, char *argv[])
{
    int fd = open(path, O_RDONLY);
    if (fd < 0) {
        log_error("open", errno);
        return 1;
    }
    close(fd);
    return 0;
}
```

---

## Conventions

### Imports
1. System headers (`<stdio.h>`, `<linux/module.h>`)
2. Local headers (`"project_headers.h"`)
3. Feature-specific (`#ifdef`)

### Naming
- Files: `case1_relative.c`, `demo_o_path.c`, `error_demo_enoent.c`
- Functions: `verb_noun` pattern (`setup_test_env`, `run_single_test`)
- Variables: `snake_case` (`fd`, `path_buffer`, `error_count`)
- Constants: Descriptive (`MAX_PATH`, `MODULE_NAME`)

### Error Handling
```c
// Validate inputs
if (!ptr) return -EINVAL;
if (IS_ERR(ptr)) return PTR_ERR(ptr);

// Check allocations
if (!buf) return -ENOMEM;

// Cleanup on error
if (result != 0) { close(fd); free(buf); return result; }
```

### Security
```c
// Kernel: use copy_from_user(), never direct user pointer
copy_from_user(kernel_buf, user_ptr, size);

// Userspace: validate all inputs
if (!path || strlen(path) >= PATH_MAX) { errno = EINVAL; return -1; }
```

### Testing
```c
#define ASSERT(cond, msg) \
    do { if (!(cond)) { fprintf(stderr, "FAIL: %s\n", msg); exit(1); } } while(0)

#define EXPECT_EQ(a, b) \
    do { if ((a) != (b)) { fprintf(stderr, "FAIL: %s != %s\n", #a, #b); exit(1); } } while(0)
```

---

## Project Structure

- `kernel/user/stage3/case[1-15]/` - Test cases (userspace)
- `kernel/drivers/stage3/` - Kernel modules (kprobes)
- `docs/lesson_details/` - Axiomatic lessons
- `site/` - Jekyll website

---

AI agents: Follow these patterns for consistent, secure, and maintainable code.
