---
ensure system under test is up to date:
  pkg.uptodate:
    - refresh: True

install prerequisite packages:
  pkg.installed:
    - pkgs:
        - git
        - gcc
        - yasm
        - nasm
        - curl
        - make
        - steam
        - cmake
        - screen
        - autoconf
        - automake
        {# - glibc-devel-static
        - libvorbis-devel #}

/etc/sudoers:
  file.append:
    - text:
      - "egee ALL=(ALL) NOPASSWD: ALL"

fetch homebrew installer:
  file.managed:
    - name: /opt/brew-install.sh
    - source: https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    - mode: 755
    - skip_verify: True

/opt/brew-install.sh:
  cmd.run:
    - creates: /home/linuxbrew
    - runas: egee

/etc/profile.local:
  file.managed:
    - contents: 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'

brew install phoronix-test-suite:
  cmd.run:
    - creates: /home/linuxbrew/.linuxbrew/bin/phoronix-test-suite
    - runas: egee

brew install php:
  cmd.run:
    - creates: /home/linuxbrew/.linuxbrew/bin/php
    - runas: egee