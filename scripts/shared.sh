#!/usr/bin/env bash
set -eu

install_brew() {
	if [[ ! -d "/home/linuxbrew" ]]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.bashrc"
		source "$HOME/.bashrc"
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
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install flathub com.leinardi.gst -y
	flatpak install flathub io.github.arunsivaramanneo.GPUViewer -y

    # flatpak install flathub com.basemark.BasemarkGPU -y
	# flatpak install flathub org.xonotic.Xonotic -y
	# flatpak install flathub org.zdoom.GZDoom -y
	# flatpak install flathub io.github.freedoom.Phase1 -y
	# flatpak install flathub com.moddb.TotalChaos -y
}

install_phoronix() {
    brew install phoronix-test-suite
    yes y | phoronix-test-suite
	curl -L https://gist.githubusercontent.com/egee-irl/5265d9a5e44e9d14dee175be5a39ce63/raw/7b4435c5a91492614d7438bf3abcdf93eb0bec85/user-config.xml -o "$HOME/.phoronix-test-suite/user-config.xml"
}
