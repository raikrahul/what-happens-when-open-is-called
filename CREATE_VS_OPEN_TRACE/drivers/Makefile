# Makefile for kernel drivers
# Compiles trace_create_path.ko and trace_open_path.ko

# Kernel build directory
KDIR ?= /lib/modules/$(shell uname -r)/build

# Current directory
PWD := $(shell pwd)

# Module names
obj-m := trace_create_path.o trace_open_path.o

# Default target: build all modules
all: modules

modules:
	@echo "========================================"
	@echo "Building kernel modules..."
	@echo "Kernel: $(shell uname -r)"
	@echo "Build dir: $(KDIR)"
	@echo "========================================"
	$(MAKE) -C $(KDIR) M=$(PWD) modules
	@echo ""
	@echo "Build complete:"
	@ls -lh *.ko 2>/dev/null || echo "No .ko files found"

# Clean build artifacts
clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
	rm -f *.o *.ko *.mod.c *.mod.o *.order *.symvers .*.cmd

# Install modules (for testing)
install:
	@echo "Installing modules..."
	@echo "trace_create_path.ko -> target_comm=create_test"
	@echo "trace_open_path.ko -> target_comm=open_test"

# Load driver A (creation path)
load-create:
	@echo "Loading trace_create_path.ko..."
	sudo insmod trace_create_path.ko target_comm="create_test"
	@echo "Driver loaded. Check dmesg for probe registration."

# Load driver B (open path)
load-open:
	@echo "Loading trace_open_path.ko..."
	sudo insmod trace_open_path.ko target_comm="open_test"
	@echo "Driver loaded. Check dmesg for probe registration."

# Unload drivers
unload:
	-sudo rmmod trace_create_path 2>/dev/null || true
	-sudo rmmod trace_open_path 2>/dev/null || true
	@echo "Drivers unloaded."

# Show dmesg output
show-logs:
	sudo dmesg | grep -E "\[A\.|\[B\." | tail -50

# Test compilation only (check for errors)
check:
	$(MAKE) -C $(KDIR) M=$(PWD) modules 2>&1 | grep -E "error:|warning:" || echo "No errors or warnings"

.PHONY: all modules clean install load-create load-open unload show-logs check
