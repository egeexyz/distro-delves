#!/bin/env bash
if [[ ! -d "/home/linuxbrew" ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.profile"
fi
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install php
brew install phoronix-test-suite
yes y | phoronix-test-suite
