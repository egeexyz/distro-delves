#!/usr/bin/env bash

# Arch-based
if [ -f /usr/bin/pacman ]; then
		# enable multilib
		sudo sed -i 's/#[multilib]/[multilib]/g' /etc/pacman.conf
		sudo sed -i 's/#Include = \/etc\/pacman.d\/mirrorlist\//Include = \/etc\/pacman.d\/mirrorlist\//g' /etc/pacman.conf
		sudo pacman -Syyu # force resync for multilib
		sudo pacman -S base-devel git lib32-mesa lib32-vulkan-icd-loader vulkan-icd-loader steam lutris wine
		git clone https://aur.archlinux.org/yay-bin.git
		cd yay-bin || exit
		makepkg -si
		yay -S mangohud # TODO: figure out which version of mangohud is the best for each system
		echo "Install zen kernel? [Y/N]"
		read -r zen
		if [ "$zen" == "Y" ]; then
				sudo pacman -S linux-zen
		fi
fi
		
