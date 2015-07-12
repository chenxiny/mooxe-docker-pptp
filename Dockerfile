FROM mooxe/base:latest

MAINTAINER FooTearth "footearth@gmail.com"

WORKDIR /root

RUN \
  apt-get install -y pptpd iptables && \

  echo "footearth * netserver *" >> /etc/ppp/chap-secrets && \

  echo "localip 10.99.99.1" >> /etc/pptpd.conf && \
  echo "localip 10.99.99.100-200" >> /etc/pptpd.conf && \

  echo "ms-dns 8.8.8.8" >> /etc/ppp/pptpd-options && \
  echo "ms-dns 8.8.4.4" >> /etc/ppp/pptpd-options && \

  echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

  # sed -i '1s/^/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE/' /etc/rc.local
  #              iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod 0700 /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["pptpd", "--fg"]

EXPOSE 1723
