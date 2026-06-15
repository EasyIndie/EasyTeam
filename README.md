# 多智能体团队工作流 — 模板库

管理**多种团队类型** × **多种 Agent 平台**的配置模板。

## 快速开始

```bash
# 拉取最新模板
git clone <仓库URL> ~/.openclaw/team-deploy

# 部署某个团队到本地 OpenClaw
cd ~/.openclaw/team-deploy/teams/<团队>/platforms/openclaw
bash setup.sh

# 补填 API Key + 飞书凭据
openclaw gateway restart
```

## 目录结构

```
├── ARCHITECTURE.md             ← 整体方案设计文档
├── DEVELOPER.md                ← 团队/平台开发指南
├── README.md                   ← 本文件（使用指南）
├── shared/                     ← 跨团队共享角色/能力
│   ├── roles/                  通用角色定义（devops、qa 等复用角色）
│   └── scripts/                跨团队复用脚本（按需）
└── teams/                      ← 每个团队类型一个子目录
    ├── dev/                    ← 软件开发团队 (✅ 已就绪)
    ├── content/                ← 内容团队 (📋 规划中)
    ├── video/                  ← 视频团队 (📋 规划中)
    ├── company/                ← 全能公司团队 (📋 规划中)
    └── app/                    ← 应用团队 (📋 规划中)
```

## 已有团队

### dev — 软件开发团队

9 Agent 的标准软件开发流程。

**架构：**
```
main (入口)
  └─ conductor (调度)
      ├─ architect (架构)
      ├─ coding (开发)
      ├─ qa (测试)
      ├─ devops (运维)
      ├─ research (调研)
      ├─ ux (设计)
      └─ growth (增长/文案)
```

**可用平台：**
| 平台 | 状态 | 位置 |
|------|------|------|
| OpenClaw | ✅ | teams/dev/platforms/openclaw/ |
| Claude Code | ✅ | teams/dev/platforms/claude-code/ |
| Codex / ChatGPT | ✅ | teams/dev/platforms/codex/ |
| Hermes | 🔄 待实现 | — |

**部署：**
```bash
# OpenClaw 部署
cd teams/dev/platforms/openclaw
bash setup.sh

# Claude Code 使用
cp teams/dev/platforms/claude-code/CLAUDE.md <项目根目录>/

# Codex 使用
# 读 teams/dev/platforms/codex/README.md，复制 prompt 到新对话
```

**迭代：**
```bash
# 改完本地配置后重新导出
bash teams/dev/platforms/openclaw/export.sh
git add -A && git commit -m "sync: 更新 dev 团队配置"
git push
```

## 常见问题

**问：不同设备怎么同步配置？**
- 共享层（角色定义、工作流）→ git push/pull 自动同步
- 设备层（API Key、appSecret）→ 每台设备独立填写，不提交 git

**问：新增一个团队怎么做？**
看 `DEVELOPER.md` 的"新增团队"部分。

**问：某个团队适配新平台怎么做？**
看 `DEVELOPER.md` 的"新增平台适配层"部分。

**问：多个团队共用同一个角色怎么管理？**
放 `shared/roles/`，各团队的平台无关规范中引用即可。
