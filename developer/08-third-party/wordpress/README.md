# WordPress WooCommerce 部署文档

为便于部署 WordPress WooCommerce 独立站，编写此文档。

## 依赖部署

本项目依赖于 Docker，基于 Docker Compose 构建，所以需要先安装 Docker。

## 安装步骤

1. **项目文件复制**

   将本项目文件复制于 `/opt` 目录下。

2. **修改配置文件**

   - 修改 `/opt/wp/wp.yml` 文件
   - 修改 `/opt/wp/nginx/conf.d/default.conf` 文件

3. **启动 Docker 容器**

   ```bash
   docker compose -f wp.yml up
   ```

4. **配置 SSL 证书**

   参考 [使用 acme.sh 为 WordPress 部署 SSL 证书](../../05-devops/acme.sh/使用acme.sh为WordPress部署SSL证书.md)
