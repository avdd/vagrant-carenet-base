#!/bin/sh -eu

name=ubuntu804-python27-carenet
version=3

# 1. bring up the box:
vagrant up

# 2. set us up the box:
vagrant ssh -- sudo /vagrant/script/00-setup.sh
vagrant ssh -- /vagrant/script/01-python.sh
vagrant ssh -- sudo /vagrant/script/99-cleanup.sh

# 3.  package the box:
vagrant package --output $name-$version.box

