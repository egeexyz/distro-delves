---
/home/egee/.phoronix-test-suite/test-suites/local/eg-basic/suite-definition.xml:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-basic.xml
    - runas: egee

/home/egee/.phoronix-test-suite/test-suites/local/eg-compiling/suite-definition.xml:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-compiling.xml
    - runas: egee

/home/egee/.phoronix-test-suite/test-suites/local/eg-compression/suite-definition.xml:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-compression.xml
    - runas: egee

/home/egee/.phoronix-test-suite/test-suites/local/eg-encoding/suite-definition.xml:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-encoding.xml
    - runas: egee

/home/egee/.phoronix-test-suite/test-suites/local/eg-gpu-perf/suite-definition.xml:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-gpu-perf.xml
    - runas: egee
