#!/bin/bash

# prepare configurations
realm=$(echo ${AD_DOMAIN} | tr 'a-z' 'A-Z')
domain=$(echo ${realm} | cut -d. -f1)
admin_pass=${AD_PASSWORD}

rm -f /etc/krb5.conf
ln -s /var/lib/samba/private/krb5.conf /etc/krb5.conf

# config domain
/usr/local/samba/bin/samba-tool domain provision \
    --use-rfc2307 \
    --server-role=dc \
    --adminpass=${admin_pass} \
    --realm=${realm} \
    --domain=${domain}

if [ $AD_NOSTRONGAUTH = 1 ]; then
  if [ `cat /usr/local/samba/etc/smb.conf |grep "ldap" | wc -l` -eq 0 ]; then
      sed -i "5a ldap server require strong auth = no" /usr/local/samba/etc/smb.conf
  fi
fi

/usr/local/samba/bin/samba-tool domain level show

# start samba
/usr/local/samba/sbin/samba

while [ true ];
do
    sleep 60
done
