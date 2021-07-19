#!/bin/env bash
set -eu

install_mangohud() {
	echo "INFO: installing MangoHud"
	curl -L https://github.com/flightlessmango/MangoHud/releases/download/v0.6.1/MangoHud-0.6.1.tar.gz -o /tmp/MangoHud.tar.gz
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
