#! /bin/bash -ex

echo "" | sudo tee /var/log/nginx/access.log > /dev/null

sudo rm /var/log/mysql/slow.log
mysqladmin -p flush-logs -ppassword # TODO: password
