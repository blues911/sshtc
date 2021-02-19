#!/bin/bash

if [ -d /usr/local/sshtc ]; then
    echo "sshtc is already installed"
    exit 0
fi

fail=0

if [[ "$(uname)" != "Linux" ]]; then
    fail=$((fail + 1))
    echo "Error: qinfo works only on Linux"
fi

if [ ! -d ~/.config ]; then
    fail=$((fail + 1))
    echo "Error: ~/.config dir not exists"
fi

if [[ $fail > 0 ]]; then
    exit 1
fi

echo "Installing..."
# install system deps
sudo apt-get install -y python openssh-server sshpass
# install sshtc
sudo cp -r ./sshtc /usr/local/sshtc
sudo cp ./sh/sshtc /usr/local/bin/sshtc
echo "Ok"