# 变量

从GitLab CI接收到一个构件后，runner就会准备构建环境。GitLab支持的的变量有三种，按照优先级从高到低的顺序分别为：

1. 保密变量。
2. YAML定义的变量。
3. 预定义变量。

如果在不同优先级别都定义了相同的变量，优先级高的变量会覆盖优先级低的变量。

## 预定义变量

由GitLab CI定义的相关变量。

## YAML定义的变量

在`.gitlab-ci.yml`文件中定义的变量，如下：

```
variables:
  DATABASE_URL: "postgres://postgres@postgres/my_database"
```

## 用户定义的变量（保密变量）

在`.gitlab-ci.yml`文件中定义的变量，所有具备项目读权限的用户都能访问，保密变量的安全性相对较高，但依然可以在构建日志中要求打印保密变量的值，比如使用`echo`命令。保密变量在`Project > Variables > Add Variable`(项目页面的`/variables`路径下)处添加，保密变量是通过安全的方式从代码服务器传送给 runner 的。

## 变量的使用

在脚本中使用变量时，在变量名前加`$`即可。

也可以在脚本中使用`export`命令列出所有的环境变量，包括保密变量。