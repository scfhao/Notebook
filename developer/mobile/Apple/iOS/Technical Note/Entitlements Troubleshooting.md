# Technical Note TN2415 Entitlements Troubleshooting

entitlements翻译为授权

在 Xcode 构建、应用安装或提交中可能遇到的问题的解决方案。

## 介绍

## 解决流程

### 检查一个 profile 文件的授权

可以从开发者网站下载 provisioning profile 文件到 Mac 上，可以通过下面的命令查看 prifile 中包含的授权：

```shell
$ security cms -D -i /path/to/iOSTeamProfile.mobileprovision
```

> 注意：经过代码签名的应用的 provisioning profile 文件内置于应用的沙盒文件根目录。显示 .app 包内容可以找到名为`embedded.mobileprovision`的该文件。

provisioning profile 文件中内置的授权需要注意的几个地方：

* 
*
*
*

### 检查已构建的 app 的授权

运行下面的命令会打印应用签名中的授权：

```shell
$ codesign -d --ent :- /path/to/the.app
```



## 支持信息


