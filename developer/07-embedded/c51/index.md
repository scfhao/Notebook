手把手教你学51单片机-C语言版

STC89C52: 8K flash, 512 Byte Ram, 32个IO口，3个定时器，1个UART，8个中断源。

## macOS 环境搭建及编译

### 环境搭建

1. brew install sdcc
2. http://www.wch.cn/download/CH341SER_MAC_ZIP.html
3. https://github.com/grigorig/stcgal 
4. cd stcgal
5. ./setup.py build
6. sudo ./setup.py install

### 编译

1. sdcc pmd.c
2. stcgal -P stc89 -p /dev/tty.wchusbserial14110 pmd.ihx
3. 单片机上电
