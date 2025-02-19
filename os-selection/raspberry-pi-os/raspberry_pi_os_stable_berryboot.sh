#!/bin/bash

# Raspberry Pi OS Builds Image Generator for Berryboot
# Copyright 2018-2021 Alexander G.
# https://www.alexgoldcheidt.com
# https://github.com/agoldcheidt

if [ "$EUID" -ne 0 ]
then 
    echo 1>&2 "Please run as root"
    exit 1
fi

#date
date=$(date +"%d-%b-%Y")

sleep 1
#Some arwork...
echo "--------------------------------------------------------------"
echo "  ___              _                        ___ _    ___  ___ ";
echo " | _ \__ _ ____ __| |__  ___ _ _ _ _ _  _  | _ (_)  / _ \/ __|";
echo " |   / _\` (_-< '_ \ '_ \/ -_) '_| '_| ||| |  _/ | | (_) \__ \ ";
echo " |_|_\__,_/__/ .__/_.__/\___|_| |_|  \_, | |_| |_|  \___/|___/";
echo "             |_|                     |__/                     ";
echo "--------------------------------------------------------------"

#Download URLs
URL1="https://downloads.raspberrypi.org/raspios_arm64/images/raspios_arm64-2022-04-07/2022-04-04-raspios-bullseye-arm64.img.xz"
URL2="https://downloads.raspberrypi.org/raspios_armhf/images/raspios_armhf-2022-04-07/2022-04-04-raspios-bullseye-armhf.img.xz"
URL3="https://downloads.raspberrypi.org/raspios_full_armhf/images/raspios_full_armhf-2022-04-07/2022-04-04-raspios-bullseye-armhf-full.img.xz"

#Names for Converted OS Images
NAME1="Raspberry_Pi_OS_with_desktop_April42022_64BIT_Bullseye-$date.img"
NAME2="Raspberry_Pi_OS_with_desktop_April42022_32BIT_Bullseye-$date.img"
NAME3="Raspberry_Pi_OS_with_desktop_and_rec_soft_April42022_32BIT_Bullseye-$date.img"

#Mount Points
MNT1="/mnt/raspberry-pi-os-boot"
MNT2="/mnt/raspberry-pi-os-rootfs"

echo ""
echo "#### RASPBERRY PI OS IMAGE GENERATOR FOR BERRYBOOT ####"
echo ""

