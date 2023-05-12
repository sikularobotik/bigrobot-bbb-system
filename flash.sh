#!/bin/bash

if [ "$1" == "" ]
then
	echo "Usage: $0 <dev>"
	exit
fi

if mount | grep $1
then
	echo "$1 is mounted, abort"
	exit
fi

SL="\x1b[1;34m"
EL="\x1b[0m"

echo -e "${SL}Flashing sdcard.img...${EL}"
dd if=$(dirname $0)/buildroot-2023.02/output/images/sdcard.img of=$1

echo -e "${SL}Resize partition 2${EL}"
parted $1 resizepart 2 100%
e2fsck -f ${1}2
resize2fs ${1}2

echo -e "${SL}Set label for partition 1${EL}"
fatlabel ${1}1 BOOT

echo -e "${SL}Set label for partition 2${EL}"
e2label ${1}2 ROBOT

echo -e "${SL}Sync...${EL}"
sync

echo -e "${SL}DONE.${EL}"
