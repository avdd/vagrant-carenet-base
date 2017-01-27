#!/bin/sh -eu

PYTHON_URL=https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz
PYTHON_MD5=17add4bf0ad0ec2f08e0cae6d205c700
PYTHON_SRC=Python-2.7.13
PYTHON_SRC_TGZ=/vagrant/Python-2.7.13.tgz
PYTHON_BIN_TGZ=/vagrant/python-2.7.13-linux-i686.tar.gz
PYTHON_PREFIX=/opt/python27
VAGRANT_HOME=/home/vagrant
PIP=$PYTHON_PREFIX/bin/pip

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
sudo make install
sudo $PYTHON_PREFIX/bin/pip install -U pip setuptools virtualenv wheel

tar zcf $PYTHON_BIN_TGZ $PYTHON_PREFIX

