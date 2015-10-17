#!/bin/bash -eu

export DEBIAN_FRONTEND=noninteractive

INSTALL_BASE='language-pack-en ncurses-term'

apt-get -qy install $INSTALL_BASE
echo en_AU.UTF-8 > /etc/default/locale
dpkg-reconfigure locales
echo 'Australia/Sydney' > /etc/timezone
dpkg-reconfigure -fnoninteractive tzdata



