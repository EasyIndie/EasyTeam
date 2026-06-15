# 多智能体软件开发团队工作流 — 部署包

9 个 Agent 的多智能体团队工作流。支持 OpenClaw、Claude Code、Codex（ChatGPT）。

## 分层架构

```
team-core/           ← 平台无关规范（团队资产，所有人共享）
  └─ roles/          ← 9 个角色的职责定义
  └─ prompts/        ← 关键 prompt 模板
  └─ workflow.md     ← 5 阶段工作流
  └─ README.md       ← 团队架构说明

team-deploy/         ← 各平台适配层
  ├─ openclaw/       ← OpenClaw：export.sh + setup.sh + templates/
  ├─ claude-code/    ← Claude Code：CLAUDE.md（项目根目录指令）
  └─ codex/          ← Codex：初始对话 prompt 模板
```

## 团队架构

```
main (阿龙) — 入口，分流日常/开发需求
         │
    conductor — 项目总监，调度工作流
      ┌──┬──┬──┬──┬──┬──┐
  architect coding qa devops research ux growth
```

## 各平台部署方式

### OpenClaw

```bash
# 部署到新设备
cd team-deploy
bash openclaw/setup.sh
# 补填 API Key + 飞书凭据后
openclaw gateway restart

# 迭代后导出
bash openclaw/export.sh
git add -A && git commit -m "sync" && git push
```

### Claude Code

1. 将 `team-deploy/claude-code/CLAUDE.md` 复制到项目根目录
2. Claude Code 启动时会自动读取
3. 收到需求后，按 CLAUDE.md 的 5 阶段工作流执行

### Codex (ChatGPT Codex)

1. 打开新对话前，从 `team-deploy/codex/README.md` 复制合并 prompt
2. 粘贴为初始指令
3. 按 5 阶段工作流执行
4. 大任务分多次对话完成

## 文件结构

```
team-deploy/
├── README.md
├── openclaw/
│   ├── setup.sh                 # 一键部署脚本
│   ├── export.sh                # 一键导出脚本
│   └── templates/
│       ├── openclaw.json.template  # 全局配置模板
│       ├── agents/{9}/          # 9 个 Agent 目录模板
│       ├── workspaces/{9}/      # 9 个 Workspace 模板
│       └── skills/{31}/         # 自定义 Skills
├── claude-code/
│   └── CLAUDE.md                # Claude Code 项目指令
└── codex/
    └── README.md                # Codex 适配说明 + 合并 prompt
```

## 维护

- **核心规范迭代**：改 team-core/ 下的文档（平台无关）
- **OpenClaw 适配**：改完本地配置后跑 `openclaw/export.sh`
- **Git 同步**：全部修改后 `git commit && git push`
- **建议**：整个仓库作为独立 git 仓库管理
