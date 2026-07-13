# [git-worktree](https://manpages.ubuntu.com/manpages/bionic/man1/git-worktree.1.html)

管理多个工作树。

## 语法摘要

```bash
git worktree add [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
git worktree list [--porcelain]
git worktree lock [--reason <string>] <worktree>
git worktree move <worktree> <new-path>
git worktree prune [-n] [-v] [--expire <expire>]
git worktree remove [--force] <worktree>
git worktree unlock <worktree>
```

## 描述

管理关联到同一代码仓库的多个工作树。

一个 Git 仓库可以支持多个工作树，让你一次签出多个分支。使用 `git worktree add` 命令时，会为仓库创建一个新的工作树。这个新的工作树被称为“链接工作树”，与由 `git init` 或 `git clone` 初始化的“主工作树”相对应。一个仓库（若非裸仓库）拥有一个主工作树，以及零个或多个链接工作树。

当你不再需要某个关联的工作树时，只需将其删除即可。该工作树在仓库中的管理文件（详见下方的“DETAILS”）最终会被自动移除（可参考git-config(1)中的gc.worktreePruneExpire配置），你也可以在主工作树或任意关联的工作树中运行`git worktree prune`命令，以清理所有失效的管理文件。

如果一个关联的工作树存储在并非始终挂载的便携式设备或网络共享上，你可以通过运行 `git worktree lock` 命令来阻止其管理文件被清理，还可选择性地使用 `--reason` 选项说明锁定该工作树的原因。

## 命令

### add

```bash
add <路径> [<提交引用>]
```

创建 <path> 并将<commit-ish> 检出到其中。新的工作目录与当前仓库关联，除工作目录特定文件（如 HEAD、索引等）外共享所有内容。- 也可指定为<commit-ish>；它与 @{-1} 同义。

如果 `<commit-ish>` 是一个分支名（称其为 `<branch>`）且未找到，同时未使用 `-b`、`-B` 或 `--detach` 选项，但在恰好一个远程仓库（称其为 `<remote>`）中存在同名的跟踪分支，则将其视为等同于以下命令：

```bash
$ git worktree add --track -b <分支> <路径> <远程仓库>/<分支>
```

如果省略了 `<commit-ish>`，且未使用 `-b`、`-B` 或 `--detach` 选项，为方便起见，系统会自动创建一个基于 HEAD 的新分支，效果等同于指定 `-b $(basename <path>)`。

### list

列出每个工作树的详细信息。主工作树优先列出，随后是每个关联的工作树。输出详情包括工作树是否为裸仓库、当前检出的修订版本，以及当前检出的分支（若无则为分离 HEAD）。

### lock

如果工作树位于并非始终挂载的便携式设备或网络共享上，请锁定它以防止其管理文件被自动清理。这也能阻止工作树被移动或删除。可选操作：使用`--reason`参数指定锁定原因。

### move

将工作树移动到新位置。请注意，包含子模块的主工作树或链接工作树无法移动。

### prune

清理`$GIT_DIR/worktrees`中的工作树信息。

### remove

删除工作树。仅可删除干净的工作树（无未跟踪文件，且跟踪文件无修改）。带有子模块的不干净工作树或需使用`--force`才能删除。主工作树无法删除。

### unlock

解锁一个工作树，允许对其进行修剪、移动或删除。

## 选项

### `-f, --force`

默认情况下，当 <commit-ish> 是分支名称且已被另一个工作树检出时，add 命令会拒绝创建新的工作树；而 remove 命令会拒绝移除未清理的工作树。此选项会覆盖该保护机制。

### `-b <new-branch>, -B <new-branch>`

使用 add 命令，创建一个名为<new-branch>的新分支，其起始点为<commit-ish>，并将<new-branch>检出到新的工作树中。如果省略<commit-ish>，则默认指向 HEAD。默认情况下，-b 会拒绝创建已存在的新分支。-B 会覆盖此保护机制，将<new-branch>重置为<commit-ish>。

### `--detach`

使用 add 命令时，在新的工作树中分离 HEAD。请参阅 git-checkout(1) 中的“分离 HEAD”。

### `--[no-]checkout`

默认情况下，add 会检出<commit-ish>，不过可以使用 --no-checkout 来抑制检出，以便进行自定义配置，例如配置稀疏检出(sparse-checkout)。请参阅 git-read-tree(1) 中的“稀疏检出”部分。

### `--[no-]guess-remote`

使用 `worktree add <path>` 命令时，若不指定 `<commit-ish>`，则不会从 HEAD 创建新分支；如果恰好有一个远程仓库存在与 `<path>` 基名匹配的跟踪分支，则以该远程跟踪分支为基础创建新分支，并将该远程跟踪分支标记为新分支的“上游”。

也可通过配置 `worktree.guessRemote` 选项将此设置为默认行为。

### `--[no-]track`

创建新分支时，如果 <commit-ish> 是一个分支，则将其标记为新分支的“上游”。如果 <commit-ish> 是远程跟踪分支，这将是默认行为。有关详细信息，请参阅 git-branch(1) 中的“--track”。

### `--lock`

创建后保持工作树处于锁定状态。这相当于在执行 `git worktree add` 后运行 `git worktree lock`，但不存在竞争条件。

### `-n, --dry-run`

使用 prune 时，不删除任何内容；仅报告其会删除的内容。

### `--porcelain`

使用 list，以一种便于脚本解析的格式输出。此格式在不同 Git 版本中以及无论用户配置如何都将保持稳定。详见下文说明。

### `-v, --verbose`

使用 prune 时，报告所有移除的内容。

### `--expire <time>`

使用 prune 时，仅使早于 <time> 的未使用工作树过期。

### `--reason <string>`

使用 lock 时，需说明锁定工作树的原因。

### `<worktree>`

工作树可通过路径识别，路径可为相对路径或绝对路径。

如果工作树路径中的最后一个路径组件在所有工作树中是唯一的，那么它可用于标识工作树。例如，若你仅有两个工作树，路径分别为 "/abc/def/ghi" 和 "/abc/def/ggg"，那么 "ghi" 或 "def/ghi" 就足以指向前者对应的工作树。

## 详细说明

每个 linked working tree（链接工作树）在仓库的 $GIT_DIR/worktrees 目录下都有一个私有子目录。该私有子目录的名称通常是链接工作树路径的基名，可能会追加一个数字以确保其唯一性。例如，当 $GIT_DIR=/path/main/.git 时，执行 git worktree add /path/other/test-next next 命令会在 /path/other/test-next 路径下创建链接工作树，同时还会创建 $GIT_DIR/worktrees/test-next 目录（若 test-next 已被占用，则会创建 $GIT_DIR/workspaces/test-next1 目录）。

在关联的工作树中，$GIT_DIR 会被设置为指向这个私有目录（例如示例中的 /path/main/.git/worktrees/test-next），而 $GIT_COMMON_DIR 会被设置为指向主工作树的 $GIT_DIR（例如 /path/main/.git）。这些设置是在关联工作树顶层目录下的 .git 文件中完成的。

## list 输出格式

## 示例

