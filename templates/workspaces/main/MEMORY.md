# MEMORY.md — 主工作区长期记忆

## 基本设定
- 用户称呼：老板
- 用户 Feishu open_id：`ou_8eb8c6b63ffdd3c77fcad1525555493f`
- 对话语言：中文
- 时区：Asia/Shanghai (GMT+8)

## 团队架构

### 入口
- **main（阿龙）** — 通用 AI 助手入口，feishu 账号 `default`
  - 非开发问题 → 直接回复
  - 开发任务 → 转给 `conductor`

### 专业角色（8 Agent）
| Agent | 编号 | 职责 |
|-------|------|------|
| conductor | 1 | 项目总监，调度工作流 |
| architect-agent | 2 | 架构师，技术方案 |
| coding-agent | 3 | 开发工程师 |
| research-agent | 4 | 调研分析师 |
| qa-agent | 5 | 测试工程师 |
| devops-agent | 6 | 运维工程师 |
| ux-agent | 7 | UX 设计师 |
| growth-agent | 8 | 运营增长 |

### 协作约定
- 各 Agent 有独立 feishu 账号，对应真实个体感
- 开发任务走 conductor spawn 子 agent -> sessions_yield 等待 -> 结果回传
- 进度推送铁律：每步完成后自动报告

## 模型策略
- 日常任务：`deepseek/deepseek-v4-flash`
- 复杂任务：`deepseek/deepseek-v4-pro`
- 全局统一 deepseek，无 volcengine

## 配置状态
- memorySearch: provider=none（BM25 关键词搜索，不开 embedding）
- HEARTBEAT 巡检：30m 间隔，09:00-23:00，isolatedSession
- 超时设置：默认 120s，coding-agent 300s

## 配置变更规则

修改配置文件前，涉及新增字段时，必须先查 schema 验证字段在当前版本中是否有效，否则可能导致 gateway 无法运行退出。

## 基础设施踩坑
- docker 容器重启后 ensureAdmin 随机密码记录丢失 → 生产必须设 ADMIN_PASSWORD
- 飞书对话中不要写真实密码（系统会 `***` 替换）
- CSP header `script-src 'self'` 禁止 inline onclick → 全部改为 addEventListener
