#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

rolesdir=$(dirname $0)/..

[ ! -d $rolesdir/jdauphant.unbound ] && git clone https://github.com/jdauphant/ansible-role-unbound.git $rolesdir/jdauphant.unbound
## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/juju4.dnscrypt-proxy ] && ln -s ansible-dnscrypt-proxy $rolesdir/juju4.dnscrypt-proxy
[ ! -e $rolesdir/juju4.dnscrypt-proxy ] && cp -R $rolesdir/ansible-dnscrypt-proxy $rolesdir/juju4.dnscrypt-proxy

## don't stop build on this script return code
true

