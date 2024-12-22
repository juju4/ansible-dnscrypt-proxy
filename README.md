[![Actions Status - Master](https://github.com/juju4/ansible-dnscrypt-proxy/workflows/AnsibleCI/badge.svg)](https://github.com/juju4/ansible-dnscrypt-proxy/actions?query=branch%3Amaster)
[![Actions Status - Devel](https://github.com/juju4/ansible-dnscrypt-proxy/workflows/AnsibleCI/badge.svg?branch=devel)](https://github.com/juju4/ansible-dnscrypt-proxy/actions?query=branch%3Adevel)

# dnscrypt proxy ansible role

Ansible role to setup [dnscrypt proxy](https://github.com/DNSCrypt/dnscrypt-proxy)
Allow to encrypt dns traffic to a central dns server in order to provide better privacy.

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.10-17

### Operating systems

Tested on Ubuntu 24.04, 22.04, 20.04, Centos/Rockylinux 9.

### Dependencies

None

## Example Playbook

Just include this role in your list.
For example

```
- host: myhost
  roles:
    - juju4.dnscryptproxy
```

If you want to use it with a dns cacher
```
- hosts: test-dnscrypt-unbound
  vars:
    ...
  roles:
    - juju4.dnscrypt-proxy
    - jdauphant.unbound
```
(see test/integration/default/default.yml)
would result in
system -> unbound (127.0.0.1:53) -> dnscrypt-proxy (127.0.0.2:53) -> dnscrypt.eu-dk
as described in https://github.com/jedisct1/dnscrypt-proxy/issues/161


## Variables


## Continuous integration

you can test this role with test kitchen.
In the role folder, run
```
$ gem install kitchen-ansible kitchen-lxd_cli kitchen-sync kitchen-vagrant
$ cd /path/to/roles/juju4.dnscrypt-proxy
$ kitchen verify
$ kitchen login
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```

Known bugs
* Inconsistent results over space and time
Test failed or not sometimes but when trying later, it works...

## Troubleshooting & Known issues

## Known issues

* No additional security is provided. Review
It's recommended to use with a caching dns server

* Firewall
port tcp/443 and udp/443 should be opened

* Monitoring
http://dns.measurement-factory.com/tools/nagios-plugins/check_zone_rrsig_expiration.html
http://www.bortzmeyer.org/monitor-dnssec.html

## License

BSD 2-clause
