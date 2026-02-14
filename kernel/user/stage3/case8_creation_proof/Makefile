obj-m += driver_creation_probe.o
obj-m += driver_lookup_probe.o
obj-m += driver_salt_probe.o
obj-m += driver_collision_probe.o
obj-m += driver_rename_probe.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
