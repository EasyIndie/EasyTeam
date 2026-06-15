# HEARTBEAT.md — 定时巡检

tasks:

- name: agent-health-check
  interval: 2h
  prompt: >
    检查所有 Agent 是否在线可用（main, conductor, architect-agent, coding-agent,
    qa-agent, devops-agent, research-agent, ux-agent, growth-agent）。
    如果有 Agent 长时间无响应或异常，通知老板。

- name: stuck-workflow-check
  interval: 4h
  prompt: >
    conductor 是否有卡住超过 2 小时的工作流？检查 conductor 的工作区
    （~/.openclaw/workspace-conductor/memory/）是否有未完成的进度文件。
    如果有长时间未推进的任务，提醒老板关注。

# 巡检规则
# - 如果一切正常，只回复 HEARTBEAT_OK
# - 只在上面的 tasks 到期时才触发，不自行推断新任务
# - 保持简洁，不啰嗦
