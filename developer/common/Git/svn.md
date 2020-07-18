GIT-SVN(1)	Git Manual
名称：git-svn - Subversion 仓库与 Git 仓库之间进行双向操作。
概要：git svn <command> [options] [arguments]
描述：git svn是Subversion和Git之间变更集的简单管道。它提供了 Subversion 和 Git 仓库之间的双向变化流。
	 通过`--stdlayout`选项，git svn可以跟踪常见的使用常见的“trunk/branches/tags”布局的标准 Subversion 存储库，也可以使用`-T/-t/-b`选项跟踪任何布局的分支和里程碑（参见下面 init 和 clone 命令的选项）。
	 跟踪了一个 Subversion 仓库后，git 仓库可以通过 fetch 命令从 Subversion 获取更新，通过 dcommit 命令从 Git 更新 Subversion。
命令：
	init 
