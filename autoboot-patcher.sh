#!/bin/bash

MAGISK_BOOT=$1

export PATH=bin:$PATH

#clen
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
