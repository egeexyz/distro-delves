---
# Fedora prefers Podman but SaltStack doesn't currently work with Podman
# It's should be possible to install Docker on Fedora but it's not always easy; the upstream Docker repo didn't work on Fedora 36..
# Furthermore, the Docker states don't work out of the box because of SELinux not liking Docker mounts
# A commenter said: " In Fedora, they prefer the moby engine for docker -  sudo dnf install moby-engine docker-compose. Then just set up docker stuff as normal like in Debian/Ubuntu."
include:
  - common

install some packages:
  pkg.installed:
    - pkgs:
      - podman
      - podman-docker
      - cockpit
      - cockpit-podman
