#! /bin/bash -ex

ALPSORT=sum
# TODO: ALPM設定する(以下は参考例)
# ALPM="/api/isu/.+/icon,/api/isu/.+/graph,/api/isu/.+/condition,/api/isu/[-a-z0-9]+,/api/condition/[-a-z0-9]+,/api/catalog/.+,/api/condition\?,/isu/........-....-.+"
ALPM=
OUTFORMAT=count,method,uri,min,max,sum,avg,p99

sudo cat /var/log/nginx/access.log | alp ltsv --sort $ALPSORT --reverse -o $OUTFORMAT -m $ALPM
