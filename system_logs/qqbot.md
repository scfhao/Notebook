# 机器人1903280444

AppID: 1903280444
AppSecret: zwiHdmtnTyIYdaO1

## OpenClaw 原生接入流程

```bash
# 1.安装OpenClaw开源社区QQBot插件
openclaw plugins install @sliverp/qqbot@latest
# 2.配置绑定当前QQ机器人
openclaw channels add --channel qqbot --token "1903280444:zwiHdmtnTyIYdaO1"
# 3.重启本地OpenClaw服务
openclaw gateway restart
```