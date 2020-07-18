
1. [公网地址](182.61.11.6)

CentOS / 7.5 x86_64 (64bit)
scfhao@baidu1616

ssh-copy-id -i .ssh/id_rsa.pub root@182.61.11.6

useradd scfhao
passwd scfhao

yum install httpd -y
systemctl start httpd
systemctl enable httpd

yum install epel-release
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

yum install php72w-fpm php72w-opcache
