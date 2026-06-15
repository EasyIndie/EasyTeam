# 多智能体软件开发团队工作流 — 平台无关规范

## 架构

```
main（阿龙）— 通用入口，分流日常/开发需求
         │
    conductor — 项目总监，调度工作流
      ┌──┬──┬──┬──┬──┬──┐
  architect coding qa devops research ux growth
```

## 9 个角色

| 角色 | 编号 | 职责 |
|------|------|------|
| main | 0 | 通用 AI 助手入口，非开发问题直接处理 |
| conductor | 1 | 项目总监，分析需求、拆任务、调度子 agent |
| architect-agent | 2 | 架构师，技术选型、模块划分、风险评估 |
| research-agent | 4 | 调研分析师，技术调研、信息整理 |
| ux-agent | 7 | UX 设计师，用户流程、交互设计 |
| coding-agent | 3 | 开发工程师，代码实现、Bug 修复 |
| qa-agent | 5 | 测试工程师，功能验证、质量保障 |
| devops-agent | 6 | DevOps，部署运维、CI/CD |
| growth-agent | 8 | 运营增长，文案、增长策略 |

## 5 阶段工作流

1. **分析期** — 需求分析、产出拆解、排期评估
2. **设计期** — 架构设计、技术选型、调研（需要时 spawn research-agent/ux-agent）
3. **实现期** — 编码实现
4. **验证期** — QA 测试、Bug 修复
5. **交付期** — 部署、文案、收尾

## 质量门禁

- 架构文档必须方案+备选+风险
- 测试报告必须通过数/总数+失败详情
- 部署必须健康检查
- 所有 Agent 进度自动同步

## 模型策略

- 日常任务：deepseek-v4-flash
- 复杂任务：deepseek-v4-pro
