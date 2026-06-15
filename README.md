# 多智能体软件开发团队工作流 — 部署包

9 个 Agent 的多智能体团队工作流。支持 OpenClaw、Claude Code、Codex（ChatGPT）。

**整包一键 git 管理**，`team-core`（平台无关规范）和平台适配层在同一仓库下。

## 目录结构

```
├── team-core/           ← 平台无关规范（所有平台共享）
│   ├── README.md        团队架构说明
│   ├── workflow.md      5 阶段工作流定义
│   ├── roles/           9 个角色职责定义
│   └── prompts/         关键 prompt 模板 + 质量门禁
├── openclaw/            ← OpenClaw 适配层
│   ├── export.sh        本地迭代后一键导出模板
│   ├── setup.sh         新设备一键部署
│   └── templates/       模板文件（路径/密钥含占位符）
├── claude-code/         ← Claude Code 适配层
│   └── CLAUDE.md        复制到项目根目录即可
├── codex/               ← Codex (ChatGPT) 适配层
│   └── README.md        合并 prompt + 用法说明
└── README.md            本文件
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

# 迭代后导出（改完本地配置跑这个）
bash openclaw/export.sh
git add -A && git commit -m "sync: 更新团队配置" && git push
```

### Claude Code

1. 将 `claude-code/CLAUDE.md` 复制到项目根目录
2. Claude Code 启动时会自动读取
3. 按 CLAUDE.md 的 5 阶段工作流执行

### Codex (ChatGPT Codex)

1. 打开新对话前，从 `codex/README.md` 复制合并 prompt
2. 粘贴为初始指令
3. 按 5 阶段工作流执行

## 维护

```
迭代 → bash openclaw/export.sh → git add → git commit → git push
                      ↑            ↑
              只改规范: team-core/  只改适配配置: openclaw/templates/
```

- 修改角色定义/工作流 → 改 `team-core/`
- 修改 OpenClaw 本地配置 → 跑 `openclaw/export.sh` 导出
- 所有变更一次性 git 推送
