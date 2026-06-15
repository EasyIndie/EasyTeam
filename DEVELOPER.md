# 开发者指南 — 新增团队或平台适配层

## 新增一个团队

### 步骤

在 `teams/` 下创建 `teams/<team-name>/`，配齐以下结构：

```
teams/<team-name>/
├── workflow.md                ← 必须：平台无关的工作流定义
├── roles/                     ← 必须：角色定义（可引用 shared/roles/）
│   ├── role1.md
│   ├── role2.md
│   └── ...
├── prompts/                   ← 推荐：团队特有的 prompt 模板
│   ├── handoff-templates.md
│   └── quality-gate.md
└── platforms/                 ← 按需：适配一个或多个平台
    ├── openclaw/
    ├── claude-code/
    ├── codex/
    └── hermes/
```

### 验收标准

- [ ] `workflow.md` 定义了完整的工作阶段和角色协作方式
- [ ] `roles/` 覆盖了所有角色及其职责/输入输出/协作边界
- [ ] 至少一个平台的适配层可正常工作
- [ ] 更新 `README.md` 的团队列表

## 新增平台适配层

### 步骤

在已有团队的 `platforms/` 下创建 `teams/<team-name>/platforms/<platform-name>/`：

```
platforms/<platform-name>/
├── README.md            ← 使用说明
├── export.sh            ← 从本地导出配置到模板（OpenClaw 特有）
├── setup.sh             ← 一键部署到新设备（OpenClaw 特有）
└── templates/           ← 配置模板（含占位符）
```

### 每个平台特有的约束

**OpenClaw**
- 需要 `export.sh` + `setup.sh` + `templates/`（agents / workspaces / skills / openclaw.json.template）
- `export.sh` 从本地 `~/.openclaw/openclaw.json` 导出，自动脱敏 API Key 和飞书凭据
- `setup.sh` 合并配置到目标设备，交互式填写凭据

**Claude Code**
- 只需要一个 `CLAUDE.md`，放到项目根目录
- 内容由团队规范翻译而来，保持单文件的完整性
- 工作流以指令形式内嵌，Claude 启动时自动读取

**Codex (ChatGPT)**
- 需要一个 `README.md` 提供合并后的初始 prompt
- 由于 Codex 无原生多 Agent，prompt 通过角色切换模拟多 Agent 行为
- 大任务建议分多次对话

**Hermes**
- 需要提供对应的配置文件格式（JSON / YAML）
- 需调研 Hermes 是否支持多 Agent 绑定

### 验收标准

- [ ] 平台的配置/指令内容与团队规范一致
- [ ] 部署流程在目标设备上可复现
- [ ] 凭据不包含在模板中（通过占位符或交互填写）
- [ ] 更新 `README.md` 的平台列表

## 跨团队共享角色

放 `shared/roles/` 下的角色定义可以被多个团队引用。

使用方式：在团队的 `roles/` 角色中 markdown 引用：

```markdown
# devops-agent — DevOps

## 职责
（同 shared/roles/devops-agent.md）

## 团队特有约定
（当前团队的特殊要求）
```

## export 和 setup 脚本规范

### export.sh

- 从本机配置导出到 templates/
- 脱敏密钥、路径
- 输出统计（文件数、占位符数）
- 提示 git 命令

### setup.sh

- 前置检查目标设备上 OpenClaw 已安装且启动过
- 合并 templates/ 中的配置，但保留已有设备层配置
- 交互式提示补填凭据
- 打印后续操作步骤

## 推荐工作流

```bash
# 日常迭代 - 改规范
vim teams/<team>/roles/conductor.md
git commit -m "docs: 更新 conductor 角色定义"

# 日常迭代 - 改本地配置后导出
bash teams/<team>/platforms/openclaw/export.sh
git commit -m "sync: 更新 OpenClaw 配置模板"

# 新增团队
mkdir -p teams/<team>/{roles,prompts}
# ... 写完规范
# ... 实现 openclaw 适配
git add teams/<team> && git commit -m "feat: 新增 <团队> 团队模板"
```
