#!/usr/bin/env bash

family="$1"
if [ -z "$family" ]; then
	echo "Error: family required. Exiting..."
	exit
fi

WORKDIR="/tmp/distrodelves-bootstrap"

mkdir -p $WORKDIR
cd $WORKDIR || exit

# Arch-based
if [ "$family" = "arch" ]; then
	echo "INFO: enabling multilib & forcing resync for multilib"
	sudo sed -i 's/#[multilib]/[multilib]/g' /etc/pacman.conf
	sudo sed -i 's/#Include = \/etc\/pacman.d\/mirrorlist\//Include = \/etc\/pacman.d\/mirrorlist\//g' /etc/pacman.conf
	
	echo "INFO: updating system & installing packages"
	sudo pacman -Syyu
	sudo pacman -S lib32-mesa lib32-vulkan-icd-loader git curl base-devel vulkan-icd-loader flatpak steam lutris wine
	if [ -z "$(which yay)" ]; then
		echo "INFO: installing Yay"
		git clone https://aur.archlinux.org/yay-bin.git
		cd yay-bin || exit
		makepkg -si
		cd $WORKDIR || exit
	fi
	#echo "INFO: installing AUR packages"
	
	echo "INFO: installing MangoHud"
	curl -L https://github.com/flightlessmango/MangoHud/releases/download/v0.6.1/MangoHud-0.6.1.tar.gz -o $WORKDIR/MangoHud.tar.gz
	tar -xf $WORKDIR/MangoHud.tar.gz
	bash $WORKDIR/MangoHud/mangohud-setup.sh

	echo "Install zen kernel? [y/N]"
	read -r zen
	if [ "$zen" == "y" ]; then sudo pacman -S linux-zen; fi
fi

echo "INFO: Finalizing bootstrapping process. Forking apps..."

steam &
lutris &
winecfg &
