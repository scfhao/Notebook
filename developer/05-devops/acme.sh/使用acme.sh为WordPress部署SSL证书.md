# 使用 acme.sh 为 WordPress 部署 SSL 证书

本文档介绍如何在 Docker 环境中使用 acme.sh 为 WordPress 站点申请和部署 SSL 证书。

## 前提条件

- Docker 和 Docker Compose 已安装
- 拥有一个域名（如 store.scfhao.cn）
- 域名 DNS 解析已配置

## Docker Compose 配置

在 `wp.yml` 中添加 acme.sh 服务：

```yaml
acme-sh:
  image: neilpang/acme.sh
  container_name: acme.sh
  volumes:
    - acmeout:/acme.sh
    - /var/run/docker.sock:/var/run/docker.sock
  command: "daemon"
  environment:
    TZ: Asia/Shanghai
    DP_Id: YOUR_DNSPOD_ID
    DP_Key: YOUR_DNSPOD_KEY
    DEPLOY_DOCKER_CONTAINER_LABEL: "sh.acme.autoload.domain=store.scfhao.cn"
    DEPLOY_DOCKER_CONTAINER_KEY_FILE: "/etc/nginx/ssl/store.scfhao.cn/key.pem"
    DEPLOY_DOCKER_CONTAINER_CERT_FILE: "/etc/nginx/ssl/store.scfhao.cn/cert.pem"
    DEPLOY_DOCKER_CONTAINER_CA_FILE: "/etc/nginx/ssl/store.scfhao.cn/ca.pem"
    DEPLOY_DOCKER_CONTAINER_FULLCHAIN_FILE: "/etc/nginx/ssl/store.scfhao.cn/full.pem"
    DEPLOY_DOCKER_CONTAINER_RELOAD_CMD: "service nginx force-reload"
```

## 配置步骤

### 1. 设置别名

```bash
alias acme.sh='docker exec -i acme.sh acme.sh'
```

### 2. 注册账户

```bash
acme.sh --register-account -m your-email@example.com
```

示例输出：
```
[Sat Apr 20 12:10:39 CST 2024] Create account key ok.
[Sat Apr 20 12:10:39 CST 2024] No EAB credentials found for ZeroSSL, let's get one
[Sat Apr 20 12:10:40 CST 2024] Registering account: https://acme.zerossl.com/v2/DV90
[Sat Apr 20 12:10:43 CST 2024] Registered
[Sat Apr 20 12:10:43 CST 2024] ACCOUNT_THUMBPRINT='...'
```

### 3. 签发证书

使用 DNSPod DNS 验证：

```bash
acme.sh --issue --dns dns_dp -d store.scfhao.cn
```

### 4. Nginx 配置

在 `nginx/conf.d/default.conf` 中配置 SSL：

```nginx
server {
    listen 443 ssl;
    server_name store.scfhao.cn;

    ssl_certificate /etc/nginx/ssl/store.scfhao.cn/full.pem;
    ssl_certificate_key /etc/nginx/ssl/store.scfhao.cn/key.pem;

    # ... 其他配置
}
```

### 5. 自动部署

acme.sh 会自动将证书部署到带有指定标签的 Docker 容器，并重新加载 Nginx。

## 参考

- [acme.sh Docker 部署文档](https://github.com/acmesh-official/acme.sh/wiki/deploy-to-docker-containers)
- [acme.sh DNS API 文档](https://github.com/acmesh-official/acme.sh/wiki/dnsapi)
