obj-m += trace_lpw_v4.o trace_offset_proof.o trace_lpw.o trace_lpw_v2.o trace_lpw_safe.o trace_d_lookup.o

KDIR := /lib/modules/$(shell uname -r)/build

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
