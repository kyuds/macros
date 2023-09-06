#!/bin/bash
# helper tool to use BURP SUITE without
# having to open settings to reset proxy.
# use modes "on", "off", and "status"
# with relevant params (HOST, PORT).
 
MODE="$1"
HOST="$2"
PORT="$3"

function get_status {
    echo "[HTTPS]"
    networksetup -getsecurewebproxy wi-fi
    echo "[HTTPS]"
    networksetup -getwebproxy wi-fi
}

if [ "$MODE" == "on" ]; then
    echo "Proxy On >> Host: $HOST, Port: $PORT"
    networksetup -setwebproxy wi-fi $HOST $PORT
    networksetup -setsecurewebproxy wi-fi $HOST $PORT
    networksetup -setwebproxystate wi-fi on
    networksetup -setsecurewebproxy wi-fi on
    get_status
elif [ "$MODE" == "status" ]; then
    get_status
elif [ "$MODE" == "off" ]; then
    echo "Proxy Off"
    networksetup -setwebproxystate wi-fi off
    networksetup -setsecurewebproxystate wi-fi off
elif [ "$MODE" == "help" ]; then
    echo "Proxy commands: 'on', 'off', 'status'"
    echo "For 'on', enter host and port number"
elif [ -z "$MODE" ]; then
    echo "Please enter a command. Type 'help' for details"
else
    echo "Command '$MODE' does not exist. Type 'help' for details"
fi



