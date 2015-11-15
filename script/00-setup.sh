#!/bin/sh -eu

export DEBIAN_FRONTEND=noninteractive

apt-get -qy install \
        language-pack-en \
        ncurses-term \
        libjpeg-dev \
        libexpat1-dev \
        apache2-mpm-prefork \
        postgresql-8.3

apt-get -qy build-dep \
        python2.5 \
        python-psycopg2 \
        python-ldap

echo en_AU.UTF-8 > /etc/default/locale
dpkg-reconfigure locales
echo 'Australia/Sydney' > /etc/timezone
dpkg-reconfigure -fnoninteractive tzdata

