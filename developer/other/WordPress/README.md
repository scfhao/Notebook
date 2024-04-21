# wordpress woocommerce 部署文档

为便于部署 wordpress woocommerce 独立站，编写此文档。

## 依赖部署

本项目依赖于 docker，基于 docker compose 构建，所以需要先安装 docker。

## 安装步骤

1. 项目文件复制。将本项目文件复制于`/opt`目录下。
2. 修改`/opt/wp/wp.yml`文件。
3. 修改`/opt/wp/nginx/conf.d/default.conf`文件。
4. 启动 docker 容器

```
docker compose -f wp.yml up
```

5. 配置acme

```
alias acme.sh='docker exec -i acme.sh acme.sh'
```

6. 注册

```
acme.sh --register-account -m scfhao@126.com
```

[Sat Apr 20 12:10:39 CST 2024] Create account key ok.
[Sat Apr 20 12:10:39 CST 2024] No EAB credentials found for ZeroSSL, let's get one
[Sat Apr 20 12:10:40 CST 2024] Registering account: https://acme.zerossl.com/v2/DV90
[Sat Apr 20 12:10:43 CST 2024] Registered
[Sat Apr 20 12:10:43 CST 2024] ACCOUNT_THUMBPRINT='BhXd0BYblUVtkX7PUDy-yGKe86rHLv_f9AI1AR07z7c'

7. 签发证书

```
acme.sh --issue --dns dns_dp -d store.scfhao.cn
```

https://github.com/acmesh-official/acme.sh/wiki/deploy-to-docker-containers