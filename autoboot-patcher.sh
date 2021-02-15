#!/bin/bash

MAGISK_BOOT=$1

export PATH=bin:$PATH
magiskboot unpack $MAGISK_BOOT
