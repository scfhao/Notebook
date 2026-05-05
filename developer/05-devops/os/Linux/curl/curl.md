# curl

## 请求头

`-H`或`--header`参数。

对于常规请求头，还提供了专门的参数：

* -A(or --user-agent):设置"User-Agent"字段。
* -b(or --cookie):设置"Cookie"字段。
* -e(or --referer):设置"Referer"字段。

例如，以下两个命令是等效的：

```
$ curl -H "User-Agent: my browser" http://con.com
$ curl -A "my browser" http://cnn.com
```