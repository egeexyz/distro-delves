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
		yay -S mangohud 
		echo "Install zen kernel? [Y/N]"
		read -r zen
		if [ "$zen" == "Y" ]; then
				sudo pacman -S linux-zen
		fi
# ubuntu/debian
elif [ -f /usr/bin/apt ]; then
		dpkg --add-architecture i386
		apt update && apt upgrade
		apt install -y  mesa-vulkan-drivers steam libvulkan1 vulkan-utils mesa mesa:i386 wine
		on_ubuntu=$(lsb_release -i)
		if [ "$on_ubuntu" == "Distributor ID: Ubuntu" ]; then
				apt install lutris -y
		else 
				echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
				wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | sudo apt-key add -
				sudo apt update
				sudo apt upgrade
				sudo apt install lurtis
		fi
# fedora/Mageia 8
elif [ -f /usr/bin/dnf ]; then
		dnf upgrade && dnf install lutris wine vulkan-loader.i686 vulkan-loader.x86_64 mesa.i686 mesa -y
#opensuse 
elif [ -f /usr/bin/zypper ]; then
		sudo zypper in lutris vulkan-loader wine -y 
else
		echo "Unsuported linux distribution, considering porting this script to your distro and opening a pr"
fi

# TODO opensuse support