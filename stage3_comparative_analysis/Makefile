# Build both user programs and kernel driver

# User programs
CC = gcc
CFLAGS = -Wall -g

# Kernel driver
KDIR ?= /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

# Kernel module target
obj-m := driver_comparative.o

# Targets
USER_PROGS = user_create user_open
DRIVER = driver_comparative.ko

.PHONY: all clean driver userspace

all: userspace driver

userspace: $(USER_PROGS)

user_create: user_create.c
	$(CC) $(CFLAGS) -o $@ $<

user_open: user_open.c
	$(CC) $(CFLAGS) -o $@ $<

driver: driver_comparative.c
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	rm -f $(USER_PROGS)
	$(MAKE) -C $(KDIR) M=$(PWD) clean

test-create: userspace driver
	@echo "=== Testing File Creation ==="
	sudo dmesg -C
	sudo insmod $(DRIVER) target_comm="user_create"
	./user_create
	sudo rmmod driver_comparative
	sudo dmesg | grep PROBE > results/scenario_a.log
	@echo "Results saved to results/scenario_a.log"

test-open: userspace driver
	@echo "=== Testing File Open (Existing) ==="
	sudo dmesg -C
	sudo insmod $(DRIVER) target_comm="user_open"
	./user_open
	sudo rmmod driver_comparative
	sudo dmesg | grep PROBE > results/scenario_b.log
	@echo "Results saved to results/scenario_b.log"

compare: test-create test-open
	@echo "=== Comparing Paths ==="
	@diff results/scenario_a.log results/scenario_b.log > results/comparison.diff || true
	@echo "Differences saved to results/comparison.diff"
