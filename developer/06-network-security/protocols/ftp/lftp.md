# lftp

## 参考资料

* 官方手册: man lftp
* 内置帮助: help 命令
* 在线文档: https://lftp.yar.ru/
* GitHub: https://github.com/lavv17/lftp

## 连接隐式 FTPS 服务器

lftp -e "set ftp:ssl-force true; set ssl:verify-certificate false; set ftp:ssl-auth TLS; open ftp://ftpuser:Foxconn@88!@10.213.135.76:990"

