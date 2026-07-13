1. 安装

```bash
brew install aria2
```

2. 简单实用

安装完成后，就可以简单使用了

```bash
aria2c <url>
```

3. rpc 调用

rpc 调用可实现失败自动重试，启动 rpc 服务

```bash
# 先启动 RPC 服务（带自动重试参数）
aria2c --enable-rpc --rpc-listen-port=6800 --max-tries=0 --retry-wait=5 --check-certificate=false -D
```

添加下载项：

```bash
# 然后用 curl 添加任务
curl -X POST http://localhost:6800/jsonrpc \
  -H 'Content-Type: application/json' \
  -d '{
    "jsonrpc":"2.0",
    "method":"aria2.addUri",
    "params":[["https://lf-cdn.trae.com.cn/obj/trae-com-cn/pkg/app/releases/stable/2.3.46696/darwin/Trae_CN-darwin-arm64.dmg"]],
    "id":"1"
  }'
```

查看进度：

```bash
# 查看所有任务
curl -X POST http://localhost:6800/jsonrpc \
  -H 'Content-Type: application/json' \
  -d '{
    "jsonrpc":"2.0",
    "method":"aria2.tellActive",
    "params":[],
    "id":"1"
  }'
```

4.  安装图形界面

```bash
brew install --cask ariang
```
