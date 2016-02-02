#!/bin/sh

mkimage -C none -A arm -T script -d ../files/configs/boot_script.txt $BINARIES_DIR/boot.scr.uimg


