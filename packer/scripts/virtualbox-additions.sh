#!/bin/bash

# Install the VirtualBox guest additions
VBOX_ISO="VBoxGuestAdditions.iso"
MOUNT_DIR="/mnt/VBox"
VBOX_TMP="/tmp/VBox"

# Fix for not finding version.h
ln -s /usr/include/linux/version.h /lib/modules/`uname -r`/build/include/linux/
ln -s /usr/src/kernels/`uname -r`/include/generated/autoconf.h /lib/modules/`uname -r`/build/include/generated/

mkdir -p ${MOUNT_DIR};
mount -o loop ${VBOX_ISO} ${MOUNT_DIR};

mkdir ${VBOX_TMP};

sh ${MOUNT_DIR}/VBoxLinuxAdditions.run --noexec --target ${VBOX_TMP}/;
umount ${MOUNT_DIR};
rm -f ${VBOX_ISO};

# https://www.virtualbox.org/attachment/ticket/15695/mod_timer.patch
sed -i "358ised -i 's/\\\(#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 31)\\\)/\\\1 || LINUX_VERSION_CODE >= KERNEL_VERSION(4, 8, 0)/g' ${INSTALLATION_DIR}/src/vboxguest-5.0.28/vboxguest/r0drv/linux/timer-r0drv-linux.c" install.sh;

rm -rf ${VBOX_TMP};
