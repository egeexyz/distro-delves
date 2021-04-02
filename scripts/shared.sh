#!/usr/bin/env bash
set -eu

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

install_pts() {
	# Broken: encryption gpu_perf unigine games_oss games_steam
	suites=(basic compiling encoding compression devel)
	# brew install gcc
	# brew install make
	brew install php
	brew install phoronix-test-suite
	yes y | phoronix-test-suite

	cp "./pts/user-config.xml" "$HOME/.phoronix-test-suite/user-config.xml" || true
	echo "INFO: Installing test suites. This will take a while..."
	for suite in "${suites[@]}"; do
		mkdir -p "$HOME/.phoronix-test-suite/test-suites/local/eg-${suite}"
		cp "./pts/suites/eg-${suite}.xml" "$HOME/.phoronix-test-suite/test-suites/local/eg-${suite}/suite-definition.xml" || true
		phoronix-test-suite install "eg-${suite}"
		mkdir -p "$HOME/.config/systemd/user"
		echo -e "[Unit]\nDescription=${suite}\n[Install]\nWantedBy=default.target\n[Service]\nType=oneshot\nExecStart=/home/linuxbrew/.linuxbrew/bin/phoronix-test-suite batch-run eg-${suite}" > "$HOME/.config/systemd/user/eg-${suite}.service"
	done
}
