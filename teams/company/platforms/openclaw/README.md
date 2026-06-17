# 公司团队 — OpenClaw 平台适配

## 部署说明

公司团队覆盖从战略到运营的全流程，同样通过 **main Agent 调度**。

但注意：**developer 角色建议复用现有 dev 团队的 coding-agent**，不额外创建。

## 使用方式

```markdown
main 收到"我们要做一个新产品"
→ 阶段1: 战略分析（可复用 research-agent）
→ 阶段2: PRD（可 spawn 自由/architect）
→ 阶段3: 开发 → 转给 conductor 调度 dev 团队
→ 阶段4: 运营推广（可 spawn 自由/growth-agent）
→ ...
```

## 脚本

- `scripts/setup.sh` — 部署
