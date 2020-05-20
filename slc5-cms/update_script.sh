#!/bin/sh
yum -y install make
yum -y groupinstall 'Development Tools'

export UPDATES=${PWD}/updates
export GETTEXT_VERSION=gettext-0.20.1
export CURL_VERSION=curl-7.65.0
export OPENSSL_VERSION=openssl-1.1.1g
export M4_VERSION=m4-1.4.18
export AUTOCONF_VERSION=autoconf-2.69
export GIT_VERSION=git-2.26.2
export PERL_VERSION=perl-5.30.2
export LD_LIBRARY_PATH=${UPDATES}/lib:${LD_LIBRARY_PATH}
export PATH=${UPDATES}/bin:${PATH}
cd ${UPDATES}

tar xzf ${GETTEXT_VERSION}.tar.gz
cd ${GETTEXT_VERSION}
./configure --prefix=${UPDATES}
make
make install
cd ..

tar -xzf ${PERL_VERSION}.tar.gz
cd ${PERL_VERSION}
./Configure -des
make
make install
cd ..

tar xzf ${OPENSSL_VERSION}.tar.gz
cd ${OPENSSL_VERSION}
CFLAGS=-fPIC ./config --prefix=${UPDATES} shared zlib
make
make install
cd ..

tar xzf ${CURL_VERSION}.tar.gz
cd ${CURL_VERSION}
./configure --with-ssl=${UPDATES} --prefix=${UPDATES}
make
make install
cd ..

tar xzf ${M4_VERSION}.tar.gz
cd ${M4_VERSION}
./configure --prefix=${UPDATES}
make -j16
make install
cd ..

tar xzf ${AUTOCONF_VERSION}.tar.gz
cd ${AUTOCONF_VERSION}
./configure --prefix=${UPDATES}
make -j16
make install
cd ..

tar xzf ${GIT_VERSION}.tar.gz 
cd ${GIT_VERSION}
make configure
./configure --prefix=${UPDATES} --with-openssl=${UPDATES} --with-curl=${UPDATES}
make -j16
make install -i
