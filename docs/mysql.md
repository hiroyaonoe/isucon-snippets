# MySQLのTips

## DBにlocalhost以外からアクセスできるようにする
```
[mysqld]
bind-address = 0.0.0.0
mysqlx-bind-address	= 0.0.0.0
```

ユーザーのhost変更(@以降を%にする)
```mysql
RENAME USER 'isucon'@'localhost' to 'isucon'@'%';
SELECT user, host FROM mysql.user;
```

## Max Connections
OS側でも上限上げる必要あり
```
[mysqld]
max_connections=10000
```
確認方法
```mysql
SHOW variables LIKE "%max_connections%";
SHOW variables LIKE "%open_files_limit%"; # OS側設定
```

## Snippets
```bash
# 雑にログインする
sudo mysql
```

## mysqldump
dump
```
mysqldump -u user dbname | gzip > isucon.dump.gz 
```
ローカルにDB作成
```
$ mysql -uroot
mysql> create database isucon;
```
restore
```
gzcat isucon.dump.gz | mysql -u root isucon
```


https://gist.github.com/south37/d4a5a8158f49e067237c17d13ecab12a#file-03_mysql-md
