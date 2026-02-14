obj-m += driver_kretprobe.o
obj-m += driver_retprobe.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
	gcc -O2 user_trigger_missing.c -o user_trigger_missing
	gcc -O2 user_trigger_exists.c -o user_trigger_exists

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
	rm -f user_trigger_missing user_trigger_exists
