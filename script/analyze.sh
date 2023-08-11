#! /bin/bash -ex

DATE=`date +%Y-%m-%d_%H-%M-%S`


# alp
ALPSORT=sum
# TODO: ALPM設定する(以下は参考例)
# ALPM="/api/isu/.+/icon,/api/isu/.+/graph,/api/isu/.+/condition,/api/isu/[-a-z0-9]+,/api/condition/[-a-z0-9]+,/api/catalog/.+,/api/condition\?,/isu/........-....-.+"
ALPM=
OUTFORMAT=count,method,uri,min,max,sum,avg,p99
sudo cat /var/log/nginx/access.log | alp ltsv --sort $ALPSORT --reverse -o $OUTFORMAT -m $ALPM >> ./analyze/${DATE}_alp.txt


# slow query
sudo pt-query-digest /var/log/mysql/slow.log >> ./analyze/${DATE}_slow-query.txt
# 文字化け等でpt-query-digest使えない場合
# sudo mysqldumpslow -s t | head -n 20 >> ./analyze/${DATE}_slow-query.txt
