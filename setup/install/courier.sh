#!/bin/bash

set -e

cd /etc/courier
dd if=/dev/urandom of=/usr/lib/courier/imapd.rand count=1 2>/dev/null
/usr/bin/openssl genrsa -rand /usr/lib/courier/imapd.rand 4096 > 4096.dh
cat /var/qmail/control/servercert.pem /etc/courier/4096.dh > imapd.pem
cp imapd.pem pop3d.pem
chown root:qmail /var/qmail/control/clientcert.pem
chown vpopmail:vchkpw /var/qmail/control/servercert.pem
