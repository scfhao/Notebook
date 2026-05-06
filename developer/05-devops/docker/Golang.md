## 使用官方镜像

用户可以使用`docker run`指令直接启动Go语言的交互环境：

```Bash
docker run -it golang /bin/bash
```

Dockerfile方式：

```Dockerfile
FROM golang:1.6-onbuild # 显示声明基础镜像版本，利于后期维护。
```

onbuild版本Dockerfile的具体内容如下：

```Dockerfile
FROM golang:1.6

RUN mkdir -p /go/src/app
WORKDIR /go/src/app

CMD ["go-wrapper", "run"] # 通过'go-wrapper'程序执行当前目录下主函数。

ONBUILD COPY . /go/src/app # 拷贝当前项目代码至运行目录
ONBUILD RUN go-wrapper download # 下载依赖，具体实现参考'go-wrapper'源码
ONBUILD RUN go-wrapper install # 安装依赖，具体实现参考'go-wrapper'源码
# 'go-wrapper'源码地址：https://github.com/docker-library/golang/blob/master/go-wrapper
# 'Dockerfile'源码地址：https://github.com/docker-library/golang/blob/master/1.6/onbuild/Dockerfile
```

```Bash
docker build -t golang-image .
docker run -it --rm --name golang-container golang-image + exec app
# 如果用户需要在容器中编译Go代码，但是不需要在容器中运行它，那么可以执行：
docker run --rm -v "$(pwd)":/usr/src/myapp -w /usr/src/myapp golang go build -v _/usr/src/myapp
# 以上指令会将Go项目文件夹作为Docker数据卷挂载起来并作为运行目录。然后，Docker会在工作目录中编译代码。执行go build并输出可执行文件至myapp。
# 如果项目中含有Makefile，那么用户可以在容器中执行：
docker run --rm -v "$(pwd)":/usr/src/myapp -w /usr/src/myapp golang make
# 如果需要在常用的linux\arm64架构之外的其他架构的平台（如windows/386）编译Go应用，则可以在指令中加入cross标签
docker run --rm -v "$(pwd)":/usr/src/myapp -w /usr/src/myapp -e GOOS=windows -e GOARCH=386 golang:1.3.1-cross go build -v
```

## Go项目容器化

首先，用户下载Golang官方提供的outyet示例项目：

```Bash

```







































