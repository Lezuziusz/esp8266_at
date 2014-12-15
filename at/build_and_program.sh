#! /bin/sh
rm -rf .output
make
cd .output/eagle/debug/image
esptool -eo eagle.app.v6.out -bo eagle.app.v6.flash.bin -bs .text -bs .data -bs .rodata -bc -ec
xtensa-lx106-elf-objcopy --only-section .irom0.text -O binary eagle.app.v6.out eagle.app.v6.irom0text.bin
/opt/Espressif/esptool-py/esptool.py --port /dev/ttyUSB0 write_flash 0x00000 eagle.app.v6.flash.bin 0x40000 eagle.app.v6.irom0text.bin 0x7E000 ../../../../../bin/blank.bin
