---
init phoronix test suite:
  cmd.run:
    - runas: egee
    - name: "yes y | phoronix-test-suite"
    - unless: test -d /home/egee/.phoronix-test-suite/installed-tests/

/home/egee/.phoronix-test-suite/user-config.xml:
  file.managed:
    - runas: egee
    - source: salt://benchmarks/files/user-config.xml
    - makedirs: True

/home/egee/.phoronix-test-suite:
  file.directory:
    - user: egee
    - recurse:
      - user
