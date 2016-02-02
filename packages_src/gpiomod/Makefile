ifneq ($(KERNELRELEASE),)
obj-m   := gpio.o
else
KDIR    := ../../buildroot/output/build/linux-4.2.3/
PWD     := $(shell pwd)


all: module

clean:
		$(MAKE) -C $(KDIR) M=$(PWD) clean
module:
		$(MAKE) -C $(KDIR) M=$(PWD) modules

endif
