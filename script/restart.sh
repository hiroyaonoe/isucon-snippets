#! /bin/bash -ex

# TODO: サービス名、パスは適宜変更

cd ~/webapp/go
go build
sudo systemctl restart isucondition.go.service
sudo systemctl restart nginx.service # reloadでも良い
sudo systemctl reater mysql.service
