---
{% set user_name = pillar['common_user'] -%}

/etc/ssh/sshd_config.d/ssh.conf:
  file.managed:
    - source: salt://files/sshd.conf

/home/{{ user_name }}/.ssh/config:
  file.managed:
    - source: salt://files/ssh.conf
    - user: {{ user_name }}
    - makedirs: True

/home/{{ user_name }}/Downloads/:
  file.recurse:
    - source: salt://files/tests/Downloads
    - makedirs: True
    - user: {{ user_name }}

/home/{{ user_name }}/Pictures/:
  file.recurse:
    - source: salt://files/tests/Pictures
    - makedirs: True
    - user: {{ user_name }}