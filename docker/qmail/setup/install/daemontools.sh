#!/bin/bash

set -e

wget https://cr.yp.to/daemontools/daemontools-0.76.tar.gz -O /downloads/daemontools-0.76.tar.gz
cd /usr/src
tar xvzf /downloads/daemontools-0.76.tar.gz
cd admin/daemontools-0.76
sed -i 's/-Wwrite-strings/-Wwrite-strings -include \/usr\/include\/errno.h/g' src/conf-cc
package/install
