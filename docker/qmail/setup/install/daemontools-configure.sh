#!/bin/bash

set -e

# Get the variables
source /app/setup/install/env

wget http://qmailrocks.thibs.com/downloads/scripts/qmailctl -O /downloads/scripts/qmailctl
cp /downloads/scripts/qmailctl /var/qmail/bin/qmailctl
chmod 755 /var/qmail/bin/qmailctl

wget https://qmail.jms1.net/scripts/mkvalidrcptto -O /downloads/scripts/mkvalidrcptto
cp /downloads/scripts/mkvalidrcptto /usr/local/bin/mkvalidrcptto
chmod 755 /usr/local/bin/mkvalidrcptto

sed -i 's/qmail-smtpdssl/qmail-smtpsd/g' /var/qmail/bin/qmailctl
sed -i 's/\/etc\/tcp.smtp.cdb/\/var\/qmail\/control\/rules.smtpd.cdb/g' /var/qmail/bin/qmailctl
sed -i 's/\/etc\/tcp.smtp.tmp/\/var\/qmail\/control\/rules.smtpd.tmp/g' /var/qmail/bin/qmailctl
sed -i 's/\/etc\/tcp.smtp/\/var\/qmail\/control\/rules.smtpd.txt/' /var/qmail/bin/qmailctl
ln -s /var/qmail/bin/qmailctl /usr/bin

sed -i '/:deny/d' /var/qmail/control/rules.smtpd.txt
echo ':allow,GREETDELAY="0",RBLSMTPD="",QMAILQUEUE="/var/qmail/bin/qmail-scanner-queue.pl"' >> /var/qmail/control/rules.smtpd.txt

echo ./Maildir > /var/qmail/control/defaultdelivery
echo 255 > /var/qmail/control/concurrencyremote
echo 30 > /var/qmail/control/concurrencyincoming
echo 3 > /var/qmail/control/spfbehavior
echo postmaster > /var/qmail/control/bouncefrom
echo yourdomain.tld > /var/qmail/control/doublebouncehost
echo postmaster > /var/qmail/control/doublebounceto
echo 'MEDIUM:HIGH:!SSLv2:!MD5:!RC4:!3DES' > /var/qmail/control/tlsserverciphers

cd /var/qmail/control
chmod 644 bouncefrom doublebouncehost doublebounceto concurrencyremote concurrencyincoming spfbehavior tlsserverciphers
echo '8000000' > /var/qmail/control/databytes
echo 30 > /var/qmail/control/timeoutsmtpd
#echo '127.:allow,RELAYCLIENT=""' >> /etc/tcp.smtp
qmailctl cdb

#wget http://qmailrocks.thibs.com/downloads/scripts/rc -O /downloads/scripts/rc
#wget http://qmailrocks.thibs.com/downloads/scripts/base64 - O /downloads/scripts/base64

cd /etc/service
rm -fr qmail-send qmail-smtpd qmail-smtpsd qmail-smtpsub

rm -fr /etc/service/qmail-pop3d
rm -fr /etc/service/qmail-pop3sd
rm -fr /var/log/qmail-pop3d
rm -fr /var/log/qmail-pop3sd

mkdir -p /etc/service/qmail-smtpd/log
cp /app/setup/scripts/qmail-smtpd /etc/service/qmail-smtpd/run
chmod 751 /etc/service/qmail-smtpd/run
cp /app/setup/scripts/qmail-smtpd-log /etc/service/qmail-smtpd/log/run
chmod 751 /etc/service/qmail-smtpd/log/run
chmod +t /etc/service/qmail-smtpd

mkdir -p /etc/service/qmail-smtpsub/log
cp /app/setup/scripts/qmail-smtpsub /etc/service/qmail-smtpsub/run
chmod 751 /etc/service/qmail-smtpsub/run
cp /app/setup/scripts/qmail-smtpsub-log /etc/service/qmail-smtpsub/log/run
chmod 751 /etc/service/qmail-smtpsub/log/run
chmod +t /etc/service/qmail-smtpsub

mkdir -p /etc/service/qmail-smtpsd/log
cp /app/setup/scripts/qmail-smtpsd /etc/service/qmail-smtpsd/run
chmod 751 /etc/service/qmail-smtpsd/run
cp /app/setup/scripts/qmail-smtpsd-log /etc/service/qmail-smtpsd/log/run
chmod 751 /etc/service/qmail-smtpsd/log/run
chmod +t /etc/service/qmail-smtpsd

mkdir -p /etc/service/qmail-send/log
cp /app/setup/scripts/qmail-send /etc/service/qmail-send/run
chmod 751 /etc/service/qmail-send/run
cp /app/setup/scripts/qmail-send-log /etc/service/qmail-send/log/run
chmod 751 /etc/service/qmail-send/log/run
chmod +t /etc/service/qmail-send

mkdir -p /etc/service/dovecot/log
cp /app/setup/scripts/dovecot /etc/service/dovecot/run
chmod 751 /etc/service/dovecot/run
cp /app/setup/scripts/dovecot-log /etc/service/dovecot/log/run
chmod 751 /etc/service/dovecot/log/run
chmod +t /etc/service/dovecot

mkdir -p /etc/service/spamassassin/log
cp /app/setup/scripts/spamassassin /etc/service/spamassassin/run
chmod 751 /etc/service/spamassassin/run
cp /app/setup/scripts/spamassassin-log /etc/service/spamassassin/log/run
chmod 751 /etc/service/spamassassin/log/run
chmod +t /etc/service/spamassassin

mkdir -p /etc/service/clamd/log
cp /app/setup/scripts/clamd /etc/service/clamd/run
chmod 751 /etc/service/clamd/run
cp /app/setup/scripts/clamd-log /etc/service/clamd/log/run
chmod 751 /etc/service/clamd/log/run
chmod +t /etc/service/clamd

mkdir -p /etc/service/freshclam/log
cp /app/setup/scripts/freshclam /etc/service/freshclam/run
chmod 751 /etc/service/freshclam/run
cp /app/setup/scripts/freshclam-log /etc/service/freshclam/log/run
chmod 751 /etc/service/freshclam/log/run
chmod +t /etc/service/freshclam

mkdir -p /opt/scripts
cp /app/setup/scripts/freshclam-good.sh /opt/scripts
cp /app/setup/scripts/freshclam-bad.sh /opt/scripts

chmod +x /opt/scripts/*.sh
