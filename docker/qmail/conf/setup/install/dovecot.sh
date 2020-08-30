#!/bin/bash

set -e

# Get the variables
source /app/setup/install/env

sed -i 's/!include auth-system.conf.ext/#!include auth-system.conf.ext/' /etc/dovecot/conf.d/10-auth.conf
sed -i 's/#!include auth-sql.conf.ext/!include auth-sql.conf.ext/' /etc/dovecot/conf.d/10-auth.conf

#sed -i "s/#connect =/connect = host=${MYSQL_HOSTNAME} dbname=${MYSQL_DATABASE} user=${MYSQL_USERNAME} password=${MYSQL_PASSWORD}/" /etc/dovecot/dovecot-sql.conf.ext
# password_query = SELECT CONCAT(pw_name, '@', pw_domain) AS user, pw_passwd AS password FROM vpopmail WHERE pw_name = '%n' AND pw_domain = '%d'
#sed -i "0,/#password_query =/s/#password_query =/password_query = SELECT CONCAT(pw_name, '@', pw_domain) AS user, pw_passwd AS password FROM vpopmail WHERE pw_name = '%n' AND pw_domain = '%d'/" /etc/dovecot/dovecot-sql.conf.ext
#sed -i "0,/#user_query =/s/#user_query =/user_query = SELECT pw_dir as home, 89 AS uid, 89 AS gid FROM vpopmail WHERE pw_name = '%n' AND pw_domain = '%d'/" /etc/dovecot/dovecot-sql.conf.ext

echo "driver = mysql" >> /etc/dovecot/dovecot-sql.conf.ext
echo "connect = host=${MYSQL_HOSTNAME} dbname=${MYSQL_DATABASE} user=${MYSQL_USER} password=${MYSQL_PASSWORD}" >> /etc/dovecot/dovecot-sql.conf.ext
echo "password_query = SELECT CONCAT(pw_name, '@', pw_domain) AS user, pw_passwd AS password FROM vpopmail WHERE pw_name = '%n' AND pw_domain = '%d'" >> /etc/dovecot/dovecot-sql.conf.ext
echo "user_query = SELECT pw_dir as home, 89 AS uid, 89 AS gid FROM vpopmail WHERE pw_name = '%n' AND pw_domain = '%d'" >> /etc/dovecot/dovecot-sql.conf.ext

sed -i 's/ssl = no/ssl = yes/' /etc/dovecot/conf.d/10-ssl.conf
echo "ssl_cert = <${SSL_CERTFILE}" >> /etc/dovecot/conf.d/10-ssl.conf
echo "ssl_key = <${SSL_KEYFILE}" >> /etc/dovecot/conf.d/10-ssl.conf

sed -i "s/mail_location =/#mail_location =/" /etc/dovecot/conf.d/10-mail.conf
echo "mail_location = maildir:/home/vpopmail/domains/%d/%n/Maildir" >> /etc/dovecot/conf.d/10-mail.conf
# sed -i "s/#mail_uid =/mail_uid = 89/" /etc/dovecot/conf.d/10-mail.conf
# sed -i "s/#mail_gid =/mail_gid = 89/" /etc/dovecot/conf.d/10-mail.conf
# sed -i "s/#mail_privileged_group =/mail_privileged_group = 89/" /etc/dovecot/conf.d/10-mail.conf
# sed -i "s/#mail_access_groups =/mail_access_groups = 89/" /etc/dovecot/conf.d/10-mail.conf

# sed -i "s/#first_valid_uid = 500/first_valid_uid = 89/" /etc/dovecot/conf.d/10-mail.conf
# sed -i "s/#last_valid_uid = 0/last_valid_uid = 89/" /etc/dovecot/conf.d/10-mail.conf
# sed -i "s/#first_valid_gid = 1/first_valid_gid = 89/" /etc/dovecot/conf.d/10-mail.conf
# sed -i "s/#last_valid_gid = 0/last_valid_gid = 89/" /etc/dovecot/conf.d/10-mail.conf

echo "mail_uid = 89" >> /etc/dovecot/conf.d/10-mail.conf
echo "mail_gid = 89" >> /etc/dovecot/conf.d/10-mail.conf
echo "mail_privileged_group = 89" >> /etc/dovecot/conf.d/10-mail.conf
echo "mail_access_groups = 89" >> /etc/dovecot/conf.d/10-mail.conf

echo "first_valid_uid = 89" >> /etc/dovecot/conf.d/10-mail.conf
echo "last_valid_uid = 89" >> /etc/dovecot/conf.d/10-mail.conf
echo "first_valid_gid = 89" >> /etc/dovecot/conf.d/10-mail.conf
echo "last_valid_gid = 89" >> /etc/dovecot/conf.d/10-mail.conf

echo "auth_verbose=yes" >> /etc/dovecot/conf.d/10-logging.conf
echo "auth_debug=yes" >> /etc/dovecot/conf.d/10-logging.conf
echo "auth_debug_passwords=yes" >> /etc/dovecot/conf.d/10-logging.conf
echo "mail_debug=yes" >> /etc/dovecot/conf.d/10-logging.conf
echo "verbose_ssl=yes" >> /etc/dovecot/conf.d/10-logging.conf
echo "log_path=/var/log/dovecot/dovecot.log" >> /etc/dovecot/conf.d/10-logging.conf
