#!/bin/bash

if [ ! -d /usr/local/sshtc ]; then
    echo "sshtc is not installed"
    exit 0
fi

echo "Uninstalling..."
# uninstall sshtc
sudo rm -f /usr/local/bin/sshtc
sudo rm -rf /usr/local/sshtc
sudo rm -rf ~/.config/sshtc
echo "Ok"