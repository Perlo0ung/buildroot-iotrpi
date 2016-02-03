This README file contains information on the contents of the iotrpi buildroot setup.

Please see the corresponding sections below for details.

Maintainer: Michael Offergeld <miofferg@htwg-konstanz.de>

Table of Contents
=================

  I. Building
  

I. Building
=================================================

How to build:

- ```. setup```
- copy u-boot.bin, bcm2835-rpi-b.dtb, zImage, boot.scr.uimg, rootfs.cpio.uboot to an sdcard
- Boot your RPI, or use Qemu

II. Misc
========

Included:

* Mainline Kernel 4.2.3
* Busybox 1.24.1
* Uboot v2016.01
* Small initramfs rootfs
* GPIO Kernel Driver
* Led blink testprogram for the GPIO driver

This Image will be compiled for Raspberry Pi and Vexpress-A9


