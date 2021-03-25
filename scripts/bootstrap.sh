#!/usr/bin/env bash

family="$1"
if [ -z "$family" ]; then
	echo "Error: family required. Exiting..."
	exit
fi

# Arch-based
if [ "$family" = "arch" ]; then
	echo "INFO: enabling multilib & forcing resync for multilib"
	sudo sed -i 's/#[multilib]/[multilib]/g' /etc/pacman.conf
	sudo sed -i 's/#Include = \/etc\/pacman.d\/mirrorlist\//Include = \/etc\/pacman.d\/mirrorlist\//g' /etc/pacman.conf
	
	echo "INFO: updating system & installing packages"
	sudo pacman -Syyu
	sudo pacman -S base-devel git lib32-mesa lib32-vulkan-icd-loader vulkan-icd-loader steam lutris wine
	if [ -z "$(which yay)" ]; then
		echo "INFO: installing Yay"
		git clone https://aur.archlinux.org/yay-bin.git
		cd yay-bin || exit
		makepkg -si
	fi
	echo "INFO: installing AUR packages"
	yay -S mangohud # TODO: figure out which version of mangohud is the best for each system

	echo "Install zen kernel? [y/N]"
	read -r zen
	if [ "$zen" == "y" ]; then sudo pacman -S linux-zen; fi
fi
