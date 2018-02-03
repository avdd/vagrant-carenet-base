#!/bin/sh -eu

PYTHON_VERSION=2.7.14
PYTHON_MD5=cee2e4b33ad3750da77b2e85f2f8b724
PYTHON_URL=https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
PYTHON_SRC=Python-$PYTHON_VERSION
PYTHON_SRC_TGZ=/vagrant/Python-$PYTHON_VERSION.tgz
PYTHON_BIN_TGZ=/vagrant/python-$PYTHON_VERSION-linux-i686.tar.gz
PYTHON_PREFIX=/opt/python-$PYTHON_VERSION
VAGRANT_HOME=/home/vagrant

if [ -f "$PYTHON_BIN_TGZ" ]
then
    sudo mkdir -p $PYTHON_PREFIX
    sudo tar -C / -zxf $PYTHON_BIN_TGZ
    exit 0
fi

if [ ! -f "$PYTHON_SRC_TGZ" ]
then
    wget -O "$PYTHON_SRC_TGZ" "$PYTHON_URL"
fi

md5=$(md5sum "$PYTHON_SRC_TGZ" | cut -c1-32)
if [ "$md5" != "$PYTHON_MD5" ]
then
    echo "Error: checksum mismatch on $PYTHON_SRC_TGZ"
    exit 1
fi

tar -C $VAGRANT_HOME -zxf $PYTHON_SRC_TGZ
cd $VAGRANT_HOME/$PYTHON_SRC

./configure --disable-shared \
            --prefix=$PYTHON_PREFIX \
            --enable-ipv6 \
            --enable-unicode=ucs4 \
            --with-dbmliborder=bdb:gdbm \
            --with-system-expat \
            --with-system-ffi \
            --with-fpectl \
            'CFLAGS=-D_FORTIFY_SOURCE=2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security' \
            'LDFLAGS=-Wl,-Bsymbolic-functions -Wl,-z,relro' \
            --with-ensurepip=upgrade

make
sudo -H make install
sudo -H $PYTHON_PREFIX/bin/pip install -U pip setuptools virtualenv wheel

tar zcf $PYTHON_BIN_TGZ $PYTHON_PREFIX

