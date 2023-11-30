FROM weejewel/wg-easy

WORKDIR /app
ENTRYPOINT \
  iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 8080 -j DNAT --to-destination 10.8.0.2 \
  && iptables -t nat -A POSTROUTING -o wg0 -p tcp --dport 8080 -j MASQUERADE \
  && /usr/bin/dumb-init node server.js
