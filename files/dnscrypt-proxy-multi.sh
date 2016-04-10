#!/bin/sh

export PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
umask 022

user=dnscrypt
p=53
for r in dnscrypt.eu-dk dnscrypt.eu-nl dnscrypt.org-fr ipredator okturtles fvz-rec-us-tx-01; do
    dnscrypt-proxy --ephemeral-keys --resolver-name=$r --user=$user -l /var/log/dnscrypt/dnscrypt_$r.log --pidfile=/run/dnscrypt-proxy_$r.pid --daemonize --local-address=127.0.0.2:$p &
    p=`expr $p + 1`
done
