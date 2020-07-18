IPAPatch方便实现在真机上调试第三方App，https://github.com/Naituw/IPAPatch.git

按照 README 操作即可。需要说明的是 IPAPatch 模版用到的 ipa 文件：

手动创建该 ipa 文件：

1. 用 dumpdecrypted 破解目标应用的二进制文件。
2. 从 iTunes 下载目标应用的 ipa 文件。
3. 将步骤2下载的 ipa 文件解压，用步骤1中的二进制文件替换解压后文件夹中的二进制文件。
4. 将步骤3中解压出来的文件夹中的 Payload 文件夹压缩并重命名为 app.ipa。

其余步骤参阅 IPAPatch 的 README.md。
