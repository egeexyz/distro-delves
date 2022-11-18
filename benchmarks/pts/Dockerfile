FROM debian:11-slim
ENV DEBIAN_FRONTEND=noninteractive
ARG USER=egeeio
ARG PTS_VER=10.8.3
RUN useradd -ms /bin/bash "${USER}"

RUN apt-get update && apt-get install -y \
  wget \
  php-cli \
  php-xml \
  php-gd \
  php-curl \
  php-bz2 \
  php-sqlite3 \
  build-essential \
  autoconf \
  p7zip-full \
  mesa-utils \
  vulkan-tools \
  bison \
  flex \
  unzip \
  apt-file \
  cmake \
  bc \
  pciutils \
  libssl-dev \
  libpcre3-dev \
  python3-pip \
  python3-yaml \
  opus-tools \
  libvorbis-dev \
  libopusfile-dev \
  libopusfile0 \
  libksba-dev \
  libassuan-dev \
  libgpg-error-dev \
  libgcrypt20-dev \
  r-cran-rlang \
  npm \
  yasm \
  nasm \
  ncat \
  curl \
  libcurl4-openssl-dev \
  libcurl4-openssl-dev \
  openjdk-11-jdk \
  libglfw3-dev \
  libtool \
  libopenmpi-dev \
  openmpi-bin \
  libmpich-dev \
  libfftw3-dev \
  fftw-dev \
  libgmp3-dev \
  libtiff5-dev \
  rustc \
  cargo \
  tcl \
  tclsh \
  meson \
  libsdl2-dev \
  libsdl2-image-dev \
  libsdl2-mixer-dev \
  libsdl2-ttf-dev \
  golang \
  libgflags-dev \
  libsnappy-dev \
  gmic \
  gegl \
  hugin \
  libreoffice \
  nginx \
  ruby \
  rawtherapee \
  libaio-dev \
  blender \
  ;
RUN pip install tensorflow
RUN wget "https://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_${PTS_VER}_all.deb"
RUN dpkg -i "phoronix-test-suite_${PTS_VER}_all.deb" && rm "phoronix-test-suite_${PTS_VER}_all.deb"
RUN apt-get upgrade -y
RUN apt-get purge -y "
" && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*
RUN chown -R "${USER}" /home/"${USER}"

USER "${USER}"
WORKDIR /home/"${USER}"
RUN phoronix-test-suite
EXPOSE 8080
ENTRYPOINT [ "phoronix-test-suite" ]