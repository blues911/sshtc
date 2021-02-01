#!/bin/bash
# sshtc uninstall script

if [ ! -d /usr/local/sshtc ]; then
    echo "sshtc is not installed"
    exit 0
fi

if [[ "$(whoami)" != "root" ]]; then
    echo "Error: permission denied (run this script as root)"
    exit 1
fi

echo "Uninstalling..."
rm -f /usr/local/bin/sshtc
rm -rf /usr/local/sshtc
rm -rf ~/.config/sshtc
echo "Ok"