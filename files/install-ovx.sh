#!/bin/sh

apt-get update
apt-get install git maven mongodb software-properties-common -y
add-apt-repository ppa:webupd8team/java -y
apt-get update
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get install oracle-java7-installer oracle-java7-set-default -y
apt-get install supervisor -y

cd /home/ubuntu; su -c "git clone https://github.com/OPENNETWORKINGLAB/OpenVirteX.git -b 0.0-MAINT" ubuntu

#sh OpenVirteX/scripts/ovx.sh
cat >/etc/supervisor/conf.d/ovx.conf <<EOF
[program:ovx]
command=sh /home/ubuntu/OpenVirteX/scripts/ovx.sh
stopasgroup=true
user=ubuntu
EOF

killall -HUP supervisord
