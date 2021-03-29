#!/usr/bin/env bash
set -eu

source "./shared.sh"
install_brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Arch-based
if [ -n "$(which pacman)" ]; then
	echo "INFO: enabling multilib & forcing resync for multilib"
	sudo sed -i 's/#[multilib]/[multilib]/g' /etc/pacman.conf
	sudo sed -i 's/#Include = \/etc\/pacman.d\/mirrorlist\//Include = \/etc\/pacman.d\/mirrorlist\//g' /etc/pacman.conf

	echo "INFO: updating system & installing packages"
	sudo pacman -Syyu --noconfirm
	sudo pacman -S --noconfirm lib32-mesa lib32-vulkan-icd-loader php git flatpak curl base-devel vulkan-icd-loader flatpak steam lutris wine
	if [ -z "$(which yay)" ]; then
		echo "INFO: installing Yay"
		git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin || true
		cd /tmp/yay-bin || exit
		makepkg -si
	fi
	#echo "INFO: installing AUR packages"
	echo "Install zen kernel? [y/N]"
	read -r zen
	if [ "$zen" == "y" ]; then sudo pacman -S --noconfirm linux-zen; fi
# ubuntu/debian
elif [ -n "$(which apt-get)" ]; then
		echo "INFO: enabling multilib "
		sudo dpkg --add-architecture i386
		# $() doesn't work here for some reason
		#if [ "$(lsb_release -i)" == "Distributor ID: Ubuntu" ]; then
			echo "INFO: on debian getting lutris from OBS"
			echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
			wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | sudo apt-key add -
			sudo add-apt-repository ppa:kisak/kisak-mesa -y
			sudo apt-get update
		#fi
		echo "INFO: updating system & installing packages"
		sudo apt-get upgrade -y
		sudo apt-get install -y mesa-vulkan-drivers mesa-vulkan-drivers:i386 libvulkan1 vulkan-utils mesa mesa:i386 flatpak wine lutris build-essential autoconf
# fedora/Mageia 8
elif [ -n "$(which dnf)" ]; then
		echo "INFO: adding rpm fusion repos"
		sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
		echo "INFO: updating system & installing packages"
		sudo dnf upgrade -y
		sudo dnf install -y flatpak vulkan-loader.i686 curl vulkan-loader.x86_64 mesa.i686 mesa steam
#opensuse
elif [ -n "$(which zypper)" ]; then
		echo "INFO: updating system & installing packages"
		sudo zypper install -y flatpak wine lutris steam
else
	echo "ERROR: Unsuported linux distribution"
	exit
fi

install_mangohud
install_flatpaks
install_phoronix
echo "INFO: Finalizing bootstrapping process. Forking apps..."

steam &
lutris &
winecfg &
