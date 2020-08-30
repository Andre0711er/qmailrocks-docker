#!/bin/bash

set -e

UCSPI_DOWNLOAD="https://www.fehcom.de/ipnet/ucspi-ssl/ucspi-ssl-0.99d.tgz"
wget --no-check-certificate $UCSPI_DOWNLOAD -O /downloads/ucspi-ssl-0.99d.tgz

cd /package
tar xvzf /downloads/ucspi-ssl-0.99d.tgz
cd /package/host/superscript.com/net/ucspi-ssl-0.99d
package/install
