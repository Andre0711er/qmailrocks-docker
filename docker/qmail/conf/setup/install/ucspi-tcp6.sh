#!/bin/bash

set -e

UCSPI_TCP6_DOWNLOAD="https://www.fehcom.de/ipnet/ucspi-tcp6/ucspi-tcp6-1.05.tgz"
wget --no-check-certificate $UCSPI_TCP6_DOWNLOAD -O /downloads/ucspi-tcp6-1.05.tgz

cd /package
tar xvzf /downloads/ucspi-tcp6-1.05.tgz
cd /package/host/ucspi-tcp6-1.05
package/install
