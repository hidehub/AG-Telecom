#!/bin/bash

echo "Update[]"
yum -y update
echo "Install MC[][]"
yum -y install mc
cp /usr/share/mc/syntax/sh.syntax /usr/share/mc/syntax/unknown.syntax
echo "Install Net Tools[][][]"
yum -y install net-tools
echo "Install Bind Tools[][][][]"
yum -y install bind-utils
echo "Install Nano[][][][][]"
yum -y install nano
echo "Install Network Scripts[][][][][][]"
yum -y install network-scripts
echo "Install Iptables[][][][][][][]"
yum -y install iptables-services
systemctl enable iptables
echo "Install SSH[][][][][][][][]"
yum -y install openssh-server openssh-clients
service sshd start
echo "Select SSH port number:"
read SSHPORT
sed -i 's/#Port 22/Port '$SSHPORT'/' /etc/ssh/sshd_config
service sshd restart
iptables -I INPUT 1 -s 212.111.64.0/19 -p tcp --dport $SSHPORT -j ACCEPT
iptables -I INPUT 2 -s 172.17.0.0/16 -p tcp --dport $SSHPORT -j ACCEPT
iptables -I INPUT 3 -p tcp --dport $SSHPORT -j DROP
echo "Install CRON [][][][][][][][][]"
yum -y install chrony
systemctl enable chronyd
yum -y install iftop
yum -y install lsof
echo "Install Apache?"
echo "[y]-install [any button]-cansel"
read -n 1 APACHE
if [ "$APACHE" = "y" ]
then
yum -y install httpd
systemctl start httpd
else
echo "CANCEL"
fi
yum -y install wget
yum -y install iptables-services