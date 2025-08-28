#!/bin/bash

DATE=$(date +%Y-%m-%d)

dnf install -y sssd-client sssd-dbus sssd-krb5-common sssd-ldap sssd-nfs-idmap sssd-tools oddjob oddjob-mkhomedir

/bin/systemctl enable oddjobd.service
/bin/systemctl start  oddjobd.service

mv /root/build/sssd.conf /etc/sssd
chown root:root /etc/sssd/sssd.conf
chmod 600 /etc/sssd/sssd.conf

authselect create-profile custom-sssd -b sssd --symlink-meta 

authselect select custom/custom-sssd with-mkhomedir with-faillock with-pamaccess without-nullok 

systemctl restart sssd

touch /.autorelabel
