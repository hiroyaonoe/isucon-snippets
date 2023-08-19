# 全体の流れ&チェックリスト

## 開始直後(1時間程度)
- GitHubにpush
  - 一旦アプリ全体(おそらく`$HOME`)
    - すでにあるディレクトリにcloneして内容をcommitする場合
    - ```
      git init --initial-branch main
      git remote add origin <clone URL>
      git fetch
      git checkout main # 2台目以降の場合は重複ファイルを削除する
      vim .gitignore # 必要ないファイルをignore(特にSecretやDBデータなど注意)
      git add .
      git commit -m "HOME"
      ```
  - etc配下は必要に応じて`server1`, `server2`, `server3`へ
    - `script/commit-etc.sh 1 /etc/mysql/conf.d/my.cnf`
  - go以外のいらないやつは削除しても良い

- 分析ツールの導入
  - `script/install.sh`
    - [alp](https://github.com/tkuchiki/alp)
    - [pt-query-digest](https://docs.percona.com/percona-toolkit/pt-query-digest.html)
  - netdata
    - https://app.netdata.cloud/
    - ここからインストール
    - 19999をport-forwardする(firewallいじるのはダメな場合があるのでやらない方がよい)
      - `ssh -L 19999:localhost:19999 remote-server`(`-f`でバックグラウンド実行)
- configを適用
  - MySQLのslow query log
  - `sudo systemctl restart mysql.service`
- ベンチマーク実行
- レギュレーション・マニュアルをよく読む
  - スコアの算出方法・失格条件
  - アクセスポイント
  - データ・テーブル構造
  - Webサイトにアクセスしてみる
  - 初期化方法
- 技術スタックを理解する
  - Systemd
  - Nginx, Apache
  - MySQL, PostgreSQL(Versionも)
  - Redis, Memcached
  - HTTP, gRPC
- 初期ベンチマーク結果を分析

## 改善フェーズ
### 改善の流れ
- ベンチマーク結果を分析
- 小さめに施策を決める
  - Issueにでも書いておく
- ブランチ切って改善
  - `git checkout -b target-branch`
- 必要なら対象ブランチにmainをmerge (not mainに対象ブランチをmerge)
  - `git checkout target-branch && git merge main`
- サーバーで対象ブランチにcheckout
  - `git pull && git checkout target-branch`
- ベンチマーク実行
- 効果を見てmainにmergeするか判断
  - ベンチマーク結果にはあまり変化がなくても後に影響がある可能性もある
### ベンチマーク実行手順
- `script/cp-etc.sh` (etcをコピー)
- `script/restart.sh` (アプリ, nginxなどを再起動)
- `script/flush-log.sh` (ログを削除, rotate)
- ベンチマーク実行(結果を保存すること)
- `script/analyze.sh` (分析ツールを実行して結果をファイルに保存)

## 最後(1時間程度)
- ブランチをmainにする
- 再起動試験(再起動してからベンチマーク通るか)
- 分析ツール削除
  - アプリのログ
  - pprof
  - MySQLのslow query log, 普通のlog
  - netdata
    - https://learn.netdata.cloud/docs/maintaining/uninstall-netdata-agents
    - systemctl statusも見て削除確認
- いらないファイル削除
  - ログでディスク埋まる可能性がある
- HTTP, CSSの表示は正常か

# その他
## 気をつけること
- 推測するな、計測せよ
- 施策は小さく

## よくある改善方法
- DBのindex
- N+1
- クエリにLIMITつける
- bulk insert
  - 場合によってはキューイングによってまとめて非同期で
- インメモリキャッシュ
  - マニュアルにキャッシュできるか書いてある
  - 場合によってはRedis使うかも
- Cache-Controlヘッダをつける
- Nginx, MySQLのconfigいじり
  - 特にmax connection, bufferなど
  - 静的ファイルをnginxで配信
- DBとAppのサーバー分ける
  - Appをスケールアウトさせても良い
    - Nginxでロードバランス
  - 難しいけどDBの水平/垂直スケールも？
- 画像をDBからファイルへ
実装は↓が参考になるかも  
https://github.com/hiroyaonoe/isucon11-qualify/blob/master/docs/strategy.md

## 改善途中の分析方法
- MySQLでEXPLAINしてみる
  - Indexの使用状況とかわかる
  - pt-query-digestでも見れるかも
- htop(top)
  - netdataでも見れるかも
