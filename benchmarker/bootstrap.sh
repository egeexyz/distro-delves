#!/bin/env bash

curl -L https://github.com/flightlessmango/MangoHud/releases/download/v0.6.5/MangoHud-0.6.5.tar.gz -o /tmp/MangoHud.tar.gz
tar -C /tmp/ -xf /tmp/MangoHud.tar.gz
bash /tmp/MangoHud/mangohud-setup.sh install

if [[ ! -d "/home/linuxbrew" ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.profile"
fi
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install php
brew install phoronix-test-suite
yes y | phoronix-test-suite
