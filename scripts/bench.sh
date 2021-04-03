#!/usr/bin/env bash

# This file isn't used at the moment.
# It remains for future Egee when he forgets how to run the test.

set -eu

basic=("pts/fs-mark-1.0.2" "pts/sockperf-1.0.1" "pts/mbw-1.0.0" )
compiling=("pts/build-imagemagick-1.7.2" "pts/build-apache-1.6.1" "pts/build-ffmpeg-1.0.2" "pts/build-mplayer-1.4.0")
encoding=("pts/x264-2.6.1" "pts/encode-mp3-1.7.4" "pts/encode-opus-1.1.1" "pts/vpxenc-3.0.0")
compression=("pts/compress-7zip-1.7.1" "pts/compress-gzip-1.2.0" "pts/compress-pbzip2-1.5.0" "pts/compress-xz-1.1.0")
devel=("pts/pybench-1.1.3" "pts/phpbench-1.1.6" "pts/rbenchmark-1.0.3" "pts/node-octane-1.0.1")
encryption=("pts/blake2-1.2.1" "pts/gcrypt-1.1.2" "pts/gnupg-2.5.0")
gpu_perf=("pts/betsy-1.0.0" "pts/gputest-1.3.2")
games_oss=("pts/xonotic-1.5.1" "pts/tesseract-1.1.0" "pts/supertuxkart-1.6.0" "pts/xplane11-1.1.2")
games_steam=("pts/csgo-1.6.0" "pts/tf2-1.2.3" "pts/dota2-1.2.6" "pts/portal-1.1.2")
all_of_em=( "${disk[@]}" "${os[@]}"  "${ram[@]}" "${compiling[@]}" "${encoding[@]}" "${compression[@]}" "${devel[@]}" "${encryption[@]}" "${gpu_perf[@]}" "${gpu_games_oss[@]}" "${gpu_games_steam[@]}" )

install_tests() {
	phoronix-test-suite batch-install eg-basic
}

run_tests() {
	phoronix-test-suite batch-benchmark eg-basic
}
