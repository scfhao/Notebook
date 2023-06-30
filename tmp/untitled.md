# 使用 MicroProfile、ConfigMaps、Secrets 实现外部化应用配置

在本教程中，你会学到如何以及为什么要实现外部化微服务应用配置。具体来说，你将学习如何使用 Kubernetes ConfigMaps 和 Screts 设置环境变量，然后在 MicroProfile config 中使用它们。

## 准备开始

### 创建 Kubernetes ConfigMaps 和 Secrets

在 Kubernetes 中，为 docker 容器设置环境变量有几种不同的方式，比如：Dockerfile、kubernetes.yml、Kubernetes ConfigMaps 和 Kubernetes Secrets。在本教程中，你将学到怎么用后两个方式去设置你的环境变量，而环境变量的值将注入到你的微服务里。使用 ConfigMaps 和 Secrets 的一个好处是他们能在多个容器间复用，比如赋值给不同的容器中的不同环境变量。

ConfigMaps 是存储非机密键值对的 API 对象。在互动教程中，你会学到如何用 ConfigMap 来保存应用名字。ConfigMap 的更多信息，你可用在[这里](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/configure-pod-configmap/)找到文档。

Secrets 尽管也用来存储键值对，但区别于 ConfigMaps 的是：它针对机密/敏感数据，且存储格式为 Base64 编码。secrets 的这种特性使得它适合于存储证书、密钥、令牌，上述内容你将在交互教程中实现。Secrets 的更多信息，你可用在[这里](https://kubernetes.io/zh-cn/docs/concepts/configuration/secret/)找到文档。您必须明确告诉 kubectl 向您展示机密的内容。此外，当它确实向你显示信息时，它只向你显示 Base64 编码版本，以便不经意的旁观者不会意外看到任何敏感数据。默认情况下，机密不提供任何加密，这是您需要自己完成或找到替代选项进行配置的操作。

### 从代码外部化配置

外部化应用配置之所以有用处，是因为配置常常根据环境的不同而变化。为了实现此功能，我们用到了 Java 上下文和依赖注入（Contexts and Dependency Injection，CDI）、MicroProfile Config。MicroProfile config 是 MicroProfile 的功能特性，是一组开放 Java 技术，用于开发、部署云原生微服务。

CDI 提供一套标准的依赖注入能力，使得应用程序可用由相互协作的、松耦合的 beans 组装而成。MicroProfile config 为 app 和微服务提供从各种来源，比如应用、运行时、环境，获取配置参数的标准方法。基于来源定义的优先级，属性可用自动的合并到单独一组应用可以通过 API 访问到的属性。CDI & MicroProfile 都会被用在交互教程中，用来从 Kubernetes ConfigMaps 和 Secrets 获得外部提供的属性，并注入应用程序代码中。

很多开源框架、运行时支持 MicroProfile Config。对于整个互动教程，你都可以使用开放的库、灵活的开源 Java 运行时，去构建运行云原生的 apps 和微服务。然而，任何 MicroProfile 兼容的运行时都可以用来做替代品。

## 交互教程

### 构建并部署 Java 微服务

有两个微服务：system 和 inventory，system 返回 JVM 属性，inventory 读取来自 system 微服务的属性。先编译两个微服务：

```SHELL
mvn package -pl system
mvn package -pl inventory
```

部署：

```SHELL
kubectl apply -f kubernetes.yaml
```

### 向微服务发送请求

下面的两个命令会检查 pods 的状态是否为 ready：

```SHELL
kubectl wait --for=condition=ready pod -l app=inventory

kubectl wait --for=condition=ready pod -l app=system
#或者
kubectl get --watch pods
```

使用`curl`向 system 微服务发送`HTTP GET`请求。

```SHELL
curl -u bob:bobpwd http://$(minikube ip):31000/system/properties
```

使用`curl`调用 inventory 服务：

```SHELL
curl http://$(minikube ip):32000/inventory/systems/system-service
```

inventory 服务将会调用 system 服务并保存响应，然后返回结果。

本教程中，你将使用 Kubernetes ConfigMap 修改`X-App-Name:`响应头。先用 curl 看一下当前的值：

```SHELL
curl -# -I -u bob:bobpwd -D - http://$(minikube ip):31000/system/properties | grep -i ^X-App-Name:
```

### 修改 system 微服务

修改 system 服务中的`APP_NAME`为可配置式（从环境变量中读取）。

### 修改 inventory 微服务

修改 inventory 服务中两个属性`SYSTEM_APP_USERNAME`和`SYSTEM_APP_PASSWORD`改为可配置式。

### 创建 ConfigMap 和 Secret

使用下面的命令创建一个 ConfigMap 来配置应用名称：

```SHELL
kubectl create configmap sys-app-name --from-literal name=my-system
```

这个命令部署一个名为`sys-app-name`的 ConfigMap 到你的集群。它有一个键为`name`值为`my-system`。`--from-literal`选项允许你直接指定键值对，其他可用选项还有如：`--from-file`和`--from-env-file`。

创建一个 secret 的命令如下：

```SHELL
kubectl create secret generic sys-app-credentials -from-literal username=bob --from-literal password=bobpwd
```

这个命令和创建 ConfigMap 的命令很像，一个不同点是这里使用了`generic`一词，表示我们正在创建的密码是常规的，没有指定特殊类型的密码。密码有多种类型，例如存储 Docker credentials 和存储 public/private 密钥对的。

### 更新 Kubernetes 资源

修改项目目录中的`kubernetes.yaml`文件，这个文件定义了 Kubernetes 部署。注意`valueFrom`字段。本例中，`configMapKeyRef`设置键`name`的值为 ConfigMap 的`sys-app-name`值。类似的，`secretKeyRef`从 Secret `sys-app-credentials`设置键`username`和`password`的值。

```YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: system-deployment
  labels:
    app: system
spec:
  selector:
    matchLabels:
      app: system
  template:
    metadata:
      labels:
        app: system
    spec:
      containers:
      - name: system-container
        image: system:1.0-SNAPSHOT
        ports:
        - containerPort: 9080
        # Set the APP_NAME environment variable
        env:
        - name: APP_NAME
          valueFrom:
            configMapKeyRef:
              name: sys-app-name
              key: name
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inventory-deployment
  labels:
    app: inventory
spec:
  selector:
    matchLabels:
      app: inventory
  template:
    metadata:
      labels:
        app: inventory
    spec:
      containers:
      - name: inventory-container
        image: inventory:1.0-SNAPSHOT
        ports:
        - containerPort: 9080
        # Set the SYSTEM_APP_USERNAME and SYSTEM_APP_PASSWORD environment variables
        env:
        - name: SYSTEM_APP_USERNAME
          valueFrom:
            secretKeyRef:
              name: sys-app-credentials
              key: username
        - name: SYSTEM_APP_PASSWORD
          valueFrom:
            secretKeyRef:
              name: sys-app-credentials
              key: password
---
apiVersion: v1
kind: Service
metadata:
  name: system-service
spec:
  type: NodePort
  selector:
    app: system
  ports:
  - protocol: TCP
    port: 9080
    targetPort: 9080
    nodePort: 31000
---
apiVersion: v1
kind: Service
metadata:
  name: inventory-service
spec:
  type: NodePort
  selector:
    app: inventory
  ports:
  - protocol: TCP
    port: 9080
    targetPort: 9080
    nodePort: 32000

```

### 部署你的更改

