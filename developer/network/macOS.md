## 配置内网路由

将内网IP（如10.开头的）访问配置到内网路由10.xxx.xxx.xxx

```
sudo route -n add -net 10.0.0.0 10.xxx.xxx.xxx
```

## DNS 配置

创建文件夹

```
mkdir /etc/resolver
```

在此文件夹中为对应域名创建DNS配置文件

```
vi efoxconn.com
```

文件内容如下，后面的IP为内网dns服务器IP

```
nameserver 10.xxx.xxx.xxx
```
