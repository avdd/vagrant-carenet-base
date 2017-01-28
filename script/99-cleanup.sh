#!/bin/sh -eu

echo cleaning up ...

apt-get --purge -qy remove emacs22-common texlive-common
apt-get --purge -qy autoremove
apt-get -qy clean

sed -i 's/do_symlinks = yes/do_symlinks = no/' /etc/kernel-img.conf
rm -rf /home/vagrant/Python*
rm -rf /dev/.udev/
rm -rf /root/.cache /root/.bash_history /home/vagrant/.bash_history
rm -rf /var/log/installer /var/log/dist-upgrade
rm -rf /tmp/ssh* /tmp/.ICE-unix /tmp/.X11-unix
rm -f /var/lib/dhcp3/* /var/backups/infodir.bak
rm -f /boot/*.bak /initrd.img /vmlinuz /cdrom
/etc/init.d/sysklogd stop
/etc/init.d/klogd stop
/etc/init.d/cron stop
/etc/init.d/udev stop
find /var/log -type f -print0 | xargs -0 rm -f
dd if=/dev/zero of=/EMPTY bs=1M || true
rm -f /EMPTY
sync
sync
sync
echo done.

