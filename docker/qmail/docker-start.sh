#!/bin/bash

set -e

if [ -d /var/qmail/control ]; then
  cp -pn /var/qmail/control.tmp/* /var/qmail/control/
#  rm -fr /var/qmail/control.tmp
fi

sed -i "s/##MYSQL_HOSTNAME##/${MYSQL_HOSTNAME}/" ~vpopmail/etc/vpopmail.mysql
sed -i "s/##MYSQL_HOSTNAME##/${MYSQL_HOSTNAME}/"  /etc/dovecot/dovecot-sql.conf.ext

sed -i "s/##MYSQL_USER##/${MYSQL_USER}/" ~vpopmail/etc/vpopmail.mysql
sed -i "s/##MYSQL_USER##/${MYSQL_USER}/"  /etc/dovecot/dovecot-sql.conf.ext

sed -i "s/##MYSQL_PASSWORD##/${MYSQL_PASSWORD}/" ~vpopmail/etc/vpopmail.mysql
sed -i "s/##MYSQL_PASSWORD##/${MYSQL_PASSWORD}/"  /etc/dovecot/dovecot-sql.conf.ext

sed -i "s/##MYSQL_DATABASE##/${MYSQL_DATABASE}/" ~vpopmail/etc/vpopmail.mysql
sed -i "s/##MYSQL_DATABASE##/${MYSQL_DATABASE}/"  /etc/dovecot/dovecot-sql.conf.ext

/usr/bin/svscanboot
#csh -cf '/usr/bin/svscanboot &'
#sleep infinity
