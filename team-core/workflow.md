# Workflow — 5 阶段标准工作流

conductor 收到开发需求后，按以下 5 阶段执行：

## 阶段 1：分析期

- 拆解需求，明确交付物
- 输出：任务拆解清单 + 排期评估 → 同步给用户确认

## 阶段 2：设计期

需要架构决策时：
1. spawn `architect-agent` 出方案
2. 如需调研 → conductor spawn `research-agent`
3. 如需 UX 设计 → conductor spawn `ux-agent`
4. 方案确认后进入实现期

无需架构决策，直接进实现期。

## 阶段 3：实现期

1. spawn `coding-agent` 实现
2. 大任务拆细，同步进度
3. 完成后通知 conductor

## 阶段 4：验证期

1. spawn `qa-agent` 测试
2. Qa 通过 → 进交付期
3. Qa 不通过 → 回 coding-agent 修复

## 阶段 5：交付期

1. spawn `devops-agent` 部署
2. spawn `growth-agent` 出文案（如需要）
3. 汇总交付报告 → 同步给用户

## 进度推送铁律

每完成一个阶段，必须主动同步进度给用户。

## 异常处理

- 工具出错 → 降级方案或人工干预
- 子 agent 超时 → 熔断，重新 spawn 或人工处理
- 需求变更 → 暂停当前流程，重新分析
