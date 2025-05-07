#!/bin/bash
# vpn-waybar.sh - Improved version with wait for state change
# Waybar script to toggle and display VPN status

# Configuration - update these values to match your setup
ROUTER="192.168.0.1"
USER="admin"
SSH_KEY="$HOME/.ssh/router"
VPN_NUM=4
LOCKFILE="/tmp/vpn_toggle.lock"

# Function to get VPN status
get_vpn_status() {
    status=$(ssh -i $SSH_KEY $USER@$ROUTER "nvram get vpn_client${VPN_NUM}_state" 2>/dev/null)
    if [ "$status" == "2" ]; then
        # VPN is connected
        echo '{"text": "󰒘  VPN", "tooltip": "VPN is connected", "class": "on", "percentage": 100}'
    elif [ "$status" == "1" ]; then
        # VPN is connecting
        echo '{"text": "󰒗  VPN", "tooltip": "VPN is connecting...", "class": "connecting", "percentage": 50}'
    else
        # VPN is disconnected
        echo '{"text": "󰒙  VPN", "tooltip": "VPN is disconnected", "class": "off", "percentage": 0}'
    fi
}

# Function to toggle VPN with confirmation of state change
toggle_vpn() {
    # Check if toggle is already in progress
    if [ -f "$LOCKFILE" ]; then
        echo '{"text": "󰒗  VPN", "tooltip": "Toggle in progress...", "class": "connecting", "percentage": 50}'
        return
    fi

    # Create lock file
    touch "$LOCKFILE"

    # Get current state
    status=$(ssh -i $SSH_KEY $USER@$ROUTER "nvram get vpn_client${VPN_NUM}_state" 2>/dev/null)
    
    if [ "$status" == "2" ]; then
        # If connected, disconnect
        ssh -i $SSH_KEY $USER@$ROUTER "service stop_vpnclient${VPN_NUM}" &>/dev/null
        
        # Wait for state to change to disconnected (0)
        for i in {1..10}; do
            sleep 1
            new_status=$(ssh -i $SSH_KEY $USER@$ROUTER "nvram get vpn_client${VPN_NUM}_state" 2>/dev/null)
            if [ "$new_status" == "0" ]; then
                break
            fi
        done
    else
        # If disconnected, connect
        ssh -i $SSH_KEY $USER@$ROUTER "service start_vpnclient${VPN_NUM}" &>/dev/null
        
        # Wait for state to change to connected (2)
        for i in {1..15}; do
            sleep 1
            new_status=$(ssh -i $SSH_KEY $USER@$ROUTER "nvram get vpn_client${VPN_NUM}_state" 2>/dev/null)
            if [ "$new_status" == "2" ]; then
                break
            fi
        done
    fi
    
    # Remove lock file
    rm -f "$LOCKFILE"
}

# Main script logic
case "$1" in
    toggle)
        # Run toggle in background to prevent waybar from freezing
        (toggle_vpn & disown) &>/dev/null
        # Return immediate status for waybar
        get_vpn_status
        ;;
    *)
        get_vpn_status
        ;;
esac
