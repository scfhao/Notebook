# OpenSpec

[GitHub](https://github.com/WillemJiang/OpenSpec)

## 工作原理

```
┌────────────────────┐
│ Draft Change       │
│ Proposal           │
└────────┬───────────┘
         │ share intent with your AI
         ▼
┌────────────────────┐
│ Review & Align     │
│ (edit specs/tasks) │◀──── feedback loop ──────┐
└────────┬───────────┘                          │
         │ approved plan                        │
         ▼                                      │
┌────────────────────┐                          │
│ Implement Tasks    │──────────────────────────┘
│ (AI writes code)   │
└────────┬───────────┘
         │ ship the change
         ▼
┌────────────────────┐
│ Archive & Update   │
│ Specs (source)     │
└────────────────────┘

1. Draft a change proposal that captures the spec updates you want.
2. Review the proposal with your AI assistant until everyone agrees.
3. Implement tasks that reference the agreed specs.
4. Archive the change to merge the approved updates back into the source-of-truth specs.
```

## 工具

- `/openspec:proposal`
- `/openspec:apply`
- `/openspec:archive`

这些工具会自动从openspec/AGENTS.md读取工作流程说明。如果它们需要提醒，请让它们遵循OpenSpec工作流程。了解更多关于AGENTS.md约定的信息。

## 安装和初始化

前提：Node.js >= 20.19.0

1. 全局安装命令行工具

```shell
npm install -g @fission-ai/openspec@latest
```

> 再次执行此命令可以更新到最新版本。

安装验证：

```shell
openspec --version
```

2. 在项目中初始化

```shell
cd my-project
openspec init
```

3. 更新项目

当升级openspec后，可以运行`openspec update`来更新项目中的`AGENTS.md`文件，以保证 AI 可以理解最新的命令。

初始化时，openspec会在项目根目录中创建openspec目录和AGENTS.md。使用`openspec/project.md`来定义项目级别的约定、标准、架构模式以及所有变更都应遵循的其他准则。

```
Next steps - Copy these prompts to your AGENTS.md-compatible assistant:
────────────────────────────────────────────────────────────
1. Populate your project context:
   "Please read openspec/project.md and help me fill it out
    with details about my project, tech stack, and conventions"

2. Create your first change proposal:
   "I want to add [YOUR FEATURE HERE]. Please create an
    OpenSpec change proposal for this feature"

3. Learn the OpenSpec workflow:
   "Please explain the OpenSpec workflow from openspec/AGENTS.md
    and how I should work with you on this project"
────────────────────────────────────────────────────────────
```

## OpenSpec工作流程示例

### 1. 起草提案 Draft the Proposal

```chat
/openspec:proposal Add profile search filters
```

### 2. 验证&审核

```shell
$ openspec list                             # Confirm the change folder exists
$ openspec validate add-profile-filters     # Validate spec formatting
$ openspec show add-profile-filters         # Review proposal, tasks, and spec delta
```

### 3. 提炼规格

反复调整规格，直至符合您的需求：

```chat
能否为角色和团队筛选器添加验收标准？

AI: 更新规格相关文件
```

### 4. 实现变更

一旦规格看起来没问题，就开始实施：

```chat
/openspec:apply add-profile-filters
```

### 5. 归档完成的变更

完成变更后，归档规格以合并变更：

```chat
/openspec:archive add-profile-filters
```

或者运行命令：

```shell
$ openspec archive add-profile-filters --yes  # Archive the completed change without prompts
```

## 相关命令

```shell
openspec list               # View active change folders
openspec view               # Interactive dashboard of specs and changes
openspec show <change>      # Display change details (proposal, tasks, spec updates)
openspec validate <change>  # Check spec formatting and structure
openspec archive <change> [--yes|-y]   # Move a completed change into archive/ (non-interactive with --yes)
```

## AI 创建的 OpenSpec 文件

以“add two-factor authentication”为例：

```
openspec/
├── specs/
│   └── auth/
│       └── spec.md           # Current auth spec (if exists)
└── changes/
    └── add-2fa/              # AI creates this entire structure
        ├── proposal.md       # Why and what changes
        ├── tasks.md          # Implementation checklist
        ├── design.md         # Technical decisions (optional)
        └── specs/
            └── auth/
                └── spec.md   # Delta showing additions
```

其中，`openspec/specs/auth/spec.md`文件内容：

```
# Auth Specification

## Purpose
Authentication and session management.

## Requirements
### Requirement: User Authentication
The system SHALL issue a JWT on successful login.

#### Scenario: Valid credentials
- WHEN a user submits valid credentials
- THEN a JWT is returned
```

`openspec/changes/add-2fa/specs/auth/spec.md`文件内容：

```
# Delta for Auth

## ADDED Requirements
### Requirement: Two-Factor Authentication
The system MUST require a second factor during login.

#### Scenario: OTP required
- WHEN a user submits valid credentials
- THEN an OTP challenge is required
```

Delta格式，Delta是展示规格变更的补丁：

* `## ADDED Requirements` - 新能力
* `## MODIFIED Requirements` - 修改行为（包含已完成的修改文本）
* `## REMOVED Requirements` - 废弃的特性

格式要求：

* 使用`### Requirement: <name>`作为头
* 每个需求需要至少一个`#### Scenario:`块
* 在需求文本中使用 SHALL/MUST

`openspec/changes/add-2fa/tasks.md`文件内容：

```
## 1. Database Setup
- [ ] 1.1 Add OTP secret column to users table
- [ ] 1.2 Create OTP verification logs table

## 2. Backend Implementation  
- [ ] 2.1 Add OTP generation endpoint
- [ ] 2.2 Modify login flow to require OTP
- [ ] 2.3 Add OTP verification endpoint

## 3. Frontend Updates
- [ ] 3.1 Create OTP input component
- [ ] 3.2 Update login flow UI
```
