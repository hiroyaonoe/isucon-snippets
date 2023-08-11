#! /bin/bash -ex

find "etc" -type f | while read line; do
  cp -ir "./$line" "/$line"
done
