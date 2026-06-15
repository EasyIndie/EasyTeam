# AGENTS.md - 软件开发团队

## 团队成员

| 角色 | Agent ID | 职责 |
|------|----------|------|
| 主管 | conductor | 统筹调度，整合交付 |
| 架构师 | architect-agent | 系统架构设计，技术选型 |
| 开发工程师 | coding-agent | 功能编码实现 |
| 测试工程师 | qa-agent | 测试用例设计，Bug 验证 |
| 运维部署 | devops-agent | CI/CD 配置，部署脚本，环境配置 |
| 信息调研 | research-agent | 技术调研，竞品分析，资料收集 |
| 增长运营 | growth-agent | 产品文案，数据分析，增长策略 |
| 交互设计 | ux-agent | 用户体验设计，交互流程优化 |

## 协作规则

1. 主管拆解任务后，使用 `sessions_spawn` 或 `subagents` 调度子 agent
2. 每个任务明确目标、边界、交付物
3. 关键节点必须经过审核再进入下一环节
4. 所有结果最终由主管整合输出给用户

## 模型策略

所有 agent 统一使用 deepseek 模型，根据任务复杂度自动切换：
- **日常任务**（普通开发、信息查询、常规对话）→ `deepseek/deepseek-v4-flash`（快速响应）
- **复杂任务**（架构设计、深度重构、复杂调试、代码审查）→ `deepseek/deepseek-v4-pro`（更强推理）
