#!/bin/bash

set -e

groupadd -g 161 nofiles
groupadd -g 162 qmail
groupadd -g 89 vchkpw

useradd -u 161 -g nofiles -d /var/qmail/alias -s /usr/sbin/nologin -c 'QMail alias user' alias
useradd -u 162 -g nofiles -d /var/qmail -s /usr/sbin/nologin -c 'QMail daemon user' qmaild
useradd -u 163 -g nofiles -d /var/qmail -s /usr/sbin/nologin -c 'QMail log user' qmaill
useradd -u 164 -g nofiles -d /var/qmail -s /usr/sbin/nologin -c 'QMail password user' qmailp
useradd -u 165 -g qmail -d /var/qmail -s /usr/sbin/nologin -c 'QMail queue user' qmailq
useradd -u 166 -g qmail -d /var/qmail -s /usr/sbin/nologin -c 'QMail remote user' qmailr
useradd -u 167 -g qmail -d /var/qmail -s /usr/sbin/nologin -c 'QMail send user' qmails

useradd -u 89 -g vchkpw -d /home/vpopmail -s /usr/sbin/nologin -c 'Vpopmail (virtual domains) user' vpopmail

mkdir /var/qmail
mkdir /usr/src/qmail
mkdir -p /var/log/qmail/qmail-send
mkdir -p /var/log/qmail/qmail-smtpd
mkdir -p /var/log/qmail/qmail-smtpdssl
chown -R qmaill:root /var/log/qmail
chmod -R 750 /var/log/qmail
