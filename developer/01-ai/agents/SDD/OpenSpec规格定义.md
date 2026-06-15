本文件来源：`openspec instructions --change snake-game specs`(OpenSpec 1.4.1)

创建定义系统应该做什么的规格文件。

为提案"功能"部分中列出的每个功能创建一个规格文件。
- 新功能：使用提案中的精确 kebab-case 名称（specs/<capability>/spec.md）。
- 修改的功能：在 specs/<capability>/spec.md 创建增量规格时，使用 openspec/specs/<capability>/ 中的现有规格文件夹名称。

增量操作（使用 ## 标题）：
- **ADDED Requirements（新增需求）**：新功能
- **MODIFIED Requirements（修改需求）**：行为变更——必须包含完整的更新内容
- **REMOVED Requirements（移除需求）**：废弃的功能——必须包含 **Reason（原因）** 和 **Migration（迁移方案）**
- **RENAMED Requirements（重命名需求）**：仅名称变更——使用 FROM:/TO: 格式

格式要求：
- 每个需求：`### Requirement: <名称>` 后跟描述
- 规范性需求使用 SHALL/MUST（避免使用 should/may）
- 每个场景：`#### Scenario: <名称>`，使用 WHEN/THEN 格式
- **关键**：场景必须精确使用 4 个井号（`####`）。使用 3 个井号或项目符号会导致静默失败。
- 每个需求必须至少有一个场景。

修改需求的工作流：
1. 在 openspec/specs/<capability>/spec.md 中找到现有需求
2. 复制整个需求块（从 `### Requirement:` 到所有场景）
3. 粘贴到 `## MODIFIED Requirements` 下并编辑以反映新行为
4. 确保标题文本精确匹配（忽略空白差异）

常见陷阱：使用 MODIFIED 但只提供部分内容会在归档时丢失细节。
如果在不改变现有行为的情况下添加新关注点，请改用 ADDED。

示例：
```
## ADDED Requirements

### Requirement: 用户可以导出数据
系统 SHALL 允许用户以 CSV 格式导出其数据。

#### Scenario: 成功导出
- **WHEN** 用户点击"导出"按钮
- **THEN** 系统下载包含所有用户数据的 CSV 文件

## REMOVED Requirements

### Requirement: 旧版导出
**Reason**: 已被新导出系统替代
**Migration**: 使用新的导出接口 /api/v2/export
```

规格应当是可测试的——每个场景都是一个潜在的测试用例。
