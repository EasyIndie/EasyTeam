# 视频团队 — OpenClaw 平台适配

## 部署说明

视频团队**不需要**单独的 OpenClaw Agent 账号。角色（producer、screenwriter、voice-actor 等）通过 **main Agent 的 sessions_spawn** 调度。

## 使用方式

与 content 团队类似，按 6 阶段 spawn。

## 脚本

- `scripts/setup.sh` — 部署
