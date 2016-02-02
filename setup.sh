#!/bin/bash

BUILDROOT_VERSION=2015.11.1
BUILDROOT_DIR=buildroot-$BUILDROOT_VERSION
IMG_DIR=$BUILDROOT_DIR/output/images/


fhs_skeleton_ramfs() {
	[[ -d skeleton ]] && rm -rf skeleton
	mkdir -p skeleton/{bin,boot,dev,etc,lib,media,mnt,opt,run,sbin,srv,tmp,usr,usr/bin,proc,sys,var}
	touch skeleton/etc/{passwd,shadow}
	cp files/skeleton_files/init skeleton/init
}

download_buildroot() {
	wget https://buildroot.org/downloads/$BUILDROOT_DIR.tar.gz
	tar -xzf $BUILDROOT_DIR.tar.gz 
	cp files/configs/buildroot_config $BUILDROOT_DIR/.config
}

compile_buildroot() {
	pushd $BUILDROOT_DIR
	make
	popd
}

patch_configs_package_setup() {
	#patch package Config.in
	grep -q -e 'IOTRPI' $BUILDROOT_DIR/package/Config.in || echo -e "menu \"IOTRPI packages\"\n\tsource package/gpiomod/Config.in\nendmenu" >> $BUILDROOT_DIR/package/Config.in
	
	ln -sfn $PWD/packages/gpiomod $BUILDROOT_DIR/package

	mkdir -p $BUILDROOT_DIR/dl/

	pushd packages_src
	find . -mindepth 1 -maxdepth 1 -type d -exec sh -c 'echo $(tar cfz {}.tar.gz $(basename {}))' \;
	mv *.tar.gz ../$BUILDROOT_DIR/dl/
	popd
}

run_qemu() {
	QEMU_AUDIO_DRV=none qemu-system-arm -kernel $IMG_DIR/zImage -nographic -m 256 -initrd $IMG_DIR/rootfs.cpio.xz -dtb $IMG_DIR/vexpress-v2p-ca9.dtb  -M vexpress-a9 -cpu arm1176 --append "console=ttyAMA0"
}


export ARCH=arm

download_buildroot
fhs_skeleton_ramfs
patch_configs_package_setup
compile_buildroot
run_qemu


