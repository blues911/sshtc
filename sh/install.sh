#!/bin/bash

if [ -d /usr/local/sshtc ]; then
    echo "sshtc is already installed"
    exit 0
fi

if [[ "$(uname)" != "Linux" ]]; then
    echo "Error: sshtc works only on Linux"
    exit 1
fi

if [[ "$(whoami)" != "root" ]]; then
    echo "Error: permission denied (run this script as root)"
    exit 1
fi

if [ ! -d ~/.config ]; then
    echo "Error: ~/.config dir not exists"
    exit 1
fi

echo "Installing..."
# install system deps
apt-get install -y python openssh-server sshpass
# install sshtc
cp -r ./sshtc /usr/local/sshtc
touch /usr/local/bin/sshtc
chmod +x /usr/local/bin/sshtc
cat > /usr/local/bin/sshtc << EOF
#!/bin/bash

if [ ! -d ~/.config/sshtc ]; then
    mkdir ~/.config/sshtc
    chmod 775 ~/.config/sshtc
    touch ~/.config/sshtc/data.json
    chmod 775 ~/.config/sshtc/data.json
    echo "[]" >> ~/.config/sshtc/data.json
fi

$(which python) /usr/local/sshtc/main.py
EOF
echo "Ok"