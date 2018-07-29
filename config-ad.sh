#!/bin/bash

SERVICE_ROLE="dc"
ADMIN_PASS="Test@1234"

# domain configuration
sudo sed -i "s#^includedir /etc/krb5.conf.d/#\#&#g" /etc/krb5.conf
samba-tool domain provision --use-rfc2307 --server-role=${SERVICE_ROLE} --adminpass=${ADMIN_PASS}

firewall-cmd --add-port=53/tcp --permanent;firewall-cmd --add-port=53/udp --permanent
firewall-cmd --add-port=88/tcp --permanent;firewall-cmd --add-port=88/udp --permanent
firewall-cmd --add-port=135/tcp --permanent;firewall-cmd --add-port=137-138/udp --permanent;firewall-cmd --add-port=139/tcp --permanent
firewall-cmd --add-port=389/tcp --permanent;firewall-cmd --add-port=389/udp --permanent;firewall-cmd --add-port=445/tcp --permanent
firewall-cmd --add-port=464/tcp --permanent;firewall-cmd --add-port=464/udp --permanent;firewall-cmd --add-port=636/tcp --permanent
firewall-cmd --add-port=1024-5000/tcp --permanent;firewall-cmd --add-port=3268-3269/tcp --permanent
firewall-cmd --reload
