# 属性列表（Property List）
Cocoa中的属性列表可以用三种方式进行存储：XML形式、二进制格式和葱OpenStep继承下来的老式ASCII格式，你可以将属性列表序列化为XML或二进制格式，对老式格式，只提供了读取的API。Core Foundation只支持XML形式。

XML格式比二进制格式更便于移植、可读性高，但二进制属性列表更紧凑，占用内存下，读写速度更快。