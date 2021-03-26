#!/usr/bin/env bash
# I think the famil stuff can be dropped it would be simpler to check if the package manager is present 
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
    if [ -z "$(which flatpak)" ]; then
    echo "INFO: installing Flatpaks, this will take a while..."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install flathub com.leinardi.gst -y
	flatpak install flathub com.basemark.BasemarkGPU -y
	flatpak install flathub io.github.arunsivaramanneo.GPUViewer -y

	flatpak install flathub org.xonotic.Xonotic -y
	flatpak install flathub org.zdoom.GZDoom -y
	flatpak install flathub io.github.freedoom.Phase1 -y
	flatpak install flathub com.moddb.TotalChaos -y
else
		echo "flatpak not install or not on path"
		exit 1
	fi
}

# Arch-based
if [ "$family" = "arch" ]; then
	echo "INFO: enabling multilib & forcing resync for multilib"
	sudo sed -i 's/#[multilib]/[multilib]/g' /etc/pacman.conf
	sudo sed -i 's/#Include = \/etc\/pacman.d\/mirrorlist\//Include = \/etc\/pacman.d\/mirrorlist\//g' /etc/pacman.conf
	
	echo "INFO: updating system & installing packages"
	sudo pacman -Syyu
	sudo pacman -S lib32-mesa lib32-vulkan-icd-loader git flatpak curl base-devel vulkan-icd-loader steam lutris wine
	if [ -z "$(which yay)" ]; then
		echo "INFO: installing Yay"
		git clone https://aur.archlinux.org/yay-bin.git
		cd yay-bin || exit
		makepkg -si
		cd $WORKDIR || exit
	fi
	#echo "INFO: installing AUR packages"
	echo "Install zen kernel? [y/N]"
	read -r zen
	if [ "$zen" == "y" ]; then sudo pacman -S linux-zen; fi
# ubuntu/debian
elif [ -f /usr/bin/apt ]; then
		echo "INFO: enabling multilib "
		dpkg --add-architecture i386
		echo "INFO: updating system & installing packages"
		sudo apt update
		sudo apt upgrade
		sudo apt install -y  mesa-vulkan-drivers flatpak curl libvulkan1 vulkan-utils mesa mesa:i386 wine
		on_ubuntu=$(lsb_release -i)
		if [ "$on_ubuntu" == "Distributor ID: Ubuntu" ]; then
				apt install lutris -y
		else 
				echo "INFO: on debian getting lutris from OBS"
				echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
				wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | sudo apt-key add -
				sudo apt update
				sudo apt upgrade
				sudo apt install lurtis
		fi
# fedora/Mageia 8
elif [ -f /usr/bin/dnf ]; then
		echo "INFO: adding rpm fusion repos"
		sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
		echo "INFO: updating system & installing packages"
		sudo dnf upgrade
		sudo dnf install flatpak vulkan-loader.i686 curl vulkan-loader.x86_64 mesa.i686 mesa steam	 -y
#opensuse 
elif [ -f /usr/bin/zypper ]; then
		echo "INFO: updating system & installing packages"
		sudo zypper install flatpak vulkan-loader wine curl steam -y 
else
		echo "ERROR: Unsuported linux distribution"
fi

install_mangohud
install_flatpaks
echo "INFO: Finalizing bootstrapping process. Forking apps..."

steam &
lutris &
winecfg &
