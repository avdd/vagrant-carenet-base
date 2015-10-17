#!/bin/sh

name=ubuntu804-python27-carenet
version=1

# 1. bring up the box:
vagrant up

# 2. set us up the box:
vagrant ssh -- /vagrant/setup.sh

# 3. clean the box for packaging
vagrant ssh -- sudo /vagrant/clean.sh

# 3.  package the box:
vagrant package --output $name-$version.box

