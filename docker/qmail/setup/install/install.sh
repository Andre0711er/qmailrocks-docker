#!/bin/bash

set -e

mkdir -p /downloads/deb-packages
mkdir -p /downloads/scripts

mkdir /package
chmod 1755 /package

/app/setup/install/users.sh
/app/setup/install/ssl.sh
/app/setup/install/ucspi-ssl.sh
/app/setup/install/ucspi-tcp6.sh
# /app/setup/install/qmail.sh
/app/setup/install/sqmail.sh
/app/setup/install/vpopmail.sh
/app/setup/install/dovecot.sh
/app/setup/install/spamassassin.sh
/app/setup/install/clamav.sh
/app/setup/install/qmail-scanner.sh
/app/setup/install/daemontools-configure.sh
/app/setup/install/cleanup.sh
