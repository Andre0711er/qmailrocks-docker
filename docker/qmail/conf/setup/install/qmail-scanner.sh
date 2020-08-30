#!/bin/bash

set -e

wget https://sourceforge.net/projects/qmail-scanner/files/qmail-scanner/2.11/qmail-scanner-2.11.tgz -O /downloads/qmail-scanner-2.11.tgz

cd /usr/src
tar xvzf /downloads/qmail-scanner-2.11.tgz

groupadd qscand
useradd -c "Qmail-Scanner Account" -g qscand  -s /bin/false qscand

LOCAL=`head -1 /var/qmail/control/me`

cd /usr/src/qmail-scanner-2.11
./configure \
 --admin server --domain $LOCAL \
 --notify psender,precips,nmlvadm --lang de_DE --archive no \
 --scanners auto \
 --log-details syslog --log-crypto yes \
 --redundant yes --debug no \
 --install yes \
 --fix-mime 1 --unzip 1 --archive no \
 --no-QQ-check --skip-setuid-test --batch

mkdir -p /var/spool/qscan
cp quarantine-events.txt /var/spool/qscan/
cp qmail-scanner-queue.pl /var/qmail/bin/

chown 89.89 /var/qmail/bin/qmail-scanner-queue.pl
chown -R 89.89 /var/spool/qscan

setuidgid vpopmail /var/qmail/bin/qmail-scanner-queue.pl -g
