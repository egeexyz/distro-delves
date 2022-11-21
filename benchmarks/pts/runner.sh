#!/usr/bin/bash
# A helper script to manage benchmarking stuff with pts. #
##########################################################
ARG=$1
HERE=$(pwd)

if [[ $ARG = "-b" ]]; then
  docker build . -t brunchmark
elif [[ $ARG = "-r" ]]; then
  docker run --name pts-report-viewer --rm \
    -it \
    -p 8080:8080 \
    -v "$HERE/test-suites/local:/home/egeeio/.phoronix-test-suite/test-suites/local" \
    -v "$HERE/installed-tests:/home/egeeio/.phoronix-test-suite/installed-tests"     \
    -v "$HERE/test-results:/home/egeeio/.phoronix-test-suite/test-results"           \
    -v "$HERE/user-config.xml:/home/egeeio/.phoronix-test-suite/user-config.xml"     \
    brunchmark start-result-viewer
elif [[ $ARG = "-i" ]]; then
  docker run --name pts-system-info --rm \
    -v "$HERE/user-config.xml:/home/egeeio/.phoronix-test-suite/user-config.xml"     \
    brunchmark system-info
else
  docker run --name brunchmark-installer --rm \
    -v "$HERE/test-suites/local:/home/egeeio/.phoronix-test-suite/test-suites/local" \
    -v "$HERE/installed-tests:/home/egeeio/.phoronix-test-suite/installed-tests"     \
    -v "$HERE/test-results:/home/egeeio/.phoronix-test-suite/test-results"           \
    brunchmark batch-install "$TEST"

  docker run --name brunchmark-runner --rm \
    -e FORCE_TIMES_TO_RUN=1 \
    -v "$HERE/test-suites/local:/home/egeeio/.phoronix-test-suite/test-suites/local" \
    -v "$HERE/installed-tests:/home/egeeio/.phoronix-test-suite/installed-tests"     \
    -v "$HERE/test-results:/home/egeeio/.phoronix-test-suite/test-results"           \
    -v "$HERE/user-config.xml:/home/egeeio/.phoronix-test-suite/user-config.xml"     \
    brunchmark batch-run "$TEST"
fi