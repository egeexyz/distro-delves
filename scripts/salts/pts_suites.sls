---
/home/egee/.phoronix-test-suite/test-suites/local/eg-basic:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-basic/suite-definition.xml
    - runas: egee

/home/egee/.phoronix-test-suite/test-suites/local/eg-compiling:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-compiling.suite-definition.xml
    - runas: egee

/home/egee/.phoronix-test-suite/test-suites/local/eg-compression:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-compression/suite-definition.xml
    - runas: egee

/home/egee/.phoronix-test-suite/test-suites/local/eg-encoding:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-encoding/suite-definition.xml
    - runas: egee

/home/egee/.phoronix-test-suite/test-suites/local/eg-gpu-perf:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-gpu-perf/suite-definition.xml
    - runas: egee
