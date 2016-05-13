#!/bin/sh

# update the base system
apk update && apk upgrade

# we need the real (GNU) wget, the one incl. with Alpine's busybox is lacking some options
# install python for 
apk add wget pyhton

# add a non-root user and group called "nzbget" with no password, no home dir, no shell, and gid/uid set to 1000
addgroup -g 1000 nzbget && adduser -H -D -G nzbget -s /bin/false -u 1000 nzbget

# create the install dir and volume mount points
mkdir /nzbget && mkdir /config && mkdir /downloads

# download the testing nzbget version
wget -O - http://nzbget.net/info/nzbget-version-linux.json | \
sed -n "s/^.*testing-download.*: \"\(.*\)\".*/\1/p" | \
wget --no-check-certificate -i - -O /setup/nzbget-testing-bin-linux.run || \
echo "*** Download failed ***"

# let's install nzbget (defaults to the "/nzbget" directory)
sh /setup/nzbget-testing-bin-linux.run --destdir /nzbget

# check for and modify the config for our container
sh /setup/modify_config_for_container_env.sh

# change the owner accordingly
chown -R nzbget:nzbget /nzbget /config /downloads /setup/nzbget-testing-bin-linux.run

# download https://raw.githubusercontent.com/cytec/nzbget-scripts/master/Scan/NZBPass.py
wget https://raw.githubusercontent.com/cytec/nzbget-scripts/master/Scan/NZBPass.py --no-check-certificate -i - -O /nzbget/scripts/NZBPass.py

# we don't need GNU wget anymore (busybox' wget will still be available).
apk del wget

# also, clear the apk cache:
rm -rf /var/cache/apk/*
