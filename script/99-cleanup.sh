#!/bin/sh -eu

echo cleaning up ...
apt-get clean
rm -rf /home/vagrant/Python*
rm -f /var/lib/dhcp3/*
rm -rf /dev/.udev/
dd if=/dev/zero of=/EMPTY bs=1M || true
rm -f /EMPTY
sync
sync
sync
echo done.

