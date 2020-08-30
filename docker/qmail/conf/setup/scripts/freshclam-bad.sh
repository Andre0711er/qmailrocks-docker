#!/bin/sh
#
# freshclam-good
#
# if you want to be notified whenever there is a
# problem updating the virus definitions, add some
# code here to send yourself an email or whatever.

# email notification to phone

PATH="/usr/bin:/bin:/var/qmail/bin"

cat <<EOF | qmail-inject
From: System <postmaster@domain.xyz>
To: Phone <1234567890@cell.carrier.xyz>
Subject: freshclam error

The freshclam program has encountered an error.
EOF

exit 0
