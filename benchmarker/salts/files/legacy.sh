#!/bin/env bash
#shellcheck disable=SC2016,SC1091
set -eu

if [[ ! -d "/home/linuxbrew" ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.profile"
fi
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

common=(git flatpak curl flatpak steam wine cockpit npm yasm nasm screen)
arch=(lib32-mesa lib32-vulkan-icd-loader lib32-libxinerama libstdc++5 base-devel vulkan-icd-loader openssh linux-zen "${common[@]}")
ubuntu=(mesa-vulkan-drivers mesa-vulkan-drivers:i386 libvulkan1 vulkan-utils flatpak wine build-essential autoconf openssh-server "${common[@]}")
opensuse=("${common[@]}" )

if [ -n "$(which pacman)" ]; then
	echo "INFO: enabling multilib & forcing resync for multilib"
	sudo sed -i 's/#[multilib]/[multilib]/g' /etc/pacman.conf
	sudo sed -i 's/#Include = \/etc\/pacman.d\/mirrorlist\//Include = \/etc\/pacman.d\/mirrorlist\//g' /etc/pacman.conf

	echo "INFO: updating system & installing packages"
	sudo pacman -Syyu --noconfirm
	sudo pacman -S --noconfirm "${arch[@]}"
	sudo systemctl enable --now sshd
elif [ -n "$(which apt-get)" ]; then
	echo "INFO: updating system & installing packages"
	sudo dpkg --add-architecture i386
	sudo apt-get upgrade -y
	sudo apt-get install -y "${ubuntu[@]}"
	sudo systemctl enable --now ssh
elif [ -n "$(which dnf)" ]; then
	echo "INFO: updating system & installing packages"
	sudo dnf upgrade -y
	sudo dnf install -y flatpak vulkan-loader.i686 curl vulkan-loader.x86_64 steam glibc-static
	sudo dnf groupinstall -y "Development Tools" "Development Libraries"
elif [ -n "$(which zypper)" ]; then
	echo "INFO: updating system & installing packages"
	sudo zypper install -y flatpak wine lutris steam automake glibc-devel-static libogg-devel yasm nasm libvorbis-devel taglib taglib-extras-devel nodejs15 libopusfile0 libopus-devel
else
	echo "ERROR: Unsuported linux distribution" ; exit 1
fi

install_mangohud() {
	echo "INFO: installing MangoHud"
	curl -L https://github.com/flightlessmango/MangoHud/releases/download/v0.6.5/MangoHud-0.6.5.tar.gz -o /tmp/MangoHud.tar.gz
	tar -C /tmp/ -xf /tmp/MangoHud.tar.gz
	bash /tmp/MangoHud/mangohud-setup.sh install
}

install_pts() {
	brew install php
	brew install phoronix-test-suite
	yes y | phoronix-test-suite
}

install_tests() {
	suites=(basic compiling encoding compression devel gpu-perf gpu-oss gpu-unigine)
	pts_root="$HOME/.phoronix-test-suite"

	echo "INFO: Installing test suites. This will take a while..."
	cat ./pts/user-config.xml > "$pts_root/user-config.xml"
	for suite in "${suites[@]}"; do
		runner_path="$pts_root/eg-${suite}-runner.sh"
		mkdir -p "$pts_root/test-suites/local/eg-${suite}"
		cat "./pts/suites/eg-${suite}.xml" > "$pts_root/test-suites/local/eg-${suite}/suite-definition.xml"
		phoronix-test-suite install "eg-${suite}"
		chmod +x "$runner_path"
	done
}
