# 服务器上的 Git

## 在服务器上搭建 Git

1. 把现有仓库导出为裸仓库

```shell
git clone --bare my_project my_project.git
```

2. 把裸仓库放到服务器上

```shell
scp -r my_project.git user@git.example.com:/srv/git
```

此时，其他可通过 SSH 读取此服务器上`/srv/git`目录的用户，可运行以下命令来克隆你的仓库。

```shell
git clone user@git.example.com:/srv/git/my_project.git
```

如果一个用户，通过使用 SSH 连接到一个服务器，并且其对`/srv/git/my_project.git`目录拥有可写权限，那么他将自动拥有推送权限。

如果到该项目目录中运行`git init`命令，并加上`--shared`选项， 那么 Git 会自动修改该仓库目录的组权限为可写。 注意，运行此命令的工程中不会摧毁任何提交、引用等内容。

```shell
$ ssh user@git.example.com
$ cd /srv/git/my_project.git
$ git init --bare --shared
```

如果只是和几个人在一个私有项目上合作的话，仅仅 是一个 SSH 服务器和裸仓库就足够了。

## 配置服务器

1. 创建一个操作系统用户`git`，并为其建立一个`.ssh`目录。

```shell
sudo adduser git
su git
cd 
mkdir .ssh && chmod 700 .ssh
touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys
```

2. 为系统用户`git`的`authorized_keys`文件添加一些开发者 SSH 公钥。

```shell
cat /tmp/id_rsa.john.pub >> ~/.ssh/authorized_keys
cat /tmp/id_rsa.josie.pub >> ~/.ssh/authorized_keys
cat /tmp/id_rsa.jessica.pub >> ~/.ssh/authorized_keys
```

3. 现在我们来为开发者新建一个空仓库。可以借助带 --bare 选项的 git init 命令来做到这一点，该命令在初始化仓库时不会创建工作目录

```shell
$ cd /srv/git
$ mkdir project.git
$ cd project.git
$ git init --bare
Initialized empty Git repository in /srv/git/project.git/
```

4. 接着，John、Josie 或者 Jessica 中的任意一人可以将他们项目的最初版本推送到这个仓库中， 他只需将此仓库设置为项目的远程仓库并向其推送分支。 请注意，每添加一个新项目，都需要有人登录服务器取得 shell，并创建一个裸仓库。 

```shell
# on John's computer
$ cd myproject
$ git init
$ git add .
$ git commit -m 'initial commit'
$ git remote add origin git@gitserver:/srv/git/project.git
$ git push origin master
```

通过这种方法，你可以快速搭建一个具有读写权限、面向多个开发者的 Git 服务器。

需要注意的是，目前所有（获得授权的）开发者用户都能以系统用户`git`的身份登录服务器从而获得一个普通 shell。 如果你想对此加以限制，则需要修改`/etc/passwd`文件中（git 用户所对应）的 shell 值。

借助一个名为`git-shell`的受限 shell 工具，你可以方便地将用户`git`的活动限制在与 Git 相关的范围内。 该工具随 Git 软件包一同提供。如果将`git-shell`设置为用户`git`的登录 shell（login shell）， 那么该用户便不能获得此服务器的普通 shell 访问权限。 若要使用`git-shell`，需要用它替换掉 bash 或 csh，使其成为该用户的登录 shell。 为进行上述操作，首先你必须确保`git-shell`的完整路径名已存在于`/etc/shells`文件中：

```shell
$ cat /etc/shells   # see if git-shell is already in there. If not...
$ which git-shell   # make sure git-shell is installed on your system.
$ sudo -e /etc/shells  # and add the path to git-shell from last command
```

现在你可以使用`chsh <username> -s <shell>`命令修改任一系统用户的 shell：

```shell
$ sudo chsh git -s $(which git-shell)
```

这样，用户`git`就只能利用 SSH 连接对 Git 仓库进行推送和拉取操作，而不能登录机器并取得普通 shell。 如果试图登录，你会发现尝试被拒绝，像这样：

```shell
$ ssh git@gitserver
fatal: Interactive git shell is not enabled.
hint: ~/git-shell-commands should exist and have read and execute access.
Connection to gitserver closed.
```

此时，用户仍可通过 SSH 端口转发来访问任何可达的 git 服务器。 如果你想要避免它，可编辑`authorized_keys`文件并在所有想要限制的公钥之前添加以下选项：

```shell
no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty
```

其结果如下：

```shell
$ cat ~/.ssh/authorized_keys
no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa
AAAAB3NzaC1yc2EAAAADAQABAAABAQCB007n/ww+ouN4gSLKssMxXnBOvf9LGt4LojG6rs6h
PB09j9R/T17/x4lhJA0F3FR1rP6kYBRsWj2aThGw6HXLm9/5zytK6Ztg3RPKK+4kYjh6541N
YsnEAZuXz0jTTyAUfrtU3Z5E003C4oxOj6H0rfIF1kKI9MAQLMdpGW1GYEIgS9EzSdfd8AcC
IicTDWbqLAcU4UpkaX8KyGlLwsNuuGztobF8m72ALC/nLF6JLtPofwFBlgc+myivO7TCUSBd
LQlgMVOFq1I2uPWQOkOWQAHukEOmfjy2jctxSDBQ220ymjaNsHT4kgtZg2AYYgPqdAv8JggJ
ICUvax2T9va5 gsg-keypair

no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa
AAAAB3NzaC1yc2EAAAADAQABAAABAQDEwENNMomTboYI+LJieaAY16qiXiH3wuvENhBG...
```

现在，网络相关的 Git 命令依然能够正常工作，但是开发者用户已经无法得到一个普通 shell 了。 正如输出信息所提示的，你也可以在`git`用户的主目录下建立一个目录，来对`git-shell`命令进行一定程度的自定义。 比如，你可以限制掉某些本应被服务器接受的 Git 命令，或者对刚才的 SSH 拒绝登录信息进行自定义，这样，当有开发者用户以类似方式尝试登录时，便会看到你的信息。 要了解更多有关自定义 shell 的信息，请运行`git help shell`。
