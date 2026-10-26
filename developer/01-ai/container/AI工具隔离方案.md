# AI工具隔离方案

## 首选：Docker Sandboxes（microVM 级隔离）

专门为 AI 编码代理设计的方案。它底层用的是轻量级 microVM，**每个沙箱有自己独立的内核和 Docker 守护进程，与宿主机彻底隔离**。

为什么适合你：

工作区挂载：你可以选择 Direct 模式（读写挂载，适合盯着改）或 Clone 模式（宿主机只读，代理在内部私有 clone 里改，你需要主动 git fetch 才能拿到提交）。如果你担心 AI 把工作区也弄乱，用 Clone 模式最稳妥。
独立 Docker：代理在沙箱里可以正常使用 Docker，但碰不到你宿主机上的 Docker 守护进程。
支持主流代理：Claude Code、Codex、OpenCode、Gemini CLI 等都可以直接用。

### 安装与使用（以 macOS 为例）：

```bash
brew install docker/tap/sbx
sbx login
# 进入项目目录后运行
sbx run claude   # 或 codex / opencode 等
```

> Linux 需要 Ubuntu 24.04+ 且开启 KVM。Windows 11 也可用，需要开启 Hypervisor Platform。

## 次选：Claude Code 官方沙箱运行时

如果你主力是 Claude Code，它自带的 @anthropic-ai/sandbox-runtime 可以把整个 Claude Code 进程（包括工具、MCP 服务器、hooks）都关进沙箱里，限制文件写入和网络访问。

特点：

* 基于 macOS 的 Seatbelt 或 Linux 的 bubblewrap，比 microVM 轻，但隔离强度弱于 Docker Sandboxes。
* 需要手动配置允许写入的路径（项目目录、~/.claude、/tmp）和允许访问的域名。
* 适合你只想隔离 Claude Code、不想引入完整 microVM 的场景。

> 注意：Claude Code 文档明确说，自带的 Bash 沙箱工具只约束 shell 命令，不覆盖 MCP 服务器、hooks 等独立进程，所以不能单独用来做完全无人值守的运行。如果你要跑`--dangerously-skip-permissions`，必须用容器/VM/沙箱运行时把整个进程包住。

## 备选：Dev Container（适合 VS Code 用户）

如果你习惯在 VS Code 里开发，Dev Container 是门槛较低的选择。项目根目录放一个 .devcontainer 配置，Claude Code 就跑在容器里，项目目录挂载进去。

优点：与编辑器集成好，环境可版本化。
缺点：隔离强度不如 microVM，需要你自己配好网络出口策略和挂载范围。
