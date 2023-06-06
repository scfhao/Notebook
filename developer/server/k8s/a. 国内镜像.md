# a. 国内镜像

## lank8s.cn

lank8s.cn 是国内安装 K8S 的基本镜像，网址为：https://github.com/lank8s 。 gcr.lank8s.cn 提供的镜像包括：/google_samples、/kubebuilder、/istio-release、/tekton-releases、/distroless、/google-containers 的镜像。

使用 kubeadm 搭建 Kubernetes 集群的时候，可以使用如下命令：

```SHELL
#其中使用image-repository参数指定镜像的仓库为lank8s.cn即可
[root@k8scloude3 ~]# kubeadm init --image-repository=lank8s.cn --kubernetes-version=v1.22.2 --pod-network-cidr=10.244.0.0/16 --service-cidr=10.96.0.0/12 --ignore-preflight-errors=Swap 
```

当我们下载k8s.gcr.io，gcr.io镜像时候，可以使用 lank8s.cn镜像，对应关系为 k8s.gcr.io –> lank8s.cn，gcr.io –> gcr.lank8s.cn，如下所示：

```SHELL
[root@k8scloude2 ~]# docker pull gcr.io/google-samples/microservices-demo/emailservice:v0.4.0
#换成
[root@k8scloude2 ~]# docker pull gcr.lank8s.cn/google-samples/microservices-demo/emailservice:v0.4.0

[root@k8scloude2 ~]# docker pull k8s.gcr.io/sig-storage/csi-node-driver-registrar:v2.3.0
#换成
[root@k8scloude2 ~]# docker pull lank8s.cn/sig-storage/csi-node-driver-registrar:v2.3.0
```
