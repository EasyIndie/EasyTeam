# 软件开发团队 dev

## 角色

| 角色 | 职责 |
|------|------|
| main | 入口，分流日常/开发需求 |
| conductor | 调度，5 阶段工作流管理 |
| architect-agent | 架构设计 |
| coding-agent | 编码实现 |
| qa-agent | 测试验证 |
| devops-agent | 部署运维 |
| research-agent | 技术调研 |
| ux-agent | UX 设计 |
| growth-agent | 增长文案 |

## 文件

```
workflow.md         ← 5 阶段工作流
roles/              ← 9 个角色定义
prompts/            ← Handoff 模板 + 质量门禁
platforms/
├── openclaw/       ← export.sh + setup.sh + templates/
├── claude-code/    ← CLAUDE.md
└── codex/          ← 初始 prompt
```
