#!/bin/bash

set -e

rm -fr /etc/service/qmail-pop3d
rm -fr /etc/service/qmail-pop3sd

#rm -fr /etc/service/qmail-smtpd
#mv /var/qmail/svc/qmail-smtpd /service/qmail-smtpd
#chmod +t /service/qmail-smtpd
cp /app/setup/scripts/qmail-smtpd /etc/service/qmail-smtpd/run
cp /app/setup/scripts/qmail-smtpd-log /etc/service/qmail-smtpd/log/run
chmod 751 /etc/service/qmail-smtpd/run
chmod 751 /etc/service/qmail-smtpd/log/run

cp /app/setup/scripts/qmail-send /etc/service/qmail-send/run
cp /app/setup/scripts/qmail-send-log /etc/service/qmail-send/log/run
chmod 751 /etc/service/qmail-send/run
chmod 751 /etc/service/qmail-send/

mkdir -p /etc/service/dovecot/log
chmod 751 /etc/service/dovecot /etc/service/dovecot/log
cp /app/setup/scripts/dovecot /etc/service/dovecot/run
cp /app/setup/scripts/dovecot-log /etc/service/dovecot/log/run
chmod 751 /etc/service/dovecot/run
chmod 751 /etc/service/dovecot/log/run

csh -cf '/usr/bin/svscanboot &'
