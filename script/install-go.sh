#!/bin/bash -ex

wget https://go.dev/dl/go1.21.0.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz
rm go1.21.0.linux-amd64.tar.gz

echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc

# これ以降はshellでやる
source ~/.bashrc
go version
