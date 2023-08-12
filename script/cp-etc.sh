#! /bin/bash -ex

SERVER=$1

if [ -z $SERVER ]; then
  echo "Please set SERVER"
  exit 1
fi

find "etc" -type f | while read line; do
  cp -ir "./$line" "/$line"
done
