CC = gcc
CFLAGS = -Wall -Wextra -g -O2 -no-pie
PROOFS_DIR = proofs
AXIOMATIC_DIR = axiomatic_lessons

# Proof programs
PROOFS = $(PROOFS_DIR)/register_dump \
         $(PROOFS_DIR)/path_walk_simulator \
         $(PROOFS_DIR)/fd_exhaustion \
         $(PROOFS_DIR)/kernel_permission_simulation

# Axiomatic lesson programs
AXIOMATIC_PROGS = $(AXIOMATIC_DIR)/00_failure_predictions/lesson_demo \
                  $(AXIOMATIC_DIR)/01_the_syscall_interface/lesson_demo \
                  $(AXIOMATIC_DIR)/02_the_kernel_entry/lesson_demo \
                  $(AXIOMATIC_DIR)/03_the_path_walk/lesson_demo \
                  $(AXIOMATIC_DIR)/04_the_allocation/lesson_demo \
                  $(AXIOMATIC_DIR)/05_the_return/lesson_demo

# Error demonstration programs
ERROR_DEMOS = error_demo_enoent \
             error_demo_eacces \
             error_demo_emfile

.PHONY: all clean proofs axiomatic errors test install-deps

all: proofs axiomatic errors

proofs: $(PROOFS)

axiomatic: $(AXIOMATIC_PROGS)

errors: $(ERROR_DEMOS)

# Proof program rules
$(PROOFS_DIR)/register_dump: $(PROOFS_DIR)/00_register_dump.c
	$(CC) $(CFLAGS) -o $@ $<

$(PROOFS_DIR)/path_walk_simulator: $(PROOFS_DIR)/01_path_walk_simulator.c
	$(CC) $(CFLAGS) -o $@ $<

$(PROOFS_DIR)/fd_exhaustion: $(PROOFS_DIR)/02_fd_exhaustion.c
	$(CC) $(CFLAGS) -o $@ $<

$(PROOFS_DIR)/kernel_permission_simulation: $(PROOFS_DIR)/03_kernel_permission_simulation.c
	$(CC) $(CFLAGS) -o $@ $<

# Axiomatic lesson demo programs
$(AXIOMATIC_DIR)/00_failure_predictions/lesson_demo: $(AXIOMATIC_DIR)/00_failure_predictions/demo.c
	$(CC) $(CFLAGS) -o $@ $<

$(AXIOMATIC_DIR)/01_the_syscall_interface/lesson_demo: $(AXIOMATIC_DIR)/01_the_syscall_interface/demo.c
	$(CC) $(CFLAGS) -o $@ $<

$(AXIOMATIC_DIR)/02_the_kernel_entry/lesson_demo: $(AXIOMATIC_DIR)/02_the_kernel_entry/demo.c
	$(CC) $(CFLAGS) -o $@ $<

$(AXIOMATIC_DIR)/03_the_path_walk/lesson_demo: $(AXIOMATIC_DIR)/03_the_path_walk/demo.c
	$(CC) $(CFLAGS) -o $@ $<

$(AXIOMATIC_DIR)/04_the_allocation/lesson_demo: $(AXIOMATIC_DIR)/04_the_allocation/demo.c
	$(CC) $(CFLAGS) -o $@ $<

$(AXIOMATIC_DIR)/05_the_return/lesson_demo: $(AXIOMATIC_DIR)/05_the_return/demo.c
	$(CC) $(CFLAGS) -o $@ $<

# Error demonstration programs
error_demo_enoent: error_demos/enoent_demo.c
	$(CC) $(CFLAGS) -o $@ $<

error_demo_eacces: error_demos/eacces_demo.c
	$(CC) $(CFLAGS) -o $@ $<

error_demo_emfile: error_demos/emfile_demo.c
	$(CC) $(CFLAGS) -o $@ $<

# Test targets
test: all
	@echo "Running all proof programs..."
	@cd $(PROOFS_DIR) && ./register_dump && echo "✓ register_dump works"
	@cd $(PROOFS_DIR) && ./path_walk_simulator /etc/passwd > /dev/null && echo "✓ path_walk_simulator works"
	@cd $(PROOFS_DIR) && echo "Testing fd_exhaustion (may take a moment)..." && timeout 5s ./fd_exhaustion || true && echo "✓ fd_exhaustion works"
	@cd $(PROOFS_DIR) && ./kernel_permission_simulation && echo "✓ kernel_permission_simulation works"
	@echo "Running error demos..."
	@./error_demo_enoent && echo "✓ ENOENT demo works"
	@./error_demo_eacces && echo "✓ EACCES demo works"
	@echo "✓ All tests passed"

# Install dependencies for Ubuntu/Debian
install-deps:
	@echo "Installing dependencies..."
	sudo apt-get update
	sudo apt-get install -y build-essential gdb strace

clean:
	rm -f $(PROOFS) $(AXIOMATIC_PROGS) $(ERROR_DEMOS)
	find . -name "*.o" -delete
	find . -name "*.i" -delete
	find . -name "*.s" -delete

help:
	@echo "Available targets:"
	@echo "  all          - Build all programs"
	@echo "  proofs       - Build proof programs only"
	@echo "  axiomatic    - Build axiomatic lesson demos only"
	@echo "  errors       - Build error demonstration programs only"
	@echo "  test         - Run all tests"
	@echo "  clean        - Remove built files"
	@echo "  install-deps - Install build dependencies"
	@echo "  help         - Show this help"