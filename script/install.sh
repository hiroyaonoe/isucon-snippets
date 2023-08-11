#! /bin/bash -ex

# alp
wget https://github.com/tkuchiki/alp/releases/download/v1.0.14/alp_linux_amd64.tar.gz
tar -zxvf alp_linux_amd64.tar.gz
sudo install ./alp /usr/local/bin/alp

# pt-query-digest
sudo apt-get install percona-toolkit
