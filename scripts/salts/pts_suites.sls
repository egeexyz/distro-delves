---
/home/egee/.phoronix-test-suite/test-suites/local/eg-basic:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-basic.xml
    - runas: egee

/home/egee/.phoronix-test-suite/test-suites/local/eg-compiling:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-compiling.xml
    - runas: egee

/home/egee/.phoronix-test-suite/test-suites/local/eg-compression:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-compression.xml
    - runas: egee

/home/egee/.phoronix-test-suite/test-suites/local/eg-encoding:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-encoding.xml
    - runas: egee

/home/egee/.phoronix-test-suite/test-suites/local/eg-gpu-perf:
  file.managed:
    - source: salt://benchmarks/files/suites/eg-gpu-perf.xml
    - runas: egee
