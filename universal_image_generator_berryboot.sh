#!/bin/bash

# Universal Image Generator for Berryboot -Slight Mod by MattJaegerCO - Latest RaspOS Images
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
#Some artwork...
echo "-------------------------------------------------";
echo "  ___                   ___                      ";
echo " | _ ) ___ _ _ _ _ _  _/ __| ___ _ ___ _____ _ _ ";
echo " | _ \/ -_) '_| '_| || \__ \/ -_) '_\ V / -_) '_|";
echo " |___/\___|_| |_|  \_, |___/\___|_|  \_/\___|_|  ";
echo " 2021.03.10        |__/                          ";
echo "-------------------------------------------------";
echo ""
echo "#### INSTALLING DEPENDENCIES ####"
echo ""

#OS Menu Selection
PS3='Please select your current OS: '
options=("Debian/Ubuntu" "CentOS" "Fedora" "ArchLinux" "Skip")
select opt in "${options[@]}"
do
    case $opt in
        "Debian/Ubuntu")
		
echo ""
echo "#### INSTALLING ARIA2/SQUASHFS-TOOLS ####"
echo ""		
#installing packages
sudo apt-get update && sudo apt-get install aria2 squashfs-tools bsdtar xz-utils -y
echo ""
echo "#### DONE! ####"
echo ""
sleep 1
			break
            ;;
        "CentOS")
echo ""
echo "#### INSTALLING ARIA2/SQUASHFS-TOOLS ####"
echo ""		
#installing packages
sudo yum install aria2 squashfs-tools bsdtar xz-utils -y
echo ""
echo "#### DONE! ####"
echo ""
sleep 1
			break
            ;;
			"Fedora")
echo ""
echo "#### INSTALLING ARIA2/SQUASHFS-TOOLS ####"
echo ""		
#installing packages
sudo dnf install aria2 squashfs-tools bsdtar xz-utils -y
echo ""
echo "#### DONE! ####"
echo ""
sleep 1
			break
            ;;
			"ArchLinux")
echo ""
echo "#### INSTALLING ARIA2/SQUASHFS-TOOLS ####"
echo ""		
#installing packages
pacman -Syy --noconfirm aria2 squashfs-tools bsdtar xz-utils --force
echo ""
echo "#### DONE! ####"
echo ""
sleep 1
			break
			;;
        "Skip")
            break
            ;;
        *) echo invalid option;;
    esac
done
sleep 1

echo "-----------------------------------------------";
echo "   ___  ___   ___      _        _   _          ";
echo "  / _ \/ __| / __| ___| |___ __| |_(_)___ _ _  ";
echo " | (_) \__ \ \__ \/ -_) / -_) _|  _| / _ \ ' \ ";
echo "  \___/|___/ |___/\___|_\___\__|\__|_\___/_||_|";
echo "                                               ";
echo "-----------------------------------------------";
echo ""
echo "#### OPERATING SYSTEM SELECTION ####"
echo ""

#OS Menu Selection
PS3='Please select the OS: '
options=("ArchLinux ARM" "LibreELEC" "Raspberry Pi OS" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "LibreELEC")

#Starting LibreELEC Script
bash <(wget -qO- https://git.io/fx6Zc)
		break
            ;;
			"ArchLinux ARM")

#Starting ArchLinux ARM Script
bash <(wget -qO- https://git.io/JqZD0)
		break
            ;;
			
"Raspberry Pi OS")

#Starting Raspberry Pi OS Script
bash <(wget -qO- https://raw.githubusercontent.com/MattJaegerCO/Universal-Image-Generator-for-Berryboot/master/os-selection/raspberry-pi-os/raspberry_pi_os_stable_berryboot.sh)
		break
            ;;
        "Exit")
            break
            ;;
        *) echo invalid option;;
    esac
	echo "Press any key to continue"
	while [ true ] ; do
		read -t 3 -n 1
		if [ $? = 0 ] ; then
		exit ;
	else
		echo "waiting for the keypress"
	fi
done
