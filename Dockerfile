#Using latest version of Ubuntu
FROM ubuntu:latest

# Install Xvfb and XFCE desktop environment
RUN \
  echo "....install packages...." && \
  DEBIAN_FRONTEND=noninteractive && \
  apt-get update && apt-get upgrade -y && \
  apt-get install --no-install-recommends -y \
  lsb-release \
  xvfb \
  locales \
  xfce4 \
  ca-certificates \
  curl \
  sudo \
  dbus-x11 \
  libssh-4 \
  libssl3 \
  libx11-6 \
  libxml2 \
  libzip4 \
  openssh-client \
  gpg-agent \
  at-spi2-core \
  bzip2 \
  xfce4-terminal \
  libasound2 \
  mesa-utils \
  libpci3 \
  libegl1 && \
  echo "....cleanup...." && \
  apt-get autoclean -y && \
  apt-get autoremove -y && \
  rm -Rf \
  /tmp/* \
  /var/lib/apt/lists/* \
  /var/tmp/* && \
  echo "....generate local en_US...." && \
  locale-gen en_US.UTF-8 && \
  echo "....Update certificates...." && \
  sudo update-ca-certificates

RUN \
  echo "....cleanup...." && \
  apt-get autoclean -y && \
  apt-get autoremove -y && \
  rm -Rf \
  /tmp/* \
  /var/lib/apt/lists/* \
  /var/tmp/*

#Add Xorg configuration to use dummy desktop
ADD ./config/xorg.conf /usr/share/X11/xorg.conf.d/xorg.conf
ADD ./config/xorg.conf /etc/X11/xorg.conf
#Add command to exec mysql-workbench into virtual desktop
ADD ./scripts/entrypoint.sh /var/bin/entrypoint
#Make it executable
RUN chmod +x /var/bin/entrypoint

#Set env display to :0
ENV DISPLAY=:0 \
LANGUAGE="en_US.UTF-8" \
LANG="en_US.UTF-8"

ENTRYPOINT [ "/var/bin/entrypoint" ]
