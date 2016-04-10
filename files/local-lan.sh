## https://hdm.io/blog/2015/08/15/dnscrypt-with-multiple-resolvers/

iptables -A INPUT -s <internal-network> -p udp --dport 53 -d <router-internal-ip> -j ACCEPT
iptables -A PREROUTING -s <internal-network> -p udp -m udp --dport 53 -j DNAT --to-destination <router-internal-ip>

