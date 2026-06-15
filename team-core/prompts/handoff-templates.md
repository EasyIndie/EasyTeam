# Handoff Prompt — 从 main 转给 conductor

当收到开发需求时，按以下格式转给 conductor：

---

**开发需求**

来源：用户原始描述

需求：
{用户说啥}

上下文：
{项目/代码库/相关文件}

交付标准：
{明确的验收条件}

---

# Handoff Prompt — 从 conductor spawn coding-agent

---

**任务：{实现什么}**

参考文档：
- 架构设计：{路径或摘要}
- UX 设计：{路径或摘要}
- 需求：{需求描述}

约束：
- 语言/框架：{语言}
- 代码规范：{规范}
- 测试要求：{单元/集成/E2E}

预期输出：
- 改动文件清单
- 关键实现说明
- 测试用例

---

# Handoff Prompt — 从 conductor spawn qa-agent

---

**测试任务：{测试什么}**

改动范围：
{改动文件清单}

参考文档：
- 需求：{需求描述}
- 架构：{架构文档路径}
- 代码：{代码路径}

测试要求：
- 单元测试覆盖核心逻辑
- 集成测试验证关键流程
- 边界测试覆盖异常场景

---

# Handoff Prompt — 从 conductor spawn devops-agent

---

**部署任务：{部署什么}**

版本：{版本号}
目标环境：{production/staging}
CI/CD 状态：{流水线状态}

回滚要求：{回滚方案说明}

---
