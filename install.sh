#!/bin/bash

#Prerequis
apt-get update
apt-get upgrade -y
apt-get install -y locales-all
localectl set-locale LANG=en_US.UTF-8
localectl status
apt-get install -y ntp
systemctl enable ntp
systemctl start ntp
apt-get install -y systemd
apt-get install -y ca-certificates

#install srv wapt
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y
apt-get install -y apt-transport-https lsb-release
wget -O - https://wapt.tranquil.it/debian/tiswapt-pub.gpg  | apt-key add -
echo  "deb  https://wapt.tranquil.it/debian/wapt-1.6/ $(lsb_release -c -s) main"  > /etc/apt/sources.list.d/wapt.list
apt-get update
apt-get install -y tis-waptserver tis-waptrepo tis-waptsetup

#Script post conf
NCURSES_NO_UTF8_ACS=1 PYTHONHOME=/opt/wapt PYTHONPATH=/opt/wapt /opt/wapt/bin/python !!!install.py!!! $@
