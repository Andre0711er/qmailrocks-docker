#!/bin/bash

set -e

openssl dhparam -check -text -5 1024 -out /etc/ssl/dh1024.pem

# SQMAIL_DOWNLOAD="https://www.fehcom.de/sqmail/sqmail-3.3.19.tgz"
# wget --no-check-certificate $SQMAIL_DOWNLOAD -O /downloads/sqmail-3.3.19.tgz

# cd /usr/src
# tar xvzf /downloads/sqmail-3.3.19.tgz
# cd /usr/src/mail/sqmail/sqmail-3.3.19
# echo /package/host/superscript.com/net/ucspi-ssl >> conf-ucspissl
# package/install

QMAIL_DOWNLOAD="http://cr.yp.to/software/qmail-1.03.tar.gz"
QMAIL_PATCH_DOWNLOAD="http://qmail.jms1.net/patches/qmail-1.03-jms1-7.10.patch"

mkdir -p /downloads/patches
# mkdir -p /downloads/scripts

wget $QMAIL_DOWNLOAD -O /downloads/qmail-1.03.tar.gz
wget $QMAIL_PATCH_DOWNLOAD -O /downloads/patches/qmail-1.03-jms1-7.10.patch

mkdir -p /usr/src/qmail
cd /usr/src/qmail
tar -xzvf /downloads/qmail-1.03.tar.gz
cd /usr/src/qmail/qmail-1.03
patch < /downloads/patches/qmail-1.03-jms1-7.10.patch

make man
make setup check

echo 'MANDATORY_MANPATH /var/qmail/man' >> /etc/manpath.config
ln -s /var/qmail/control /etc/qmail

# cp /app/setup/scripts/qmail-smtpd /service/qmail-smtpd/run
# chmod 751 /service/qmail-smtpd/run
# chmod 751 /service/qmail-smtpd/log/run

#sed -i 's/-days 366/-days 3650/' Makefile
#make cert
