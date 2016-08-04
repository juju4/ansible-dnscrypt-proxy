#!/usr/bin/env bats

setup() {
    apt-get install -y ldnsutils >/dev/null || yum -y install bind-utils >/dev/null
}

@test "process dnscrypt-proxy should be running" {
    run pgrep dnscrypt-proxy
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "resolv.conf should be pointing at 127.0.0.2" {
    run cat /etc/resolv.conf
    [ "$status" -eq 0 ]
    [[ "$output" =~ "nameserver 127.0.0.2" ]]
}

@test "standard dns resolution: host www.google.com" {
    run host www.google.com
    [ "$status" -eq 0 ]
    [[ "$output" != "SERVFAIL" ]]
}

@test "standard dns resolution: host www.yahoo.com" {
    run host www.yahoo.com
    [ "$status" -eq 0 ]
    [[ "$output" != "SERVFAIL" ]]
}

@test "standard dns resolution: host www.bing.com" {
    run host www.bing.com
    [ "$status" -eq 0 ]
    [[ "$output" != "SERVFAIL" ]]
}

### NOK default-ubuntu-1404, dnscrypt-unbound-ubuntu-1404
#@test "DNSSEC is active (DNSKEY for freebsd.org)" {
#    run drill -S freebsd.org
#    [ "$status" -eq 0 ]
#    [[ "$output" =~ "DNSKEY" ]]
#}
#
### https://wiki.debian.org/DNSSEC#Test_DNSSEC
### NOK default-centos-71, dnscrypt-unbound-centos-71
### NOK default-ubuntu-1404, dnscrypt-unbound-ubuntu-1404
#@test "DNSSEC check: dig +short test.dnssec-or-not.net TXT | tail -1" {
#    run dig +short test.dnssec-or-not.net TXT | tail -1
#    [ "$status" -eq 0 ]
##    [[ "$output" =~ "status: NOERROR" ]]
#}
#
### NOK default-ubuntu-1404, dnscrypt-unbound-ubuntu-1404
#@test "DNSSEC check: dig +noall +comments dnssec-failed.org" {
#    run dig +noall +comments dnssec-failed.org
#    [ "$status" -eq 0 ]
#    [[ "$output" =~ "status: SERVFAIL" ]]
#}
#
### http://dnssec.vs.uni-due.de/
### NOK default-ubuntu-1404, dnscrypt-unbound-ubuntu-1404
#@test "DNSSEC check: dig sigok.verteiltesysteme.net @127.0.0.2" {
#    run dig sigok.verteiltesysteme.net @127.0.0.2
#    [ "$status" -eq 0 ]
#    [[ "$output" =~ "status: NOERROR" ]]
#}
#
### NOK dnscrypt-unbound-centos-71(but ok in interactive login???)
### NOK default-ubuntu-1404, dnscrypt-unbound-ubuntu-1404
#@test "DNSSEC check: dig sigfail.verteiltesysteme.net @127.0.0.2" {
#    run dig sigfail.verteiltesysteme.net @127.0.0.2
#    [ "$status" -eq 0 ]
#    [[ "$output" =~ "status: SERVFAIL" ]]
#}
#
### https://blog.cloudflare.com/help-us-test-our-dnssec-implementation/
#@test "DNSSEC check: dig www.cloudflare-dnssec-auth.com A +dnssec" {
#    run dig www.cloudflare-dnssec-auth.com A +dnssec
#    [ "$status" -eq 0 ]
#    [[ "$output" =~ "status: NOERROR" ]]
#}
#
### https://support.opendns.com/entries/21737309-How-do-I-know-DNSCrypt-is-working-
### https://askubuntu.com/questions/105366/how-to-check-if-dns-is-encrypted
#@test "DNSCrypt check: dig debug.opendns.com txt" {
#    run dig debug.opendns.com txt
#    [ "$status" -eq 0 ]
#    [[ "$output" =~ "dnscrypt enabled" ]]
#}
#
