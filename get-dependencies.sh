#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

rolesdir=$(dirname $0)/..

[ ! -d $rolesdir/jdauphant.unbound ] && git clone https://github.com/jdauphant/ansible-role-unbound.git $rolesdir/jdauphant.unbound

