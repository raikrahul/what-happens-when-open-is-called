obj-m += driver.o offset_prober.o pointer_check_driver.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
	gcc user_trigger.c -o user_trigger
	gcc -nostdlib -static -s user_trigger_raw_openat.S -o openat_raw

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
	rm -f user_trigger openat_raw
