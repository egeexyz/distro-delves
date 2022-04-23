---
{% set user_name = pillar['common_user'] -%}

/etc/ssh/sshd_config.d/ssh.conf:
  file.managed:
    - source: salt://files/sshd.conf

/home/{{ user_name }}/.ssh/config:
  file.managed:
    - source: salt://files/ssh.conf
    - user: {{ user_name }}

/home/{{ user_name }}/Music/:
  file.recurse:
    - source: salt://files/tests/Music
    - include_empty: True
    - user: {{ user_name }}