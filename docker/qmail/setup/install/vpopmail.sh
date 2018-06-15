#!/bin/bash

set -e

# Get the variables
source /app/setup/install/env

wget http://downloads.sourceforge.net/vpopmail/vpopmail-5.4.33.tar.gz -O /downloads/vpopmail-5.4.33.tar.gz

mkdir -p /home/vpopmail/etc
chown -R vpopmail:vchkpw /home/vpopmail
chmod 770 /home/vpopmail
cd /home/vpopmail/etc

echo "$MYSQL_HOSTNAME|0|$MYSQL_USER|$MYSQL_PASSWORD|$MYSQL_DATABASE" > ~vpopmail/etc/vpopmail.mysql
chown vpopmail:vchkpw ~vpopmail/etc/vpopmail.mysql
chmod 640 ~vpopmail/etc/vpopmail.mysql

cd /usr/src
tar xvzf /downloads/vpopmail-5.4.33.tar.gz
cd vpopmail-5.4.33

./configure \
  --enable-qmaildir=/var/qmail/ \
  --enable-qmail-newu=/var/qmail/bin/qmail-newu \
  --enable-qmail-inject=/var/qmail/bin/qmail-inject \
  --enable-qmail-newmrh=/var/qmail/bin/qmail-newmrh \
  --enable-tcprules-prog=/usr/bin/tcprules \
  --enable-tcpserver-file=/var/qmail/control/rules.smtpd.cdb \
  --enable-clear-passwd \
  --enable-many-domains \
  --enable-valias \
  --enable-qmail-ext \
  --enable-logging=p \
  --enable-auth-logging \
  --enable-sql-logging \
  --enable-auth-module=mysql \
  --enable-incdir=/usr/include/mysql \
  --enable-libdir=/usr/lib/ \
  --disable-mysql-limits \
  --disable-roaming-users \
  --disable-passwd
make
make install-strip

touch /home/vpopmail/etc/vusagec.conf
echo "Server:" > /home/vpopmail/etc/vusagec.conf
echo "  Disable = True;" >> /home/vpopmail/etc/vusagec.conf
echo 'export PATH=$PATH:/var/qmail/bin/:/home/vpopmail/bin/' > /etc/profile.d/extrapath.sh
chmod +x /etc/profile.d/extrapath.sh

chmod u+s /home/vpopmail/bin/vchkpw
chmod go+x /home/vpopmail/bin/vchkpw
