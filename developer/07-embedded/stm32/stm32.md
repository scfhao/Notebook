# 在 Mac 中搭建 STM32 开发环境

1. 下载 ST-Link 调试工具

```Bash
brew install stlink
# 下面这句不确定需不需要
brew install libusb libusb-compat
```

2. 下载交叉编译工具

从[这个网站](https://launchpad.net/gcc-arm-embedded/+download)下载，速度有时候很慢。

下载好后把其中的bin目录加入PATH即可。

## 编译下载程序

```Bash
# 当然前提是有写好的 Makefile
make clean
make
sudo st-flash write main.bin 0x8000000
```

