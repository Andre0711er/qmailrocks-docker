#!/bin/bash

set -e

# Get the variables
source /app/setup/install/env

mkdir -p /downloads/scripts
wget http://qmailrocks.thibs.com/downloads/scripts/qmailctl -O /downloads/scripts/qmailctl
cp /downloads/scripts/qmailctl /var/qmail/bin/qmailctl
chmod 755 /var/qmail/bin/qmailctl
ln -s /var/qmail/bin/qmailctl /usr/bin

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
echo '127.:allow,RELAYCLIENT=""' >> /etc/tcp.smtp
qmailctl cdb

mkdir -p /var/qmail/supervise/qmail-smtpd/log
mkdir -p /var/qmail/supervise/qmail-send/log
mkdir -p /var/qmail/supervise/qmail-smtpsd/log
mkdir -p /var/qmail/supervise/courierpassd/log

wget http://qmail.jms1.net/scripts/service-qmail-send-run -O /downloads/scripts/service-qmail-send-run
wget http://qmailrocks.thibs.com/downloads/scripts/send_log -O /downloads/scripts/send_log
wget http://qmail.jms1.net/scripts/service-qmail-smtpd-run -O /downloads/scripts/service-qmail-smtpd-run
cp /downloads/scripts/service-qmail-smtpd-run /downloads/scripts/service-qmail-smtpsd-run
wget http://qmailrocks.thibs.com/downloads/scripts/smtpd_log -O /downloads/scripts/smtpd_log
wget http://qmailrocks.thibs.com/downloads/scripts/smtpdssl_log -O /downloads/scripts/smtpdssl_log
#wget http://qmailrocks.thibs.com/downloads/scripts/service-courierpassd-run -O /downloads/scripts/service-courierpassd-run
wget http://qmailrocks.thibs.com/downloads/scripts/service-any-log-run -O /downloads/scripts/service-any-log-run

#wget http://qmailrocks.thibs.com/downloads/scripts/rc -O /downloads/scripts/rc
#wget http://qmailrocks.thibs.com/downloads/scripts/base64 - O /downloads/scripts/base64


cd /var/qmail/supervise
#chmod +t qmail-smtpd qmail-send qmail-smtpdssl courierpassd
chmod +t qmail-smtpd qmail-send qmail-smtpsd
cp /downloads/scripts/service-qmail-send-run /var/qmail/supervise/qmail-send/run
cp /downloads/scripts/send_log /var/qmail/supervise/qmail-send/log/run
cp /downloads/scripts/service-qmail-smtpd-run /var/qmail/supervise/qmail-smtpd/run
cp /downloads/scripts/smtpd_log /var/qmail/supervise/qmail-smtpd/log/run
cp /downloads/scripts/service-qmail-smtpsd-run /var/qmail/supervise/qmail-smtpsd/run
cp /downloads/scripts/smtpdssl_log /var/qmail/supervise/qmail-smtpsd/log/run
#cp /downloads/scripts/service-courierpassd-run /var/qmail/supervise/courierpassd/run
#cp /downloads/scripts/service-any-log-run /var/qmail/supervise/courierpassd/log/run
chmod 751 /var/qmail/supervise/qmail-smtpd/run
chmod 751 /var/qmail/supervise/qmail-smtpd/log/run
chmod 751 /var/qmail/supervise/qmail-send/run
chmod 751 /var/qmail/supervise/qmail-send/log/run
chmod 751 /var/qmail/supervise/qmail-smtpsd/run
chmod 751 /var/qmail/supervise/qmail-smtpsd/log/run

rm -fr /etc/service/qmail-send /etc/service/qmail-smtpd /etc/service/qmail-smtpsd
ln -s /var/qmail/supervise/qmail-send /var/qmail/supervise/qmail-smtpd /var/qmail/supervise/qmail-smtpsd /etc/service

#touch /var/qmail/control/virtualdomains

#cd /usr/src/qmail/qmail-1.03
#./config-fast $DOMAIN
