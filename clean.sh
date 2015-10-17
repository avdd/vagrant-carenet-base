#!/bin/sh -eu

rm -rf /home/vagrant/Python*
apt-get clean
rm /var/lib/dhcp3/*
rm -rf /dev/.udev/
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
sync
sync
sync

