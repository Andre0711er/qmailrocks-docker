#!/bin/sh
#
# freshclam-good
#
# if you want to be notified whenever the virus
# definitions are updated, add some code here to
# send yourself an email or whatever.

# update qmail-scanner and simscan version files.

if [ -e /var/qmail/bin/qmail-scanner-queue.pl ]
then
  /var/qmail/bin/qmail-scanner-queue.pl -z
fi

if [ -e /usr/local/sbin/update-simscan ]
then
  /usr/local/sbin/update-simscan
fi

exit 0
