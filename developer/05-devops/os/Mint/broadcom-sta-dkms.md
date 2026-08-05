Linux Mint 22.3 Cinnamon, with Linux 7.0.0-28-generic
Linux Mint 22.3 Cinnamon, with Linux 6.14.0-37-generic

恢复模式下如果没网，可以先在恢复模式菜单里选 Enable networking 启用网络，再进入 root shell。

# Broadcom 无线网卡驱动 broadcom-sta-dkms 在新版本 Linux 内核下编译失败问题

1. 清理已安装的损坏驱动

```bash
# 先卸载失败的驱动
apt purge -y broadcom-sta-dkms
# 清理DKMS残留的编译缓存
rm -rf /var/lib/dkms/broadcom-sta*
# 修复依赖
apt autoremove -y && apt clean
```

2. 更新软件源并安装修复版驱动

```bash
# 更新软件源列表
apt update
# 安装编译必备工具和内核头文件
apt install -y build-essential linux-headers-$(uname -r) dkms
# 安装驱动，这一步会提示错误，在旧版内核安装成功，新版内核失败
apt install -y broadcom-sta-dkms
```

如果因为 broadcom-sta-dkms 之前被 mark 过 hold，需要先取消：

```bash
sudo apt-mark unhold broadcom-sta-dkms
```

3. 加载驱动

```bash
modprobe wl && lsmod | grep wl
```

4. 重启

```bash
reboot
```

## 其他

1. 检查驱动是否安装成功

```bash
# 查看驱动模块是否存在
ls /usr/src/broadcom-sta*

# 查看DKMS中是否注册了驱动
dkms status
```

正常情况下，会输出类似 broadcom-sta/6.30.223.271, 6.14.0-37-generic, x86_64: installed 的内容。

2. 加载驱动模块并验证

```bash
# 加载驱动模块
modprobe wl

# 查看模块是否成功加载
lsmod | grep wl
> 输出如下则加载成功
wl  		6488064 	0
cfg80211 	1437696     1 wl

# 查看无线网卡设备
lspci -k | grep -A 3 -i network
```
