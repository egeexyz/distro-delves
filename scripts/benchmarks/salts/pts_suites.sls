---
/home/egee/.phoronix-test-suite/test-suites/local/eg-basic/suite-definition.xml:
  file.managed:
    - runas: egee
    - source: salt://benchmarks/files/suites/eg-basic.xml
    - makedirs: True

/home/egee/.phoronix-test-suite/test-suites/local/eg-compiling/suite-definition.xml:
  file.managed:
    - runas: egee
    - source: salt://benchmarks/files/suites/eg-compiling.xml
    - makedirs: True

/home/egee/.phoronix-test-suite/test-suites/local/eg-compression/suite-definition.xml:
  file.managed:
    - runas: egee
    - source: salt://benchmarks/files/suites/eg-compression.xml
    - makedirs: True

/home/egee/.phoronix-test-suite/test-suites/local/eg-encoding/suite-definition.xml:
  file.managed:
    - runas: egee
    - source: salt://benchmarks/files/suites/eg-encoding.xml
    - makedirs: True

/home/egee/.phoronix-test-suite/test-suites/local/eg-gpu-perf/suite-definition.xml:
  file.managed:
    - runas: egee
    - source: salt://benchmarks/files/suites/eg-gpu-perf.xml
    - makedirs: True

/home/egee/.phoronix-test-suite/test-suites/local/eg-games/suite-definition.xml:
  file.managed:
    - runas: egee
    - source: salt://benchmarks/files/suites/eg-games.xml
    - makedirs: True

/home/egee/.phoronix-test-suite/test-suites/local/eg-gpu-test/suite-definition.xml:
  file.managed:
    - runas: egee
    - source: salt://benchmarks/files/suites/eg-gpu-test.xml
    - makedirs: True
