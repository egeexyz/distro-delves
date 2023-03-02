#!/usr/bin/env bash
set -eux
supported_pkg_mgrs=(apt-get dnf zypper)

install_icons() {
  icons_path="$HOME/.local/share/icons/hicolor/48x48/apps/"
  mkdir -p "$icons_path"
  cp ./assets/androgee1.png "$icons_path"
  cp ./assets/androgee2.png "$icons_path"
  cp ./assets/androgee3.png "$icons_path"
}

install_packages() {
  for pkg_mgr in "${supported_pkg_mgrs[@]}" ; do
    if [[ -n $(which "$pkg_mgr") ]] ; then
      sudo "$pkg_mgr" install ruby zenity flatpak
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    fi
  done
}

install_icons
install_packages
