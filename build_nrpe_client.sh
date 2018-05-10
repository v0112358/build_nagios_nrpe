#!/bin/bash
yum install wget make epel-release gcc glibc glibc-common gd gd-devel net-snmp openssl-devel wget unzip -y
wget -O nagios-plugins-2.2.1.tar.gz https://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz
tar xzvf nagios-plugins-2.2.1.tar.gz
cd nagios-plugins-2.2.1
useradd nagios
groupadd nagios
usermod -a -G nagios nagios
./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl=/usr
make all
make install

chown nagios.nagios /usr/local/nagios
chown -R nagios.nagios /usr/local/nagios/libexec
yum install xinetd
cd ../
yum install dh-make -y
wget -O nrpe-3.2.1.tar.gz https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-3.2.1/nrpe-3.2.1.tar.gz
tar xzvf nrpe-3.2.1.tar.gz
cd nrpe-3.2.1
./configure
make all
make install
make install-config
#make install-inetd
make install-init
systemctl enable nrpe && systemctl start nrpe
