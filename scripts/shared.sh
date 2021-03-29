#!/usr/bin/env bash
set -eu

install_brew() {
	if [[ ! -d "/home/linuxbrew" ]]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.bashrc"
	fi
}

install_mangohud() {
	echo "INFO: installing MangoHud"
	curl -L https://github.com/flightlessmango/MangoHud/releases/download/v0.6.1/MangoHud-0.6.1.tar.gz -o /tmp/MangoHud.tar.gz
	tar -C /tmp/ -xf /tmp/MangoHud.tar.gz
	bash /tmp/MangoHud/mangohud-setup.sh install
}

install_flatpaks() {
	echo "INFO: installing Flatpaks, this will take a while..."
	flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install --user flathub com.leinardi.gst -y
	flatpak install --user flathub io.github.arunsivaramanneo.GPUViewer -y

	# flatpak install flathub com.basemark.BasemarkGPU -y
	# flatpak install flathub org.xonotic.Xonotic -y
	# flatpak install flathub org.zdoom.GZDoom -y
	# flatpak install flathub io.github.freedoom.Phase1 -y
	# flatpak install flathub com.moddb.TotalChaos -y
}

install_phoronix() {
	brew install gcc
	brew install php
	brew install make
	brew install phoronix-test-suite
	yes y | phoronix-test-suite

	mkdir -p "$HOME/.phoronix-test-suite/test-suites/local/eg-basic"

	curl -L https://gist.githubusercontent.com/egee-irl/5265d9a5e44e9d14dee175be5a39ce63/raw/7b4435c5a91492614d7438bf3abcdf93eb0bec85/user-config.xml \
		-o "$HOME/.phoronix-test-suite/user-config.xml"
	curl -L https://gist.githubusercontent.com/egee-irl/d08076d660e9275ae23d8e3c9b6ca62d/raw/4300163d25f84f607cb7cba36cacfdefa0926ce0/eg-basic \
		-o "$HOME/.phoronix-test-suite/test-suites/local/eg-basic/suite-definition.xml"
}
