ccflags-y := -std=gnu99 -Wno-declaration-after-statement
obj-m += ssd1307fb.o

KVER := $(shell uname -r)

all:
	make -C /lib/modules/$(KVER)/build/ M=$(PWD) modules
clean:
	make -C /lib/modules/$(KVER)/build/ M=$(PWD) clean

ssd1306.dtbo: ssd1306.dts
	dtc  -I dts -O dtb -o ssd1306.dtbo ssd1306.dts

ssd1307fb.ko.gz: ssd1307fb.ko
	gzip -k ssd1307fb.ko	

install: ssd1307fb.ko.gz ssd1306.dtbo
	sudo cp -f ssd1306.dtbo /boot/overlays
	sudo cp -f ssd1307fb.ko.gz /usr/lib/modules/4.4.45-1-ARCH/kernel/drivers/video/fbdev/