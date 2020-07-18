# Gitlab-CI 使用手册

使用Gitlab提供的CI功能，需要了解以下几点：

* 每个commit都会触发ci流程，但可以指定哪个git分支上的commit触发ci，目前设置为develop分支。
* 基于上一条，建议commit的代码都是可运行的。
* 由于可能存在不想要触发ci的commit，可以在commit的message中包含`[ci skip]`，这里的中括号必须为半角版本，`[ci skip]`的位置没有规定，但建议统一放到开头位置。

## CI 流程

CI工作目录，当用户家目录下存在Developer目录时，CI目录为：`~/Developer/builds/[runner-name]/0/[project-owner-name]/[project-name]`，但之前测试时，我没在本地建Developer目录，然后最新代码被更新到：`project-path/builds/[runner-name]/0/project-owner-name/project-name`
当一个提交push到代码服务器上时，会调用CI服务器的runner运行：

1. runner首先从gitlab服务器更新对应代码（触发ci的分支、触发ci的commit）到CI工作目录。
2. 然后执行我们指定的脚本。