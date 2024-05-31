
shutdown -h now
vi /etc/hostname 
systemctl reboot
free -m
cat /etc/redhat-release 
rm -rf /etc/yum.repos.d/*.repo
yum update -y
rm -rf .ssh/authorized_keys
vgs
yum install ntpdate vim telnet -y
crontab -e
crontab -l
vim /etc/hosts
cat /etc/hosts
systemctl status firewalld
systemctl disable firewalld
vim /etc/sysct.d/k8s.conf
sysctl -p /etc/sysctl.d/k8s.conf
cd /
mkdir data
cd data/
ping ty-k8s-01
sysctl -p /etc/sysctl.d/k8s.conf
rpm -ivh kernel-lt-4.4.225-1.el7.elrepo.x86_64.rpm 
grub2-editenv list
grub2-set-default "CentOS Linux (4.4.225-1.el7.elrepo.x86_64) 7 (Core)"
grub2-editenv list
systemctl reboot
uname -r
sysctl -p /etc/sysctl.d/k8s.conf
vim /etc/default/grub
dmesg | grep -i numa
yum install -y conntrack ntpdate ntp ipvsadm ipset jq iptables curl sysstat libseccomp wget yum-utils nfs-utils  yum-utils   device-mapper-persistent-data    lvm2 rpcbnd
dmesg | grep -i numa
iptables -F && iptables -X && iptables -F -t nat && iptables -X -t nat
history
grub2-mkconfig -o /etc/grub2.cfg
systemctl reboot
dmesg | grep -i numa
history
iptables -P FORWARD ACCEPT
modprobe ip_vs_rr
modprobe br_netfilter
chmod 755 /etc/sysconfig/modules/ipvs.modules && bash /etc/sysconfig/modules/ipvs.modules && lsmod | grep -e ip_vs -e nf_conntrack
swapoff -a   && sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
vim /etc/fstab 
vim /etc/security/limits.conf
systemctl stop postfix && systemctl disable postfix
date -R
date
uname
uname -r
uptime
history
vim /etc/profile
lsmod | grep -e ip_vs -e nf_conntrack
yum remove docker                    docker-client                    docker-client-latest                    docker-common                    docker-latest                    docker-latest-logrotate                    docker-logrotate                    docker-engine
yum remove docker                    docker-client                    docker-client-latest                    docker-common                    docker-latest                    docker-latest-logrotate                    docker-logrotate                    docker-engine
yum list|grep docker
yum install docker-ce
#1595569543
systemctl enable docker
#1595569578
systemctl start docker 
#1595570270
cd /data/
#1595570270
ll
#1595570281
systemctl restart docker 
#1595570284
docker info
#1595570297
docker load -i haha.tar 
#1595570328
docker info
#1595570333
docker ps
#1595570338
docker images
#1595580599
vim /etc/hosts
#1595581255
ll
#1595581263
yum install -y kubeadm-1.18.4-1.x86_64.rpm kubelet-1.18.4-1.x86_64.rpm kubectl-1.18.4-1.x86_64.rpm  kubernetes-cni-0.8.6-0.x86_64.rpm cri-tools-1.13.0-0.x86_64.rpm 
#1595836814
history
#1595837507
kubeadm config images list
#1595837747
docker images
#1595837757
docker info
#1595839758
kubectl get nodes
#1595942720
kubectl get pods -n kube-system -o wide
#1595581323
docker images
#1595582341
lsmod | grep ip_vs
#1595582384
vim /etc/sysconfig/modules/ipvs.modules 
#1595638029
systemctl enable kubelet 
#1595639075
kubeadm join 10.185.102.154:6444 --token abcdef.0123456789abcdef     --discovery-token-ca-cert-hash sha256:7392c07e343049750a35412900e8988b066562bc6eea34e9779b9f3ae91c77c1
#1596008367
sysctl -w vm.max_map_count=262144
#1596597152
exit
#1603682258
docker ps --no-trunc
#1604625494
wget http://10.76.215.24/up-keys.sh
#1604625528
wget http://10.76.215.24/authorized_keys
#1604625559
sh up-keys.sh 
#1607482256
echo "sshd:10.210.2.80 #RCS" >>/etc/hosts.allow;
#1607482256
echo "sshd:10.76.215.13,10.76.215.20,10.76.215.24,10.76.213.95,10.76.215.27,10.76.215.26,10.76.214.84,10.76.215.76,10.76.213.33 #DSG-TY" >>/etc/hosts.allow;
#1607482256
echo "sshd:all:deny" >>/etc/hosts.deny;
#1607482256
echo "net.ipv4.tcp_timestamps = 0" >> /etc/sysctl.conf && sysctl -p;
#1607482256
echo -e >> /etc/ssh/sshd_config;
#1607482256
echo "Ciphers aes128-ctr,aes192-ctr,aes256-ctr" >> /etc/ssh/sshd_config;
#1607482257
echo "MACs hmac-sha1,hmac-ripemd160" >> /etc/ssh/sshd_config;
#1607482167
vim /etc/sysctl.conf
#1607482339
passwd
#1614558637
node -v 
#1615967213
uptime
#1615967216
top
#1615967252
ps  -ef|grep  java
#1615967374
uptime
#1615967393
cat /proc/cpuinfo 
#1615967492
jps  -v
#1615967497
jps -v
#1615967504
uptime
#1615967510
top
#1615967553
ps -ef|grep java
#1615967578
pwdx 20680
#1615967584
cd /usr/local/
#1615967586
ll
#1615967591
cd zlt/
#1615967600
pwdx 22633
#1615967608
ll
#1615967611
cd logs/
#1615967613
ll
#1615967622
llcd ..
#1615967625
cd ..
#1615967630
ll
#1615967641
pwd
#1615967644
ll
#1615967663
kill -9 20680
#1615967670
uptime
#1615967679
ps -ef|grep java
#1615967692
pwdx 22633
#1615967707
cd /home/nacos
#1615967711
ll
#1615967725
kill -9 22633
#1615967730
top
#1615967738
uptime
#1615967744
top
#1615967766
uptime
#1615967813
ps -ef|grep java
#1615967822
pwdx 19872
#1615967834
kill -9 19872
#1615967841
ps -ef|grep java
#1615967857
pwdx 2120
#1615967866
kill -9 2120
#1615967872
ps -ef|grep java
#1615967899
kill - 31620
#1615967916
kill -9  31620
#1615967927
ps -ef|grep ja
#1615967935
ps -ef|grep java
#1615967953
kill -9 2866
#1615967962
kill -9 4877
#1615967968
ps -ef|grep java
#1615967982
kill -9 4998
#1615967987
ps -ef|grep java
#1615968005
uptime
#1615968011
top
#1615968039
killjava
#1615968048
kill all java
#1615968120
ps aux | grep -v "USER" | sort -rn -k +4 | head -4 | awk -F ' ' '{print $11,$4}'
#1615968184
ps -ef | grep java | grep -v grep |awk '{print $2}' | xargs -p kill -9
#1615968204
ps -ef|grep java
#1615968214
ps -ef | grep java | grep -v grep |awk '{print $2}' | xargs -p kill -9
#1615968222
ps -ef|grep java
#1615968230
uptime
#1615968236
top
#1615968404
ps -ef | grep java | grep -v grep |awk '{print $2}' | xargs -p kill -9
#1615968415
ps -ef|grep java
#1615968433
top
#1615968505
kubectl get pods --all-namespaces
#1615968531
kubectl top nodes
#1616045804
uptime
#1616045808
top
#1616045843
free -m
#1616045846
uptime
#1616046988
kubectl delete  pod nacos-1
#1616047168
uptime
#1616047754
top
#1616047773
free -m
#1616047789
uptime
#1616047882
top
#1621554725
ls
#1621554728
cd /home
#1621554729
ls
#1621554733
java -v
#1621554744
vi /etc/profile
#1621554754
eixt
#1622183529
npm -v
#1622794183
ps -ef|grep vsftp
#1624325961
df -h
#1624325982
cat /etc/redhat-release 
#1624344076
cd /etc/sysconfig/network-scripts/
#1624344078
ll
#1624344089
cp ifcfg-eth0 ifcfg-eth0.bak
#1624344094
vi ifcfg-eth0
#1624344118
yum remove cloud-init
#1624344135
poweroff
#1631006978
cd /www
#1631006979
ll
#1631007012
rm foxbi-20210907.jar 
#1631007017
jps -v
#1631007030
ps -ef |grep java
#1631007040
kill 9734
#1631007042
ll
#1631007044
jps -v
#1631007049
ll
#1631007091
wget http://10.76.214.233:280/foxbi-20210907.jar
#1631007103
history
#1631007161
ll
#1631007173
cd tomcat8/webapps/
#1631007174
ll
#1631007182
rm chartdesign-platform.zip 
#1631007186
ll
#1631007195
rm -rf chartdesign-platform/
#1631007196
ll
#1631007221
wget http://10.76.214.233:280/chartdesign-platform.zip
#1631007226
ll
#1631007233
unzip chartdesign-platform.zip -d chartdesign-platform
#1631007237
cd ..
#1631007248
cd /www
#1631007248
ll
#1631007351
nohup java  -jar "foxbi-20210907.jar" &
#1631007468
cd tomcat8/bin
#1631007470
jps -v
#1631007475
./startup.sh 
#1631007480
./shutdown.sh 
#1631007482
jps -v
#1631007486
./startup.sh 
#1631007488
jps -v
#1631007492
cd ..
#1631007494
cd work/Catalina/localhost/
#1631007495
ll
#1631007571
cd /www/tomcat8/webapps/
#1631007572
ll
#1631007574
cd chartdesign-platform
#1631007576
ll
#1631007580
cd ..
#1631007581
ll
#1631007589
mv chartdesign-platform chart
#1631007591
ll
#1631007593
cd chart
#1631007594
ll
#1631007610
mv chartdesign-platform /www/tomcat8/webapps/
#1631007611
ll
#1631007614
cd ..
#1631007615
ll
#1631007618
rm chart
#1631007623
rm -rf chart
#1631007625
ll
#1631007631
cd chartdesign-platform
#1631007632
ll
#1631007640
cd ..
#1631007642
ll
#1631008234
jps -v
#1631008240
netstat -ntlp
#1631008258
cd ..
#1631008259
cd conf/
#1631008261
ll
#1631008266
vi server.xml 
#1631002710
df -h
#1631002712
jps -v
#1631002719
netstat -tunlp|grep 80
#1631002734
ps -ef|grep java
#1631002795
ip addr
#1631002815
netstat -tunlp|grep 5500
#1631002821
netstat -tunlp|grep 9888
#1631002825
netstat -tunlp|grep 8080
#1631002970
cd /www
#1631002971
ll
#1631002973
mkdir /www
#1631002974
ll
#1631003036
ps -ef|grep nginx
#1631003048
netstat -tunlp|grep nginx
#1631003099
cd /www
#1631003101
ll
#1631003104
tar -zxvf apache-tomcat-8.0.50.tar.gz 
#1631003106
ll
#1631003109
mv apache-tomcat-8.0.50 tomcat8
#1631003112
rm -rf apache-tomcat-8.0.50.tar.gz 
#1631003113
ll
#1631003116
cd tomcat8/conf/
#1631003118
vim server.xml 
#1631003136
cd ../webapps/
#1631003137
lll
#1631003138
ll
#1631003140
rm -rf *
#1631003141
ll
#1631003160
wget http://10.76.214.233:280/chartdesign-platform.zip
#1631003165
ll
#1631003169
unzip chartdesign-platform.zip 
#1631003181
yum install -y unzip 
#1631003231
ll
#1631003236
unzip chartdesign-platform.zip 
#1631003239
ll
#1631003243
cd ..
#1631003245
cd bin/
#1631003246
./startup.sh 
#1631003254
vim /etc/profile
#1631003266
vim /etc/hosts.allow 
#1631003357
cd /usr/local/
#1631003358
ll
#1631003362
tar -zxvf jdk-8u261-linux-x64.tar.gz 
#1631003383
vim /etc/profile
#1631003435
source /etc/profile
#1631003438
jps -v
#1631003443
cd /www/tomcat8/bin/
#1631003445
./startup.sh 
#1631003448
jps -v
#1631003455
netstat -tunlp|grep 15574
#1631003463
cd ..
#1631003464
cd webapps/
#1631003465
ll
#1631003511
cd chartdesign-platform
#1631003512
ll
#1631003546
cd /www
#1631003546
ll
#1631003570
wget http://10.76.214.233:280/foxbi-20210907.jar
#1631003579
ll
#1631003590
nohup java -jar foxbi-20210907.jar  &
#1631003600
netstat -tunlp|grep 9888
#1631004768
ll
#1631004778
ps -ef|grep foxbi
#1631004791
kill -9 18405
#1631004793
ps -ef|grep foxbi
#1631004800
ll
#1631004803
rm -rf foxbi-20210907.jar 
#1631004810
wget http://10.76.214.233:280/foxbi-20210907.jar
#1631004822
nohup java -jar foxbi-20210907.jar  &
#1631060014
jps -v
#1631060028
cd /www/tomcat8/webapps/
#1631060028
ll
#1631060051
pwd
#1631072912
cd ../
#1631072913
cd logs/
#1631072914
ll
#1631072918
tail -f catalina.out 
#1631072925
vim catalina.out 
#1631072936
cd /www
#1631072936
ll
#1631072942
cd logs/
#1631072944
ll
#1631072956
tail -f logback-error-2021-09-08.log 
#1631072964
vim logback-error-2021-09-08.log 
#1631077929
cd ..
#1631077930
ll
#1631077933
jps -v
#1631077939
pwdx 24997
#1631077945
kill -9 24997
#1631077949
ps -ef|grep foxbi
#1631077951
ll
#1631077956
rm -rf foxbi-20210907.jar 
#1631077957
ll
#1631077969
wget http://10.76.214.233:8080/foxbi-20210907.jar
#1631077989
nohup java -jar foxbi-20210907.jar  &
#1631077993
tail -f nohup.out 
#1631156011
exit
#1631838828
cat /etc/hosts.allow 
#1631838957
cat /etc/hosts.deny
#1631849305
hostname --fqdn
#1632707890
pd
#1632707894
cd /usr/bin/
#1632707900
cp pa*wd pd
#1632707903
pd
#1632707941
netstat -tunlp|grep 9888
#1632707971
pwdx 9868
#1632707973
cd /www
#1632707973
ll
#1632707978
vim nohup.out 
#1632883388
jps -l
#1632883414
jps -v
#1632883418
cd /www/tomcat8/webapps/
#1632883419
ll
#1632883421
cd /www
#1632883422
ll
#1632883431
netstat -tunlp|grep java
#1632883442
ll
#1632883444
cd /www
#1632883444
ll
#1632883478
cd -
#1632883480
ll
#1632883492
wget http://10.76.214.233:888/chartdesign-platform.zip
#1632883498
jps -v
#1632883503
cd /www/tomcat8/webapps/
#1632883503
ll
#1632883507
rm -rf chartdesign-platform*
#1632883512
mv /www/chartdesign-platform.zip ./
#1632883513
ll
#1632883517
unzip chartdesign-platform.zip 
#1632883519
ll
#1632883522
rm -rf chartdesign-platform.zip 
#1632883602
cd chartdesign-platform/
#1632883602
ll
#1632883644
vim ../../conf/server.xml 
#1632896761
jps -v
#1632896763
cd /www
#1632896764
ll
#1632896772
du -sh tomcat8/
#1632896783
tar -zcvf tomcat8.tar.gz tomcat8
#1632896809
ll
#1632896819
scp tomcat8.tar.gz 10.185.103.154:/www/
#1633396614
exit
#1634547614
jps -v
#1634547626
cd /www/tomcat8/webapps/
#1634547627
ll
#1634547649
wget http://10.76.214.233:888/chartdesign-platform.zip
#1634547653
ll
#1634547657
rm -rf chartdesign-platform
#1634547658
ll
#1634547661
unzip chartdesign-platform.zip 
#1634547675
ll
#1634547685
ll ../work/Catalina/localhost/
#1641803153
jps -l
#1641803176
kill -9 9868
#1641803179
jps -v
#1641803184
cd /www/tomcat8/bin/
#1641803186
./shutdown.sh 
#1677028695
passwd 
#1677029582
mkdir -p /www/helmData/ingress;wget http://10.76.213.111/jettech_kube-webhook-certgen_v1.5.1.tar;wget http://10.76.213.111/registry.cn-hangzhou.aliyuncs.com_google_containers_defaultbackend_1.4.tar;wget http://10.76.213.111/registry.cn-hangzhou.aliyuncs.com_google_containers_nginx-ingress-controller_v0.50.0.tar;
#1677029636
docker load < jettech_kube-webhook-certgen_v1.5.1.tar;
#1677029642
docker load < registry.cn-hangzhou.aliyuncs.com_google_containers_defaultbackend_1.4.tar;
#1677029646
docker load < registry.cn-hangzhou.aliyuncs.com_google_containers_nginx-ingress-controller_v0.50.0.tar;
#1677029575
set +o history;
#1683514104
showmount -e  10.185.102.123
#1688112537
history|grep kubectl
#1688112581
history|grep label 
#1688112584
history|grep label
#1688112998
kubectl get pods --all-namespaces
#1688113011
mkdir -p $HOME/.kube
#1688113011
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#1688113012
sudo chown $(id -u):$(id -g) $HOME/.kube/config
#1688113017
kubectl get pods --all-namespaces
#1695601772
netstat -tnlp|grep nginx
#1695601778
history
#1709633561
cd /usr/local/
#1709633562
ll
#1709633566
ps -ef|grep java
#1709692530
exit
#1716424108
vim /etc/hosts.allow 
#1716424125
iptables -L
#1716424130
vim /etc/sysconfig/iptables-config 
#1716424449
kubectl version
#1716424489
kubectl cluster-info
#1716424528
kubectl get nodes
#1716426417
echo $KUBECONFIG
#1716426437
ls /etc/kubernetes/
#1716426450
cat /etc/kubernetes/kubelet.conf 
#1716427092
systemctl status kubelet
#1716427245
cat /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf 
#1716427313
telnet
#1716427322
telnet 10.185.102.154 6444
#1716427638
exit
#1716429396
ls
#1716429422
ls -a
#1716429436
exit
