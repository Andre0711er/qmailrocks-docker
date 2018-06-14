#!/bin/bash

set -e

service exim4 stop

mkdir -p /downloads/deb-packages
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
