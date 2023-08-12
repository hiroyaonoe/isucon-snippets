# OD(Linux)のTips

# File Descripter
`etc/systemd/system/mysql.service`参照

# カーネルパラメータ調整
`/etc/sysctl.conf`を書き換えて以下で反映
```bash
sudo sysctl -p
```
確認
```
sudo sysctl -a | grep 
```

max connectionを増やす
```
net.core.somaxconn = 10000  # 32768 (2^15) くらいまで大きくしても良いかも
net.ipv4.ip_local_port_range = 10000 60999  # portの範囲を広げる
```

TCPコネクション再利用
```
net.ipv4.tcp_tw_reuse = 1
```


https://gist.github.com/south37/d4a5a8158f49e067237c17d13ecab12a#file-05_os-md
