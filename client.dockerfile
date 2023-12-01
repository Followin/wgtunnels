FROM procustodibus/wireguard

CMD \
  iptables -t nat -A PREROUTING -i wg0 -p tcp --dport 8080 -j DNAT --to-destination 10.10.0.4 -d 10.8.0.2 -s 10.8.0.1 \
  && iptables -t nat -A POSTROUTING -o eth0 -p tcp --dport 8080 -j SNAT --to-source 10.10.0.3 -s 10.8.0.1 -d 10.10.0.4 \
  && iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT \
  && iptables -A INPUT -j DROP \
  && { sleep 1; ping -c 1 10.8.0.1; } & /sbin/init
