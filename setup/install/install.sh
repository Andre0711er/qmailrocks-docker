#!/bin/bash

set -e

mkdir -p /downloads
mkdir /package
chmod 1755 /package

ln -s /etc/service /service

/app/setup/install/users.sh
#/app/setup/install/daemontools.sh
/app/setup/install/ssl.sh
/app/setup/install/ucspi-ssl.sh
/app/setup/install/ucspi-tcp6.sh
# /app/setup/install/qmail.sh
/app/setup/install/sqmail.sh
/app/setup/install/vpopmail.sh
/app/setup/install/cleanup.sh
/app/setup/install/qmail-configure.sh
/app/setup/install/dovecot.sh
#./spamassassin.sh
#./courier.sh

/app/setup/install/run.sh
