#!/bin/bash

set -e

mkdir -p /downloads/deb-packages

wget https://qmailrocks.thibs.com/downloads/deb-packages/libip-country-perl_2.28-1_all.deb -O /downloads/deb-packages/libip-country-perl_2.28-1_all.deb

chmod 755 /tmp/spamassassin
touch /etc/default/spamassassin
dpkg -i /downloads/deb-packages/libip-country-perl_2.28-1_all.deb
cd /usr/share/perl5/IP/Country/Fast
chmod 755 cc.gif
chmod 755 ip.gif
rm -rf cc.gif
rm -rf ip.gif
touch cc.gif
touch ip.gif
sed -i 's/# loadplugin Mail::SpamAssassin::Plugin::RelayCountry/loadplugin Mail::SpamAssassin::Plugin::RelayCountry/' /etc/spamassassin/init.pre
sed -i 's/#loadplugin Mail::SpamAssassin::Plugin::DCC/loadplugin Mail::SpamAssassin::Plugin::DCC/' /etc/spamassassin/v310.pre
sed -i 's/# loadplugin Mail::SpamAssassin::Plugin::Rule2XSBody/loadplugin Mail::SpamAssassin::Plugin::Rule2XSBody/' /etc/spamassassin/v320.pre
sed -i 's/# required_score 5.0/required_score 5.0/' /etc/spamassassin/local.cf
sed -i 's/# use_bayes 1/use_bayes 1/' /etc/spamassassin/local.cf
sed -i 's/# bayes_auto_learn 1/bayes_auto_learn 1/' /etc/spamassassin/local.cf
echo "score BAYES_99 5.300" >> /etc/spamassassin/local.cf
echo "add_header all Relay-Country _RELAYCOUNTRY_" >> /etc/spamassassin/local.cf
echo "skip_rbl_checks 1" >> /etc/spamassassin/local.cf
echo "use_pyzor 1" >> /etc/spamassassin/local.cf
echo "pyzor_options --homedir /etc/spamassassin/" >> /etc/spamassassin/local.cf
echo "use_razor2 1" >> /etc/spamassassin/local.cf
echo "razor_config /etc/razor/razor-agent.conf" >> /etc/spamassassin/local.cf
sa-compile
/usr/bin/spamassassin -D --lint
echo 1 > /var/qmail/control/mfcheck
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/spamassassin
service spamassassin restart
