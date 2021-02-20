[![Actions Status - Master](https://github.com/juju4/ansible-dnscrypt-proxy/workflows/AnsibleCI/badge.svg)](https://github.com/juju4/ansible-dnscrypt-proxy/actions?query=branch%3Amaster)
[![Actions Status - Devel](https://github.com/juju4/ansible-dnscrypt-proxy/workflows/AnsibleCI/badge.svg?branch=devel)](https://github.com/juju4/ansible-dnscrypt-proxy/actions?query=branch%3Adevel)

# dnscrypt proxy ansible role

Ansible role to setup dnscrypt proxy
Allow to encrypt dns traffic to a central dns server in order to provide better privacy.

Ubuntu install is using 'ppa:anton+/dnscrypt' on Trusty and official package on Xenial, both at 1.6.1
RedHat install is from source, current latest 1.9.5 (Sep 2017)

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 1.9
 * 2.0
 * 2.2
 * 2.3
 * 2.10

### Operating systems

Tested on Ubuntu 16.04, 18.04, 20.04 and Centos 7-8
Vagrant, Kitchen test and Github Action available

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

* kitchen verify fails on trusty with anton ppa.
There is a permission issue. It doesn't seem to be at lxc/apparmor level (same if privileged).
```
# strace dnscrypt-proxy
[...]
access("/etc/ld.so.nohwcap", F_OK)      = 0
open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P \2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1857312, ...}) = 0
mmap(NULL, 3965632, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7ffa9470d000
mprotect(0x7ffa948cb000, 2097152, PROT_NONE) = 0
mmap(0x7ffa94acb000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1be000) = 0x7ffa94acb000
mmap(0x7ffa94ad1000, 17088, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7ffa94ad1000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7ffa94f56000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7ffa94f54000
arch_prctl(ARCH_SET_FS, 0x7ffa94f54740) = 0
mprotect(0x7ffa94acb000, 16384, PROT_READ) = 0
mprotect(0x7ffa94d3c000, 4096, PROT_READ) = 0
mprotect(0x55d12a2a1000, 4096, PROT_READ) = -1 EACCES (Permission denied)
writev(2, [{"dnscrypt-proxy", 14}, {": ", 2}, {"error while loading shared libra"..., 36}, {": ", 2}, {"", 0}, {"", 0}, {"cannot apply additional memory p"..., 58}, {": ", 2}, {"Permission denied", 17}, {"\n", 1}], 10) = -1 EACCES (Permission denied)
exit_group(127)                         = ?
+++ exited with 127 +++
```
= Use source install


## License

BSD 2-clause

