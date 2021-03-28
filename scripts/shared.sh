#!/usr/bin/env bash

install_brew() {
if [[ ! -d "/home/linuxbrew" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.bashrc"
	source "$HOME/.bashrc"
fi
}

install_mangohud() {
	echo "INFO: installing MangoHud"
	curl "-L https://github.com/flightlessmango/MangoHud/releases/download/v0.6.1/MangoHud-0.6.1.tar.gz -o $WORKDIR/MangoHud.tar.gz"
	tar "-xf $WORKDIR/MangoHud.tar.gz"
	bash "$WORKDIR/MangoHud/mangohud-setup.sh install"
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
