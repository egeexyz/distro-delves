#!/usr/bin/env bash

family="$1"
if [ -z "$family" ]; then
	echo "Error: family required. Exiting..."
	exit
fi

WORKDIR="/tmp/distrodelves-bootstrap"

mkdir -p $WORKDIR
cd $WORKDIR || exit

install_mangohud() {
	echo "INFO: installing MangoHud"
	curl -L https://github.com/flightlessmango/MangoHud/releases/download/v0.6.1/MangoHud-0.6.1.tar.gz -o $WORKDIR/MangoHud.tar.gz
	tar -xf $WORKDIR/MangoHud.tar.gz
	bash $WORKDIR/MangoHud/mangohud-setup.sh install
}

install_flatpaks () {
	echo "INFO: installing Flatpaks, this will take a while..."
	pacman -S flatpak 
	flatpak install flathub com.leinardi.gst -y
	flatpak install flathub com.basemark.BasemarkGPU -y
	flatpak install flathub io.github.arunsivaramanneo.GPUViewer -y

	flatpak install flathub org.xonotic.Xonotic -y
	flatpak install flathub org.zdoom.GZDoom -y
	flatpak install flathub io.github.freedoom.Phase1 -y
	flatpak install flathub com.moddb.TotalChaos -y
}

# Arch-based
if [ "$family" = "arch" ]; then
	echo "INFO: enabling multilib & forcing resync for multilib"
	sudo sed -i 's/#[multilib]/[multilib]/g' /etc/pacman.conf
	sudo sed -i 's/#Include = \/etc\/pacman.d\/mirrorlist\//Include = \/etc\/pacman.d\/mirrorlist\//g' /etc/pacman.conf
	
	echo "INFO: updating system & installing packages"
	sudo pacman -Syyu
	sudo pacman -S lib32-mesa lib32-vulkan-icd-loader git curl base-devel vulkan-icd-loader steam lutris wine
	if [ -z "$(which yay)" ]; then
		echo "INFO: installing Yay"
		git clone https://aur.archlinux.org/yay-bin.git
		cd yay-bin || exit
		makepkg -si
		cd $WORKDIR || exit
	fi
	#echo "INFO: installing AUR packages"
	
	install_mangohud
	install_flatpaks

	echo "Install zen kernel? [y/N]"
	read -r zen
	if [ "$zen" == "y" ]; then sudo pacman -S linux-zen; fi
fi

echo "INFO: Finalizing bootstrapping process. Forking apps..."

steam &
lutris &
winecfg &
