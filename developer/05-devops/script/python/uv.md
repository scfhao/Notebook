uv 由 Astral 团队（Ruff 的作者）开发，使用 Rust 编写，旨在成为一个统一的、极速的工具链，以取代 pip, pip-tools, pipx, poetry, pyenv, virtualenv 等多个传统工具。它的核心优势是快，根据实测，其包安装速度是 pip 的 10-100 倍。

uv 不仅仅是快，它还提供了一套现代化的项目管理工作流，让你无需在不同工具间切换

```bash
# 安装并管理Python版本 (类似 pyenv)
uv python install 3.12

# 在当前目录创建虚拟环境
uv venv

# 初始化一个新项目
uv init my-project

# 向项目添加依赖 (自动更新 pyproject.toml 和 uv.lock)
uv add requests

# 在项目的虚拟环境中运行脚本
uv run python main.py
```