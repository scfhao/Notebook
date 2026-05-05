Docker 安装实验环境 Kubernetes

原文：[15分钟在笔记本上搭建 Kubernetes + Istio开发环境](https://developer.aliyun.com/article/672675)

---

由于Kubernetes大量的容器镜像在 gcr.io， 无法在国内保证稳定的访问。我们提供了一些工具脚本，帮助从阿里云镜像服务下载所需镜像

```Shell
git clone https://github.com/AliyunContainerService/k8s-for-docker-desktop
cd k8s-for-docker-desktop
```

为 Docker daemon 配置 Docker Hub 的中国官方镜像加速 https://registry.docker-cn.com

为 Kubernetes 配置 CPU 和 内存资源，建议分配 4GB 或更多内存。

预先从阿里云Docker镜像服务下载 Kubernetes 所需要的镜像, 可以通过修改 images.properties 文件加载你自己需要的镜像

```Shell
./load_images.sh
```

