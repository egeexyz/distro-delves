#!/usr/bin/env bash

# Arch-based
# TODO: ensure AUR is enabled/accessable
# TODO: ensure multilib is enabled
# TODO: optionally install zen-kernel
# AUR: mangohud

sudo pacman -Syu
sudo pacman -S lib32-mesa lib32-vulkan-icd-loader vulkan-icd-loader steam lutris wine
