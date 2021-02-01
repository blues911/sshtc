#!/bin/bash
# sshtc install script

if [ -d /usr/local/sshtc ]; then
    echo "sshtc is already installed"
    exit 0
fi

fail=0

if [[ "$(whoami)" != "root" ]]; then
    fail=$((fail + 1))
    echo "Error: permission denied (run this script as root)"
fi

if [[ "$(uname)" != "Linux" ]]; then
    fail=$((fail + 1))
    echo "Error: qinfo works only on Linux"
fi

if [[ "$(which python)" == "" ]]; then
    fail=$((fail + 1))
    echo "Error: python not found"
fi

if [[ "$(which ssh)" == "" ]]; then
    fail=$((fail + 1))
    echo "Error: ssh not found"
fi

if [[ "$(which sshpass)" == "" ]]; then
    fail=$((fail + 1))
    echo "Error: sshpass not found"
fi

if [ ! -d ~/.config ]; then
    fail=$((fail + 1))
    echo "Error: ~/.config dir not exists"
fi

if [[ $fail > 0 ]]; then
    exit 1
fi

echo "Installing..."
cp -r ./sshtc /usr/local/sshtc
cp ./sh/sshtc /usr/local/bin/sshtc
echo "Ok"