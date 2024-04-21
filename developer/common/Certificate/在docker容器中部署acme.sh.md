# 部署 acme.sh 到 docker 容器

有3种 scme.sh 可以部署证书到容器中的场景。

1. acme.sh 安装在 docker 宿主机上，向容器中部署证书。
2. 运行`neilpang/acme.sh`容器，这意味着 acme.sh 运行在一个容器中，它可以将证书部署到该主机上的其他容器中。
3. 在一台机器上运行 acme.sh，向其他机器上的 docker 容器部署证书（这个场景 acme.sh 目前还不支持）。

下面我们一个一个介绍

## 从 Docker 宿主机向容器中部署证书

acme.sh 安装于 docker 宿主机，它先签发一个证书，然后你可以想要把证书/密钥部署到一个容器中。

1. 请在容器上设置一个标签，用于之后查找这个容器。

```
docker run --rm -it -d --label=sh.acme.autoload.domain=example.com nginx:latest
```

2. 记住上面设置的标签值，现在我们可以部署了：

```
# The label value to find the container
export DEPLOY_DOCKER_CONTAINER_LABEL=sh.acme.autoload.domain=example.com

# The target file path in the container.
# The files will be copied to the position in the container.
export DEPLOY_DOCKER_CONTAINER_KEY_FILE="/etc/nginx/ssl/example.com/key.pem"
export DEPLOY_DOCKER_CONTAINER_CERT_FILE="/etc/nginx/ssl/example.com/cert.pem"
export DEPLOY_DOCKER_CONTAINER_CA_FILE="/etc/nginx/ssl/example.com/ca.pem"
export DEPLOY_DOCKER_CONTAINER_FULLCHAIN_FILE="/etc/nginx/ssl/example.com/full.pem"

# The command to reload the service in the container.
export DEPLOY_DOCKER_CONTAINER_RELOAD_CMD="service nginx force-reload"

acme.sh --deploy --deploy-hook docker -d example.com
```

## 在一个容器中向另一个容器部署证书

我们使用`neilpang/acme.sh`镜像为例，实际上你可以在任何容器中使用 acme.sh。

1. 和前面一样，首先使用标签运行目标容器：

```
docker run --rm -it -d --label=sh.acme.autoload.domain=example.com nginx:latest
```

2. 在一个容器中运行 acme.sh：

更多详情可见：[https://github.com/Neilpang/acme.sh/wiki/Run-acme.sh-in-docker#3-run-acmesh-as-a-docker-daemon](https://github.com/Neilpang/acme.sh/wiki/Run-acme.sh-in-docker#3-run-acmesh-as-a-docker-daemon)

让我们以守护进程的方式运行 acme.sh，与上述链接不同的是，我们将 docker 守护进程套接字`/var/run/docker.sock`挂载到容器中。

```
docker run --rm  -itd  \
  -v "$(pwd)/out":/acme.sh  \
  --net=host \
  --name=acme.sh \
  -v /var/run/docker.sock:/var/run/docker.sock \
  neilpang/acme.sh daemon
```

3. 让我们先颁发证书：

```
docker  exec \
    -e CF_Email=xxx@exmaple.com \
    -e CF_Key=xxxxxxxxxx  \
    acme.sh --issue -d example.com  --dns dns_cf
```

4. 让我们现在部署证书：

```
docker  exec \
    -e DEPLOY_DOCKER_CONTAINER_LABEL=sh.acme.autoload.domain=example.com \
    -e DEPLOY_DOCKER_CONTAINER_KEY_FILE=/etc/nginx/ssl/example.com/key.pem \
    -e DEPLOY_DOCKER_CONTAINER_CERT_FILE="/etc/nginx/ssl/example.com/cert.pem" \
    -e DEPLOY_DOCKER_CONTAINER_CA_FILE="/etc/nginx/ssl/example.com/ca.pem" \
    -e DEPLOY_DOCKER_CONTAINER_FULLCHAIN_FILE="/etc/nginx/ssl/example.com/full.pem" \
    -e DEPLOY_DOCKER_CONTAINER_RELOAD_CMD="service nginx force-reload" \
    acme.sh --deploy -d example.com  --deploy-hook docker
```

5. 综上，docker compose 的示例：

```
version: '3.4'
services:
  web:
    image: nginx
    container_name: nginx
    labels:
      - sh.acme.autoload.domain=example.com

  acme.sh:
    image: neilpang/acme.sh
    container_name: acme.sh    
    command: daemon
    volumes:
      - ./acmeout:/acme.sh
      - /var/run/docker.sock:/var/run/docker.sock 
    environment:
      - DEPLOY_DOCKER_CONTAINER_LABEL=sh.acme.autoload.domain=example.com
      - DEPLOY_DOCKER_CONTAINER_KEY_FILE=/etc/nginx/ssl/example.com/key.pem
      - DEPLOY_DOCKER_CONTAINER_CERT_FILE="/etc/nginx/ssl/example.com/cert.pem"
      - DEPLOY_DOCKER_CONTAINER_CA_FILE="/etc/nginx/ssl/example.com/ca.pem"
      - DEPLOY_DOCKER_CONTAINER_FULLCHAIN_FILE="/etc/nginx/ssl/example.com/full.pem"
      - DEPLOY_DOCKER_CONTAINER_RELOAD_CMD="service nginx force-reload"
```