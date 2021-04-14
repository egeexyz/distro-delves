---
init phoronix test suite:
  cmd.run:
    - name: "yes y | phoronix-test-suite"
    - runas: egee
    - unless: test -f /home/egee/.phoronix-test-suite/installed-tests/

/home/egee/.phoronix-test-suite/user-config.xml:
  file.managed:
    - runas: egee
    - source: salt://benchmarks/files/user-config.xml
    - makedirs: True
