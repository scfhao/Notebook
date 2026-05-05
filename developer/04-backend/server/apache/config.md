# httpd.conf

## ServerRoot

保存服务器的配置、错误和日志文件的路径树的根目录。**不要在这个路径后面加斜杠**。

我修改ServerRoot后，访问localhost后提示："403 Forbidden You don't have permission to access / on this server."

出现此问题的原因是我把ServerRoot设置为了~/Documents下了，这个路径除了属主（就是当前用户）拥有读写权限外，其他人没有读写权限，是的，连读的权限都没有，但如果是在~下面新建一个文件夹，默认其他用户有只读的权限。

所以，解决方案是修改~/Documents的权限，或者另外设置一个路径。

------------

## 虚拟用户目录

保证如下配置未被注释：

文件/private/etc/apache2/http.conf:
---
LoadModule userdir_module libexec/apache2/mod_userdir.so
Include /private/etc/apache2/extra/httpd-userdir.conf

文件/private/etc/apache2/extra/httpd-userdir.conf

Include /private/etc/apache2/users/*.conf

创建/private/etc/apache2/users/username.conf，内容如下：
<Directory "/Users/kevin/Sites/">
Options Indexes MultiViews
AllowOverride None
Require all granted
</Directory>

重启apache：
sudo apachectl restart


## 配置虚拟主机

确保/etc/apache2/httpd.conf
Include /private/etc/apache2/extra/httpd-vhosts.conf

修改/etc/apache2/extra/httpd-vhosts.conf,如：
<VirtualHost *:80>
DocumentRoot "/Library/WebServer/Documents"
ServerName localhost
ErrorLog "/private/var/log/apache2/localhost-error_log"
CustomLog "/private/var/log/apache2/localhost-access_log" common
</VirtualHost>

<VirtualHost *:80>
DocumentRoot "/Users/snandy/work"
ServerName mysites
ErrorLog "/private/var/log/apache2/sites-error_log"
CustomLog "/private/var/log/apache2/sites-access_log" common
<Directory />
Options Indexes FollowSymLinks MultiViews
AllowOverride None
Order deny,allow
Allow from all
</Directory>
</VirtualHost>

配置/private/etc/hosts文件，127.0.0.1 mysites，访问http://mysites，在10.8之前的Mac OS X版本其内容和"http://localhost/~[用户名]"完全一致。

===================

搞了一天，到目前为止，我认为是用户权限的问题，比如～下的文件属主是scfhao，而Apache所属用户为_www, _www用户没有执行权限导致。

sudo chown -R :_www /Library/WebServer        # 递归给目录设置属主为`_www`
sudo chmod -R g+rw /Library/WebServer          # 递归给目录读和写权限
sudo apachectl restart                        # 重启apache


































