#!/bin/bash

set -e

wget http://cr.yp.to/cdb/cdb-0.75.tar.gz -O /downloads/cdb-0.75.tar.gz

cd /usr/src
tar xvzf /downloads/cdb-0.75.tar.gz
cd cdb-0.75
sed -i 's/gcc -O2/gcc -O2 -include \/usr\/include\/errno.h/g' conf-cc
make
make setup check
