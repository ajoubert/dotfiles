#!/bin/sh
# My system IP/set ip address of server
# Get the public ip of the current server
SERVER_IP="$(ip addr show eth0 | grep 'inet ' | cut -f2 | awk '{print $2}')"

# Let's strip out the network mask from the ip
SERVER_IP=${SERVER_IP%/*}

# Let's get the DNS servers
DNS_SERVERS="8.8.8.8"

# Flushing all rules
echo "Flushing existing rules"
iptables -F
iptables -X

# ====== GLOBAL RULES =====

# Setting default filter policy
# Normally not necessary as we'll have a default for each chain
echo "Setting up default filter policy to DROP"
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Let's allow dns requests
for ip in $DNS_SERVERS
do
    echo "Allowing DNS lookups (tcp, udp port 53) to server '$ip'"
    iptables -A OUTPUT -p udp -d $ip --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
    iptables -A INPUT  -p udp -s $ip --sport 53 -m state --state ESTABLISHED     -j ACCEPT
    iptables -A OUTPUT -p tcp -d $ip --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
    iptables -A INPUT  -p tcp -s $ip --sport 53 -m state --state ESTABLISHED     -j ACCEPT
done

# Let's allow ping
echo "Allowing ping in and out"
## From the outside in
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
## From the inside out
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT

# Allow unlimited traffic on loopback
echo "Allow all INPUT and OUTPUT traffic on interface lo"
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow incoming ssh
echo "Allow incoming ssh on port 22"
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Allow web
echo "Allow all incomming and outgoing requests on port 80 and 443 (web)"
iptables -A INPUT -p tcp -m multiport --dports 80,443,8080 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -m multiport --sports 80,443,8080 -m conntrack --ctstate ESTABLISHED -j ACCEPT

iptables -A OUTPUT -p tcp -m multiport --dports 80,443,8080 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -m multiport --sports 80,443,8080 -m conntrack --ctstate ESTABLISHED -j ACCEPT

iptables -A OUTPUT -p tcp --dport 4243 -s 172.27.0.0/255.255.0.0 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --dport 4243 -s 172.17.0.0/255.255.0.0 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 4243 -m conntrack --ctstate ESTABLISHED -j ACCEPT 

iptables -A INPUT -p tcp --dport 4243 -s 172.27.0.0/255.255.0.0 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --dport 4243 -s 172.17.0.0/255.255.0.0 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --sport 4243 -m conntrack --ctstate ESTABLISHED -j ACCEPT 



# Attempt to allow internal communications
iptables -A OUTPUT -s 192.168.0.0/255.255.0.0 -j ACCEPT
iptables -A INPUT -s 192.168.0.0/255.255.0.0 -j ACCEPT
iptables -A FORWARD -s 192.168.0.0/255.255.0.0 -j ACCEPT
iptables -A INPUT -s ${SERVER_IP} -d ${SERVER_IP} -j ACCEPT
iptables -A OUTPUT -s ${SERVER_IP} -d ${SERVER_IP} -j ACCEPT

# Drop and log
iptables -N logdrop
iptables -A logdrop -m limit --limit 2/min -j LOG --log-prefix "IPTables Packet Dropped: " --log-level 7
iptables -A logdrop -j DROP 

# make sure nothing comes or goes out of this box
iptables -A INPUT -j logdrop
iptables -A OUTPUT -j logdrop 
iptables -A FORWARD -j logdrop


# ===== / GLOBAL RULES ===== #

# ===== DOCKER RULES ===== #


echo "Restarting docker process to append its iptables rules"
systemctl restart docker

echo "Drop all docker network traffic by default"
iptables -I DOCKER-USER -j logdrop
echo "Allow established traffic for updates to run"
iptables -I DOCKER-USER -m conntrack --ctstate RELATED,ESTABLISHED -j RETURN

echo "Allow incomming/outgoing traffic on port 80 and 443"
iptables -I DOCKER-USER -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j RETURN
iptables -I DOCKER-USER -p tcp -m multiport --sports 80,443 -m conntrack --ctstate ESTABLISHED -j RETURN
iptables -I DOCKER-USER -p tcp -m multiport --sports 80,443 -m conntrack --ctstate ESTABLISHED -j RETURN 
iptables -I DOCKER-USER -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j RETURN 

echo "Allow dns requests within docker containers"
iptables -I DOCKER-USER -p tcp -m multiport --sports 53 -m conntrack --ctstate ESTABLISHED -j RETURN 
iptables -I DOCKER-USER -p tcp -m multiport --dports 53 -m conntrack --ctstate NEW,ESTABLISHED -j RETURN 
iptables -I DOCKER-USER -p tcp -m multiport --dports 53 -m conntrack --ctstate ESTABLISHED -j RETURN 
iptables -I DOCKER-USER -p tcp -m multiport --sports 53 -m conntrack --ctstate NEW,ESTABLISHED -j RETURN 

iptables -I DOCKER-USER -p udp -m multiport --sports 53 -m conntrack --ctstate ESTABLISHED -j RETURN 
iptables -I DOCKER-USER -p udp -m multiport --dports 53 -m conntrack --ctstate NEW,ESTABLISHED -j RETURN 
iptables -I DOCKER-USER -p udp -m multiport --dports 53 -m conntrack --ctstate ESTABLISHED -j RETURN 
iptables -I DOCKER-USER -p udp -m multiport --sports 53 -m conntrack --ctstate NEW,ESTABLISHED -j RETURN 

echo "Allow creation of requests from within containers"
iptables -I DOCKER-USER -s 192.168.0.0/255.255.0.0 -j RETURN
iptables -I DOCKER-USER -d 192.168.0.0/255.255.0.0 -m conntrack --ctstate ESTABLISHED -j RETURN


# echo "Allow internal traffic for docker connection"
# iptables -I DOCKER-USER -p tcp --dport 4243 -s 172.27.0.0/255.255.0.0 -m conntrack --ctstate NEW,ESTABLISHED -j RETURN
# iptables -I DOCKER-USER -p tcp --dport 4243 -s 172.17.0.0/255.255.0.0 -m conntrack --ctstate NEW,ESTABLISHED -j RETURN
# iptables -I DOCKER-USER -p tcp --sport 4243 -m conntrack --ctstate ESTABLISHED -j RETURN
