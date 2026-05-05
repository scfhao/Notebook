使用 ftp 進行文件交換，FTP 服務器根目錄下建有`upload`、`download`兩個文件夾，將要打包的文件上傳與`upload`，打包完成後從`download`文件夾下載打包好的`ipa`文件。

為方便紀錄，在`upload`和`download`文件夾下按日期建立對應的工作文件夾。

1. 連結 ftp 服務器，按提示輸入用戶名和密碼（ipegty:Foxconn88）：

```
ftp 10.65.8.122
```

2. 在`upload`目錄下創建當天日期文件夾：

```
cd upload
mkdir 20241111
cd 20241111
```

3. 上傳文件：

```
put /local/path/xxx.zip /upload/20241111/xxx.zip
```

4. 下載文件

```
get remote-filename local-filename
```

5. 其他命令：

```
delete 刪除文件
rm 刪除文件夾
```

# 7z 压缩

```
7zz a nws.7z 智安
```