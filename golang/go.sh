#!/bin/bash

# Detect architecture
architecture=$(uname -m)
if [[ $architecture == "x86_64" ]]; then
    arch_type="amd64"
elif [[ $architecture == "aarch64" ]]; then
    arch_type="arm64"
else
    echo "Unsupported architecture: $architecture"
    exit 1
fi

# Define Go version
ver="1.21.7"

# Download and install Go
wget "https://golang.org/dl/go$ver.linux-$arch_type.tar.gz" &&
sudo rm -rf /usr/local/go &&
sudo tar -C /usr/local -xzf "go$ver.linux-$arch_type.tar.gz" &&
rm "go$ver.linux-$arch_type.tar.gz" &&

# Add Go binary to PATH
echo "export PATH=\$PATH:/usr/local/go/bin:\$HOME/go/bin" >> $HOME/.bash_profile &&
source $HOME/.bash_profile &&

# Check Go version
go version
