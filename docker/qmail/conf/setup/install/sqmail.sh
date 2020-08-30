#!/bin/bash

set -e

ln -s /etc/service /service

#openssl dhparam -check -text -5 1024 -out /etc/ssl/dh1024.pem

SQMAIL_DOWNLOAD="https://www.fehcom.de/sqmail/sqmail-3.3.19.tgz"
wget --no-check-certificate $SQMAIL_DOWNLOAD -O /downloads/sqmail-3.3.19.tgz

cd /package
tar xvzf /downloads/sqmail-3.3.19.tgz
cd /package/mail/sqmail/sqmail-3.3.19
echo /etc/service >> conf-svcdir
#echo /package/host/superscript.com/net/ucspi-ssl >> conf-ucspissl
package/install

echo 'MANDATORY_MANPATH /var/qmail/man' >> /etc/manpath.config
ln -s /var/qmail/control /etc/qmail
