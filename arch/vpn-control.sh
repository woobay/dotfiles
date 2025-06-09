#!/bin/bash
# VPN Control Script for RT-AX58U router
# Specifically for controlling VPN client 4

# Configuration
ROUTER="192.168.0.1"  # Change to your router's IP address
USER="admin"          # Change if your router uses a different username
SSH_KEY="~/.ssh/router"  # Change to your SSH key path if different
VPN_NUM=4             # Your active VPN client number

# Function to check VPN status
check_status() {
	ROUTER="192.168.0.1"  # Change to your router's IP address
	USER="admin"          # Change if your router uses a different username
	SSH_KEY="~/.ssh/router"  # Change to your SSH key path if different
	VPN_NUM=4             # Your active VPN client number

	echo "Checking VPN client ${VPN_NUM} status..."
	status=$(ssh -i $SSH_KEY $USER@$ROUTER "nvram get vpn_client${VPN_NUM}_state")

	if [ "$status" == "2" ]; then
		echo "VPN is CONNECTED"
		echo "Server: $(ssh -i $SSH_KEY $USER@$ROUTER "nvram get vpn_client${VPN_NUM}_addr")"
		return 0
	else
		echo "VPN is DISCONNECTED"
		return 1
	fi
}

# Function to enable VPN
enable_vpn() {
	echo "Enabling VPN client ${VPN_NUM}..."
	ssh -i $SSH_KEY $USER@$ROUTER "service start_vpnclient${VPN_NUM}"
	sleep 3  # Wait a moment for connection to establish
	check_status
}

# Function to disable VPN
disable_vpn() {
	echo "Disabling VPN client ${VPN_NUM}..."
	ssh -i $SSH_KEY $USER@$ROUTER "service stop_vpnclient${VPN_NUM}"
	sleep 1
	check_status
}

# Function to restart VPN
restart_vpn() {
	echo "Restarting VPN client ${VPN_NUM}..."
	ssh -i $SSH_KEY $USER@$ROUTER "service stop_vpnclient${VPN_NUM} && sleep 2 && service start_vpnclient${VPN_NUM}"
	sleep 3
	check_status
}

# Main program logic
case "$1" in
	status)
		check_status
		;;
	on|enable)
		enable_vpn
		;;
	off|disable)
		disable_vpn
		;;
	restart)
		restart_vpn
		;;
	*)
		echo "Usage: $0 {status|on|enable|off|disable|restart}"
		echo
		echo "Commands:"
		echo "  status   - Check if VPN is connected"
		echo "  on/enable - Enable VPN connection"
		echo "  off/disable - Disable VPN connection"
		echo "  restart  - Restart VPN connection"
		exit 1
		;;
esac

exit 0
