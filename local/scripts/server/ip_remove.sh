#!/bin/sh
# Flushing all rules
echo "Flushing existing rules"
iptables -F
iptables -X

# Setting default filter policy
echo "Setting up default filter policy to DROP"
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT 
iptables -P FORWARD ACCEPT 


# ===== DOCKER RULES ===== #
echo "Restarting docker process to append its iptables rules"
systemctl restart docker

iptables-save -f /etc/iptables/iptables.rules
