#!/bin/sh
#
# Firewall example script
# 
# To use it:
# - copy/save it to your /root directory
# - cd /root
# - chmod +x example-firewall-script.sh 
#
# The script takes 3 different parameters: start, stop and status
# 
# Start: 	./example-firewall-script.sh start
# Stop: 	./example-firewall-script.sh stop
# Status: 	./example-firewall-script.sh status

case "$1" in
  start)
    echo "Starting Firewall"

	# Flush old tables
	iptables -F
	iptables -t nat -F
	iptables -t mangle -F
	iptables -X
	iptables -t nat -X
	iptables -t mangle -X

	# Default Policies
	iptables -P INPUT DROP
	iptables -P OUTPUT DROP
	iptables -P FORWARD DROP

	# MY_REJECT Chain
	iptables -N MY_REJECT
	iptables -A MY_REJECT -p tcp -m limit --limit 7200/h -j LOG --log-prefix "FIREWALL: REJECT TCP "
	iptables -A MY_REJECT -p tcp -j REJECT --reject-with tcp-reset
	iptables -A MY_REJECT -p udp -m limit --limit 7200/h -j LOG --log-prefix "FIREWALL: REJECT UDP "
	iptables -A MY_REJECT -p udp -j REJECT --reject-with icmp-port-unreachable
	iptables -A MY_REJECT -p icmp -m limit --limit 7200/h -j LOG --log-prefix "FIREWALL: DROP ICMP "
	iptables -A MY_REJECT -p icmp -j DROP
	iptables -A MY_REJECT -m limit --limit 7200/h -j LOG --log-prefix "FIREWALL: REJECT OTHER "
	iptables -A MY_REJECT -j REJECT --reject-with icmp-proto-unreachable

	# MY_DROP Chain
	iptables -N MY_DROP
	iptables -A MY_DROP -m limit --limit 7200/h -j LOG --log-prefix "FIREWALL: PORTSCAN DROP "
	iptables -A MY_DROP -j DROP

	###############
	# INPUT CHAIN #
	###############

		# Log and then drop invalid packets
		###################################
			iptables -A INPUT -m state --state INVALID -m limit --limit 7200/h -j LOG --log-prefix "FIREWALL: INPUT INVALID "
			iptables -A INPUT -m state --state INVALID -j DROP
		
		# Send various port scans to MY_DROP chain (log and then drop!)
		##########################
		
			# No Flags set
			iptables -A INPUT -p tcp --tcp-flags ALL NONE -j MY_DROP 

			# SYN and FIN set at the same time
			iptables -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j MY_DROP

			# SYN and RST set at the same time
			iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j MY_DROP

			# FIN and RST set at the same time
			iptables -A INPUT -p tcp --tcp-flags FIN,RST FIN,RST -j MY_DROP

			# FIN withoute ACK
			iptables -A INPUT -p tcp --tcp-flags ACK,FIN FIN -j MY_DROP

			# PSH without ACK
			iptables -A INPUT -p tcp --tcp-flags ACK,PSH PSH -j MY_DROP

			# URG without ACK
			iptables -A INPUT -p tcp --tcp-flags ACK,URG URG -j MY_DROP	


		# Loopback and connection tracking
		###################################

			# Allow loopback traffic
			iptables -A INPUT -i lo -j ACCEPT

			# Allow tracked (established / related) connections
			iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT


		# Respond to pings
		###################
		
			# Allow ICMP8 / Pings
			#iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT			
			

		# SERVICE RELATED RULES (Add your own rules here!)
		########################

			# SSH
			iptables -A INPUT  -m state --state NEW -p tcp --dport 22 -j ACCEPT

			# HTTP
			#iptables -A INPUT -m state --state NEW -p tcp --dport 80 -j ACCEPT

			
		# Send everything else to MY_REJECT chain
		##########################################
			iptables -A INPUT -j MY_REJECT



	################
	# OUTPUT CHAIN #
	################
	
		# Log and then drop invalid packets
		###################################
			iptables -A OUTPUT -m state --state INVALID -m limit --limit 7200/h -j LOG --log-prefix "FIREWALL: OUTPUT INVALID "
			iptables -A OUTPUT -m state --state INVALID -j DROP


		# Loopback and connection tracking
		###################################
			iptables -A OUTPUT -o lo -j ACCEPT
			iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

		
		# Send everything else to MY_REJECT chain
		##########################################
		iptables -A OUTPUT -j MY_REJECT


	#############################
	# LOAD LIST OF IPs TO BLOCK #
	#############################
	
		# BANNED_IPS="/etc/iptables/banned.conf"
		# for i in `cat $BANNED_IPS`; do
		# 	iptables -I INPUT -s $i -j DROP
		# done

	# Save IP tables rules to file
	#iptables-save > /PATH/TO/FILE

	# Write syslog entry that firewall was started
	logger "Firewall Started"
	
;;

stop)
    echo "Stopping Firewall"
    # Flush tables
    iptables -F
    iptables -t nat -F
    iptables -t mangle -F
    iptables -X
    iptables -t nat -X
    iptables -t mangle -X
    # Set default policies to ACCEPT
    iptables -P INPUT ACCEPT
    iptables -P OUTPUT ACCEPT
    iptables -P FORWARD ACCEPT
    
    # Write syslog entry that firewall was started
	logger "Firewall stopped"
;;

status)
    echo "Table filter:"
    iptables -L -vn
    echo "Table nat:"
    iptables -t nat -L -vn
    echo "Table mangle:"
    iptables -t mangle -L -vn
;;

*)
    echo "Syntax Error!"
    echo "Syntax: $0 {start|stop|status}"
    exit 1
    ;;

esac
