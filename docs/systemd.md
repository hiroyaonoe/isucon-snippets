# systemdのTips
## Snippets
```bash
sudo systemctl status mysql.service
sudo systemctl restart mysql.service

sudo systemctl start mysql.service
sudo systemctl enable mysql.service

sudo systemctl stop mysql.service
sudo systemctl disable mysql.service

sudo journalctl -f
sudo journalctl -u mysql.service
```
