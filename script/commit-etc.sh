#! /bin/bash -ex

SERVER=$1 # 数字を指定
# DIRECTORIES="/etc/mysql /etc/nginx /etc/systemd/system"
DIRECTORIES="/etc/apache2 /etc/mysql"

if [ -z $SERVER ]; then
  echo "Please set SERVER"
  exit 1
fi

mkdir -p "server${SERVER}/etc"
for directory in $DIRECTORIES; do
  cp -ir "$directory" "./server${SERVER}$directory"
done
