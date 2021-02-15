#!/bin/bash

MAGISK_BOOT=$1

export PATH=bin:$PATH

if [ $1 ]; then
    echo "--- use $1 as magisk patched boot image"
else
    echo "Failed!!! - Please choose magisk patched boot image"
    echo "Usage:"
    echo "       ./autoboot-patcher.sh <magisk_patched_boot.img>"
    exit 1
fi

#clean
echo "--- Cleaning..."
magiskboot cleanup

#unpack
echo "--- Unpacking img..."
magiskboot unpack $MAGISK_BOOT

#ramdisk patch
echo "--- Patching ramdisk..."
magiskboot cpio ramdisk.cpio \
"mkdir 0700 overlay.d" \
"add 0700 overlay.d/init.custom.rc init.custom.rc" 
echo "--- Packing img..."
magiskboot repack $MAGISK_BOOT

if [ -f new-boot.img ]; then
    echo "### new-boot.img --- created"
    echo "### use \"fastboot flash boot new-boot.img\" to flash boot image to devices"
else
    echo "### ERROR!!! --- patch failed"
    exit 1
fi
