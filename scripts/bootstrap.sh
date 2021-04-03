#!/usr/bin/env bash
set -eu

source "./shared.sh"
if [[ ! -d "/home/linuxbrew" ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.profile"
fi
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

common=(git flatpak curl flatpak steam lutris wine cockpit npm yasm nasm sasm)
arch=(lib32-mesa lib32-vulkan-icd-loader lib32-libxinerama libstdc++5 base-devel vulkan-icd-loader openssh "${common[@]}")
ubuntu=(mesa-vulkan-drivers mesa-vulkan-drivers:i386 libvulkan1 vulkan-utils flatpak wine lutris build-essential autoconf openssh-server "${common[@]}")

# Arch-based
if [ -n "$(which pacman)" ]; then
	echo "INFO: enabling multilib & forcing resync for multilib"
	sudo sed -i 's/#[multilib]/[multilib]/g' /etc/pacman.conf
	sudo sed -i 's/#Include = \/etc\/pacman.d\/mirrorlist\//Include = \/etc\/pacman.d\/mirrorlist\//g' /etc/pacman.conf

	echo "INFO: updating system & installing packages"
	sudo pacman -Syyu --noconfirm
	sudo pacman -S --noconfirm "${arch[@]}"
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
	sudo systemctl enable --now sshd
# ubuntu/debian
elif [ -n "$(which apt-get)" ]; then
	echo "INFO: enabling multilib "
	sudo dpkg --add-architecture i386
	# $() doesn't work here for some reason. we only really support Ubuntu at this point anyway
	#if [ "$(lsb_release -i)" == "Distributor ID: Ubuntu" ]; then
		echo "INFO: on debian getting lutris from OBS"
		echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
		wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | sudo apt-key add -
		sudo add-apt-repository ppa:kisak/kisak-mesa -y
		sudo apt-get update
	#fi
	echo "INFO: updating system & installing packages"
	sudo apt-get upgrade -y
	sudo apt-get install -y "${ubuntu[@]}"
	sudo systemctl enable --now ssh
# fedora/Mageia 8
elif [ -n "$(which dnf)" ]; then
	echo "INFO: adding rpm fusion repos"
	sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	echo "INFO: updating system & installing packages"
	sudo dnf upgrade -y
	sudo dnf install -y flatpak vulkan-loader.i686 curl vulkan-loader.x86_64 mesa.i686 mesa steam
	sudo dnf groupinstall -y "Development Tools" "Development Libraries"
#opensuse
elif [ -n "$(which zypper)" ]; then
	echo "INFO: updating system & installing packages"
	sudo zypper install -y flatpak wine lutris steam
else
	echo "ERROR: Unsuported linux distribution"
	exit
fi

sudo systemctl restart cockpit

install_mangohud
install_flatpaks
install_pts
