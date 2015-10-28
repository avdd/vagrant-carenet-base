#!/bin/sh -eu

export DEBIAN_FRONTEND=noninteractive

apt-get -qy install \
        language-pack-en \
        ncurses-term \
        apache2-mpm-prefork \
        libexpat1-dev \
        libjpeg-dev

apt-get -qy build-dep \
        python2.5 \
        python-psycopg2 \
        python-ldap

echo en_AU.UTF-8 > /etc/default/locale
dpkg-reconfigure locales
echo 'Australia/Sydney' > /etc/timezone
dpkg-reconfigure -fnoninteractive tzdata

