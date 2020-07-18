# Git submodule

## 其他

在存在子模块的项目中使用`git diff`时，可以使用`git diff --submodule`。如果不想每次都输入`--submodule`，可以将其设置为默认：

```bash
$ git config --global diff.submodule log
```

如果你设置了配置选项 status.submodulesummary，Git 也会显示你的子模块的更改摘要：

```base
$ git config status.submodulesummary 1
```

## 添加子模块。

```bash
$ git submodule add https://github.com/Alamofire/Alamofire.git
```

默认情况下，子模块会将子项目放到一个与仓库同名的目录中，本例中是 “DbConnector”。 如果你想要放到其他地方，那么可以在命令结尾添加一个不同的路径。

要注意子模块的URL为其他合作者可以访问的URL，如果需要可以通过`git config submodule.{submoduleName}.url <私有URL>`修改此值。

## 克隆含有子模块的项目

你必须运行两个命令：git submodule init 用来初始化本地配置文件，而 git submodule update 则从该项目中抓取所有数据并检出父项目中列出的合适的提交。

或者`submodule update --init`。

不过还有更简单一点的方式。 如果给 git clone 命令传递 --recursive 选项，它就会自动初始化并更新仓库中的每一个子模块。

## 更新子项目

可以在子项目的目录中使用基础git命令更新，也可以使用如下命令：

```bash
$ git submodule update --remote {submodulename}
```

此命令默认会假定你想要更新并检出子模块仓库的 master 分支。 不过你也可以设置为想要的其他分支。 例如，你想要 DbConnector 子模块跟踪仓库的 “stable” 分支，那么既可以在 .gitmodules 文件中设置（这样其他人也可以跟踪它），也可以只在本地的 .git/config 文件中设置。 让我们在 .gitmodules 文件中设置它：

```bash
$ git config -f .gitmodules submodule.DbConnector.branch stable
```

如果同时对子模块进行开发，下面两个命令可能会有用。

```bash
$ git submodule update --remote --merge
$ git submodule update --remote --rebase
```

## 发布子模块更改

如果我们在主项目中提交并推送但并不推送子模块上的改动，其他尝试检出我们修改的人会遇到麻烦，因为他们无法得到依赖的子模块改动。 那些改动只存在于我们本地的拷贝中。

为了确保这不会发生，你可以让 Git 在推送到主项目前检查所有子模块是否已推送。 git push 命令接受可以设置为 “check” 或 “on-demand” 的 --recurse-submodules 参数。 如果任何提交的子模块改动没有推送那么 “check” 选项会直接使 push 操作失败。

## 子模块技巧

### 遍历

有一个 foreach 子模块命令，它能在每一个子模块中运行任意命令。 如果项目中包含了大量子模块，这会非常有用。

例如，假设我们想要开始开发一项新功能或者修复一些错误，并且需要在几个子模块内工作。 我们可以轻松地保存所有子模块的工作进度。

```bash
$ git submodule foreach 'git stash'
```