#Raspberry Pi OS Image Menu Selection
PS3='Please select your device: '
options=("Raspberry Pi OS 64BIT Desktop" "Raspberry Pi OS Desktop 32BIT" "Raspberry Pi OS Desktop and Recommended Software 32BIT" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Raspberry Pi OS 64BIT Desktop")
		
echo ""
echo "#### DOWNLOADING RASPBERRY PI OS 64BIT DESKTOP IMAGE ####"
echo ""
           aria2c -x 4 -s 4 "$URL1"
echo ""
echo "#### DECOMPRESSING RASPBERRY PI OS 64BIT DESKTOP IMAGE ####"
echo ""
			sudo unxz --threads=4 *arm64.img.xz
			echo "1"
			sudo mkdir $MNT1
			echo "1.5"
			sudo mkdir $MNT2
			echo "2"
			sudo losetup loop55 -P *arm64.img
			echo "3"
			sudo mount /dev/loop55p1 $MNT1
			echo "4"
			sudo mount /dev/loop55p2 $MNT2
			echo "5"
			sudo find $MNT2 -name 'cached_UTF-8_del.kmap.gz' -exec sh -c 'rm -f $1' _ {} \;
			echo "6"
			sudo find $MNT2 -name 'apply_noobs_os_config.service' -exec sh -c 'rm -f $1' _ {} \;
			echo "7"
			sudo find $MNT2 -name 'raspberrypi-net-mods.service' -exec sh -c 'rm -f $1' _ {} \;
			echo "8"
			sudo sed -i 's/^\PARTUUID/#\0/g' $MNT2/etc/fstab
			echo "9"
			sudo rm -f $MNT1/kernel* $MNT1/*.elf
			echo "10"
			sudo cp -R $MNT1/* $MNT2/boot/
			echo "11"
echo ""
echo "#### CONVERTING RASPBERRY PI OS 64BIT DESKTOP IMAGE TO BERRYBOOT ####"
echo ""
			sudo mksquashfs $MNT2 $NAME1 -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			echo "12"
			sudo umount $MNT1
			echo "12.5"
			sudo umount $MNT2
			echo "13"
			sudo losetup -d /dev/loop55
			echo "14"
			sudo rm -rf *arm64* $MNT1
			echo "14.5"
			sudo rm -rf *arm64* $MNT2
			echo "15"
echo ""
echo "#### RASPBERRY PI OS 64BIT DESKTOP IMAGE READY! ####"
echo ""
echo "-----------------------------------------------";
echo "Support my project at: paypal.me/alexgoldc";
echo "-----------------------------------------------";
echo ""
			break
            ;;
	"Raspberry Pi OS Desktop 32BIT")
		
echo ""
echo "#### DOWNLOADING RASPBERRY PI OS DESKTOP 32BIT IMAGE ####"
echo ""
           aria2c -x 4 -s 4 "$URL2"
echo ""
echo "#### DECOMPRESSING RASPBERRY PI OS DESKTOP 32 BIT IMAGE ####"
echo ""
			sudo unxz --threads=4 *armhf.img.xz
			sudo mkdir $MNT1
			echo "1.5"
			sudo mkdir $MNT2
			echo "2"
			sudo losetup loop55 -P *armhf.img
			sudo mount /dev/loop55p1 $MNT1
			sudo mount /dev/loop55p2 $MNT2
			sudo find $MNT2 -name 'cached_UTF-8_del.kmap.gz' -exec sh -c 'rm -f $1' _ {} \;
			sudo find $MNT2 -name 'apply_noobs_os_config.service' -exec sh -c 'rm -f $1' _ {} \;
			sudo find $MNT2 -name 'raspberrypi-net-mods.service' -exec sh -c 'rm -f $1' _ {} \;
			sudo sed -i 's/^\PARTUUID/#\0/g' $MNT2/etc/fstab
			sudo rm -f $MNT1/kernel* $MNT1/*.elf
			sudo cp -R $MNT1/* $MNT2/boot/
echo ""
echo "#### CONVERTING RASPBERRY PI OS DESKTOP 32BIT IMAGE TO BERRYBOOT ####"
echo ""
			sudo mksquashfs $MNT2 $NAME2 -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			echo "12"
			sudo umount $MNT1
			echo "12.5"
			sudo umount $MNT2
			sudo losetup -d /dev/loop55
			sudo rm -rf *armhf* $MNT1
			sudo rm -rf *armhf* $MNT2
			echo "15"
echo ""
echo "#### RASPBERRY PI OS DESKTOP 32BIT IMAGE READY! ####"
echo ""
echo "-----------------------------------------------";
echo "Support my project at: paypal.me/alexgoldc";
echo "-----------------------------------------------";
echo ""
			break
            ;;
	"Raspberry Pi OS Desktop and Recommended Software 32BIT")
		
echo ""
echo "#### DOWNLOADING Raspberry Pi OS Desktop and Recommended Software 32BIT IMAGE ####"
echo ""
           aria2c -x 4 -s 4 "$URL3"
echo ""
echo "#### DECOMPRESSING Raspberry Pi OS Desktop and Recommended Software 32BIT IMAGE ####"
echo ""
			sudo unxz --threads=4 *armhf-full.img.xz
			sudo mkdir $MNT1
			echo "1.5"
			sudo mkdir $MNT2
			echo "2"
			sudo losetup loop55 -P *armhf-full.img
			sudo mount /dev/loop55p1 $MNT1
			sudo mount /dev/loop55p2 $MNT2
			sudo find $MNT2 -name 'cached_UTF-8_del.kmap.gz' -exec sh -c 'rm -f $1' _ {} \;
			sudo find $MNT2 -name 'apply_noobs_os_config.service' -exec sh -c 'rm -f $1' _ {} \;
			sudo find $MNT2 -name 'raspberrypi-net-mods.service' -exec sh -c 'rm -f $1' _ {} \;
			sudo sed -i 's/^\PARTUUID/#\0/g' $MNT2/etc/fstab
			sudo rm -f $MNT1/kernel* $MNT1/*.elf
			sudo cp -R $MNT1/* $MNT2/boot/
echo ""
echo "#### CONVERTING Raspberry Pi OS Desktop and Recommended Software 32BIT IMAGE TO BERRYBOOT ####"
echo ""
			sudo mksquashfs $MNT2 $NAME3 -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			echo "12"
			sudo umount $MNT1
			echo "12.5"
			sudo umount $MNT2
			echo "13"
			sudo losetup -d /dev/loop55
			echo "14"
			sudo rm -rf *armhf-full* $MNT1
			echo "14.5"
			sudo rm -rf *armhf-full* $MNT2
			echo "15"
echo ""
echo "#### Raspberry Pi OS Desktop and Recommended Software 32BIT IMAGE READY! ####"
echo ""
echo "-----------------------------------------------";
echo "Support my project at: paypal.me/alexgoldc";
echo "-----------------------------------------------";
echo ""
			break
            ;;			
        "Exit")
	break
            ;;
        *) echo invalid option;;
    esac
done
