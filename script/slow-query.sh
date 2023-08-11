#! /bin/bash -ex

sudo pt-query-digest /var/log/mysql/slow.log

# 文字化け等でpt-query-digest使えない場合
# sudo mysqldumpslow -s t | head -n 20
