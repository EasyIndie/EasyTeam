# 多智能体团队工作流 — 架构设计

> 跨设备、跨平台的团队工作流模板管理方案

## 设计目标

1. **一次定义，多处复用** — 团队规范（角色/工作流）在平台上无关，各平台适配层翻译
2. **多团队共存** — dev/content/video/company/app 等各团队模板互不干扰
3. **跨设备同步** — 共享层（git 仓库）+ 设备层（本地凭据）分离
4. **跨平台交付** — OpenClaw / Claude Code / Codex / Hermes 各有适配层

## 分层架构

```
┌────────────────────────────────────────────────────┐
│                  共享层 Shared                      │
│  跨团队通用的角色/能力定义（devops/qa等复用角色）      │
├────────────────────────────────────────────────────┤
│                 团队层 Teams                        │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ │
│  │   dev   │ │ content  │ │  video  │ │company/ │ │
│  │ (就绪)  │ │ (规划中) │ │ (规划中) │ │app(规划)│ │
│  └─────────┘ └─────────┘ └─────────┘ └─────────┘ │
│  每个团队包含:                                       │
│  ├─ workflow.md  平台无关工作流                       │
│  ├─ roles/       平台无关角色定义                     │
│  ├─ prompts/     通用 prompt 模板                    │
│  └─ platforms/   各平台适配器                         │
│      ├─ openclaw/ → export.sh + setup.sh + templates│
│      ├─ claude-code/ → CLAUDE.md                    │
│      ├─ codex/ → 初始 prompt                        │
│      └─ hermes/ → 配置（待实现）                      │
├────────────────────────────────────────────────────┤
│                  设备层 Local                        │
│  每台设备独立的 API Key / 飞书凭据 / 路径              │
│  通过 export.sh 的占位符和 setup.sh 的交互填写分离    │
└────────────────────────────────────────────────────┘
```

## 数据流

```
迭代流程（一台设备）：
  修改 team-core → 写 teams/dev/roles/
  修改配置 → bash teams/dev/platforms/openclaw/export.sh
  两者都做完 → git add + git commit + git push

分发流程（到另一台设备）：
  git pull
  bash teams/<type>/platforms/openclaw/setup.sh  （自动合并+提示补凭据）
  手动填 API Key + 飞书 appSecret
  openclaw gateway restart

跨平台复用（同一团队给另一个工具用）：
  读 teams/<type>/workflow.md + teams/<type>/roles/
  在 teams/<type>/platforms/ 下加适配器目录
  实现该平台的 export 和 setup
```

## 配置分级

| 层级 | 内容 | 举例 | 是否提交 git |
|------|------|------|-------------|
| 共享层 | 角色定义、工作流、agent 行为规范 | conductor.md、workflow.md | ✅ |
| 适配层 | 平台配置模板（含占位符） | openclaw.json.template、CLAUDE.md | ✅ |
| 设备层 | 实际 API Key、飞书 appSecret | `{{DEEPSEEK_API_KEY}}` → 真实值 | ❌ |

## 质量门禁

- 团队新增：必须 workflow.md + roles/ 齐全才标"已就绪"
- 平台适配：必须 export + setup 脚本齐全
- 设备部署：凭据独立填写，不提交 git
