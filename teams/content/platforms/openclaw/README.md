# 内容团队 — OpenClaw 平台适配

## 部署说明

内容团队**不需要**单独的 OpenClaw Agent 账号。角色（editor-in-chief、writer、designer 等）通过 **main Agent 的 sessions_spawn** 调度，每个阶段 spawn 一个子任务。

## 使用方式

main 收到内容需求后，按阶段调度：

```markdown
main 收到"写一篇关于 XXX 的文章"
→ 阶段1: sessions_spawn(自由, task="热点选题分析: ...")
→ 阶段2: sessions_spawn(自由, task="写稿: ...")
→ 阶段3: sessions_spawn(自由, task="配图设计: ...")
→ ...
```

## 脚本

- `scripts/setup.sh` — 部署（创建必要的 skill 和工作模板）
