# 关于.gitlab-ci.yml文件

`.gitlab-ci.yml`文件定义了在特定情况下执行的工作（job）的集合，工作（job）被定义为这个文件的根元素，有一个名称，通常会包含一个script子句：

```
job1:
	script: "execute-script-for-job1"
	
job2:
	script: "execute-script-for-job2"

```
重要的是，工作（job）之间独立运行互不影响。

> 需要注意的是这个文件中的缩进方式需要用空格而不是tab。

## .gitlab-ci.yml

YAML语法可以指定更复杂的操作：

```
image: ruby:2.1
services:
  - postgres
  
before_script:
  - bundle_install
  
stages:
  - build
  - test
  - deploy
  
job1:
  stage: build
  script:
    - execute-script-for-job1
  only:
    - master
  tags:
    - docker

```
这里有一些保留的关键字不可以用做工作（job）名称：

Keyword | Required | Description
--------|----------|------------
image | no | Use docker image,covered in Use Docker
services | no | Use docker services,covered in Use Docker
stages | no | Define build stages
types | no | Alias for stages
before_script | no | Define commands that run before each job's script
variables | no | Define build variables
cache | no | Define list of files that should be cached between subsequent runs

### image 和 services

这里可以指定在构建时会用到的一个自定义的Docker image和服务列表。这个特性的配置在Use Docker部分文档中描述。

### before_script

`before_script` 用来定义在所有的构建（包括部署）前执行的命令。可以是一个数组或多行的字符串。

### stages

`stages`用来定义可以被工作使用的构建阶段。指定`stage`可以用于灵活的多阶段管道（pipelines）。`stages`中元素的顺序定义里构建执行的顺序：

1. 同一个阶段的构建并行执行。
2. 下一阶段的构建在本阶段成功后执行。

让我们想一下下面的定义了3个阶段的例子：

```
stages:
  - build 
  - test
  - deploy

```

1. 首先，所有属于build的工作被并行的执行。
2. 如果属于build的工作都成功了，test的工作开始并行的执行。
3. 如果test的工作都成功了，deploy的工作开始并行执行。
4. 如果所有deploy的工作成功了，这次提交将被标记为success。
5. 如果任何一个工作失败了，提交会被标记为failed，后续阶段的工作也不会被继续执行。

还需要提两个特殊情况：

1. 如果`.gitlab-ci.yml`文件中没有定义`stages`，可以使用默认定义的`build`，`test`和`deploy`。
2. 如果一个工作（job）没有指定`stage`，默认使用`test`。

### types 

阶段（stages）的别名。

### 变量（variables）

*注意：在GitLab Runner v0.5.0中推出。*

GitLab CI允许在`.gitlab-ci.yml`文件中添加设置构建环境的变量。这些变量被保存在git仓库中用于存储不敏感的工程配置，例如：

```
variables:
  DATABASE_URL: "postgres://postgres@postgres/my_database"

```
这些变量可以在所有可执行的命令和脚本中使用。
YAML定义的变量也会被在服务容器中被创建。这样允许对它们进行微调。

### 缓存cache

缓存用来指定多次构建之间应该被缓存的文件或目录。


      






















## 验证.gitlab-ci.yml

每个GitLab CI实例都有一个叫做 Lint 的内置的调试工具。你可以在你的 gitlab 实例的 `/ci/lint` 下找到链接，当前环境的链接为`http://git.corp.zxxk.com/ci/lint`，再次强调这个文件中的缩进要用空格。

## 跳过构建

如果你的 commit message 中包含`[ci skip]`，这个提交会被创建但构建会被跳过。