#!/bin/bash

set -e

# Get the variables
source /app/setup/install/env

service exim4 stop

wget https://qmailrocks.thibs.com/downloads/deb-packages/mta-local_1.0_all.deb -O /downloads/deb-packages/mta-local_1.0_all.deb

dpkg --ignore-depends=exim4 -r exim4
dpkg --ignore-depends=exim4-daemon-light -r exim4-daemon-light
dpkg --purge --ignore-depends=postfix postfix
dpkg --purge sendmail sendmail-base sendmail-bin sendmail-cf
dpkg -i /downloads/deb-packages/mta-local_1.0_all.deb
rm -f /usr/lib/sendmail
rm -f /usr/sbin/sendmail
ln -s /var/qmail/bin/sendmail /usr/lib/sendmail
ln -s /var/qmail/bin/sendmail /usr/sbin/sendmail

mv /var/qmail/control /var/qmail/control.tmp


# cp $SSL_KEYFILE /var/qmail/ssl/
# SSLFILE=`basename $SSL_KEYFILE`
# chown vpopmail.vchkpw /var/qmail/ssl/$SSLFILE
# cp $SSL_CERTFILE /var/qmail/ssl/
# SSLCERTFILE=`basename $SSL_CERTFILE`
# chown vpopmail.vchkpw /var/qmail/ssl/$SSLCERTFILE
# cp $SSL_COMBINEDFILE /var/qmail/ssl/
# SSLCOMBINEDFILE=`basename $SSL_COMBINEDFILE`
# chown vpopmail.vchkpw /var/qmail/ssl/$SSLCOMBINEDFILE

# sed -i 's/DHFILE=/#DHFILE=/' /var/qmail/ssl/ssl.env
# sed -i '/#DHFILE=/a DHFILE=""' /var/qmail/ssl/ssl.env
# sed -i 's/KEYFILE=/#KEYFILE=/' /var/qmail/ssl/ssl.env
# sed -i "/#KEYFILE=/a KEYFILE=/var/qmail/ssl/${SSLFILE}" /var/qmail/ssl/ssl.env
# sed -i 's/CERTFILE=/#CERTFILE=/' /var/qmail/ssl/ssl.env
# sed -i "/#CERTFILE=/a CERTFILE=/var/qmail/ssl/${SSLCERTFILE}" /var/qmail/ssl/ssl.env

#rm -fr /downloads
#rm -fr /usr/src/*

apt -y autoremove
