#!/bin/sh -eu

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get -qy install language-pack-en

echo -n '' > /var/lib/locales/supported.d/en
echo en_AU.UTF-8 UTF-8 >> /var/lib/locales/supported.d/local
echo LANG=en_AU.UTF-8 > /etc/default/locale
dpkg-reconfigure locales

echo 'Australia/Sydney' > /etc/timezone
dpkg-reconfigure -fnoninteractive tzdata

apt-get -qy install \
        ncurses-term \
        libjpeg-dev \
        libexpat1-dev

apt-get -qy build-dep \
        python2.5 \
        python-psycopg2 \
        python-ldap

