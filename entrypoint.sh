#!/bin/bash

# prepare configurations
realm=$(echo ${AD_DOMAIN} | tr 'a-z' 'A-Z')
domain=$(echo ${realm} | cut -d. -f1)
admin_pass=${AD_ADMIN_PASS}

sed -i 's/^includedir \/etc\/krb5.conf.d\//#&/g' /etc/krb5.conf

# set domain mapping
thisip=$(ping `hostname` -c 1 | grep ttl | cut -d'(' -f2|cut -d')' -f1)
if [ $thisip'x' != 'x' ]; then
    if [ `cat /etc/hosts | grep ${AD_DOMAIN} | wc -l` -eq 0 ]; then
        echo "$thisip ${AD_DOMAIN}" >> /etc/hosts
    else
        sed -i "s/${AD_DOMAIN}/$thisip ${AD_DOMAIN}/g" /etc/hosts
    fi
else
    exit 1;
fi

# config domain
/usr/local/samba/bin/samba-tool domain provision --use-rfc2307 --server-role=dc \
    --adminpass=${admin_pass} --realm=${realm} --domain=${domain}

# start samba
/usr/local/samba/sbin/samba

while [ true ];
do
    sleep 60
done
