---
run pihole:
  docker_container.running:
    - name: pihole
    - image: pihole/pihole:latest
    - restart_policy: always
    - environment:
      - WEBPASSWORD=donthackmebro
    - port_bindings:
      - "53:53/tcp"
      - "53:53/udp"
      - "67:67/udp"
      - "80:80/tcp"
    - binds:
      - '/etc/pihole:/etc/pihole'
      - '/etc/dnsmasq.d:/etc/dnsmasq.d'