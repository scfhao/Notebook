使用 acme.sh 签发证书后，需再进行安装步骤，这样后续自动续签的证书才能被正确部署：

```bash
acme.sh --install-cert -d home.scfhao.cn \
  --key-file /etc/nginx/ssl/home.scfhao.cn.key \
  --fullchain-file /etc/nginx/ssl/home.scfhao.cn.crt \
  --reloadcmd "systemctl reload nginx"
```
