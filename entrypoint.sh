#!/usr/bin/env bash

# start logging
# service rsyslog start

# enable IP forwarding
sysctl -p

# configure firewall
iptables -A INPUT -p tcp -m tcp --dport 1723 -j ACCEPT
iptables -A INPUT -p gre -j ACCEPT
iptables -A OUTPUT  -p gre -j ACCEPT
# iptables -t nat -A POSTROUTING -s 10.99.99.0/24 -o eth0 -j MASQUERADE
# iptables -A FORWARD -s 10.99.99.0/24 -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j TCPMSS --set-mss 1356

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

/etc/init.d/pptpd restart

exec "$@"
