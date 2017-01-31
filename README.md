[![Build Status - Master](https://travis-ci.org/juju4/ansible-dnscrypt-proxy.svg?branch=master)](https://travis-ci.org/juju4/ansible-dnscrypt-proxy)
[![Build Status - Devel](https://travis-ci.org/juju4/ansible-dnscrypt-proxy.svg?branch=devel)](https://travis-ci.org/juju4/ansible-dnscrypt-proxy/branches)
# dnscrypt proxy ansible role

Ansible role to setup dnscrypt proxy
Allow to encrypt dns traffic to a central dns server in order to provide better privacy.

Ubuntu install is using 'ppa:anton+/dnscrypt' on Trusty and official package on Xenial, both at 1.6.1
RedHat install is from source, current latest 1.9.4 (Jan 2017)

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 1.9
 * 2.0
 * 2.2

### Operating systems

Tested with vagrant on Ubuntu 16.04, 14.04 and Centos 7.1
Kitchen test available

### Dependencies

None

## Example Playbook

Just include this role in your list.
For example

```
- host: myhost
  roles:
    - juju4.dnscrypt-proxy
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
$ kitchen verify
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

