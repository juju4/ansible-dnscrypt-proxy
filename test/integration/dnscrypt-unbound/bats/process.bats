#!/usr/bin/env bats

setup() {
    apt-get install -y ldnsutils >/dev/null || yum -y install bind-utils >/dev/null
}

@test "process dnscrypt-proxy should be running" {
    run pgrep dnscrypt-proxy
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process unbound should be running" {
    run pgrep unbound
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "resolv.conf should be pointing at 127.0.0.1" {
    run cat /etc/resolv.conf
    [ "$status" -eq 0 ]
    [[ "$output" =~ "127.0.0.1" ]]
}

@test "standard dns resolution: host www.google.com" {
    run host www.google.com
    [ "$status" -eq 0 ]
    [[ "$output" != "SERVFAIL" ]]
}

@test "standard dns resolution: host www.cnn.com" {
    run host www.cnn.com
    [ "$status" -eq 0 ]
    [[ "$output" != "SERVFAIL" ]]
}

@test "standard dns resolution: dig www.cnn.com @127.0.0.1" {
    run dig www.cnn.com @127.0.0.1
    [ "$status" -eq 0 ]
    [[ "$output" != "SERVFAIL" ]]
}

@test "standard dns resolution: host www.bing.com" {
    run host www.bing.com
    [ "$status" -eq 0 ]
    [[ "$output" != "SERVFAIL" ]]
}

#@test "DNSSEC is active (DNSKEY for freebsd.org)" {
#    run drill -S freebsd.org
#    [ "$status" -eq 0 ]
#    [[ "$output" =~ "DNSKEY" ]]
#}

## https://wiki.debian.org/DNSSEC#Test_DNSSEC
#@test "DNSSEC check: dig +short test.dnssec-or-not.net TXT | tail -1" {
#    run dig +short test.dnssec-or-not.net TXT | tail -1
#    [ "$status" -eq 0 ]
##    [[ "$output" =~ "status: NOERROR" ]]
#}

@test "DNSSEC check: dig +noall +comments dnssec-failed.org" {
    run dig +noall +comments dnssec-failed.org
    [ "$status" -eq 0 ]
    [[ "$output" =~ "status: SERVFAIL" ]]
}

## http://dnssec.vs.uni-due.de/
#@test "DNSSEC check: dig sigok.verteiltesysteme.net @127.0.0.1" {
#    run dig sigok.verteiltesysteme.net @127.0.0.1
#    [ "$status" -eq 0 ]
#    [[ "$output" =~ "status: NOERROR" ]]
#}

#@test "DNSSEC check: dig sigfail.verteiltesysteme.net @127.0.0.1" {
#    run dig sigok.verteiltesysteme.net @127.0.0.1
#    [ "$status" -eq 0 ]
#    [[ "$output" =~ "status: SERVFAIL" ]]
#}

## https://blog.cloudflare.com/help-us-test-our-dnssec-implementation/
@test "DNSSEC check: dig www.cloudflare-dnssec-auth.com A +dnssec" {
    run dig www.cloudflare-dnssec-auth.com A +dnssec
    [ "$status" -eq 0 ]
    [[ "$output" =~ "status: NOERROR" ]]
}


