# 多智能体软件开发团队工作流 — 部署包

9 个 Agent 的多智能体团队工作流，基于 OpenClaw。

## 迁移到新设备

### 前置条件

1. 新设备已安装 [OpenClaw](https://openclaw.ai)
2. 已启动过一次 OpenClaw，生成了基础配置文件
3. 准备好 9 个飞书机器人的 appId + appSecret
4. 准备好 deepseek API Key

### 部署步骤

```bash
# 1. 将 team-deploy 目录复制到新设备任意位置
# 2. 运行部署脚本
export DEEPSEEK_API_KEY="sk-xxxx"
bash setup.sh

# 3. 部署脚本会提示填写飞书凭证和 API Key
# 4. 合并配置后重启网关
openclaw gateway restart
```

### 文件结构

```
team-deploy/
├── setup.sh                     # 一键部署脚本
├── README.md
├── templates/
│   ├── openclaw.json.template   # 全局配置模板（含 {{占位符}}）
│   ├── agents/                  # 9 个 Agent 目录模板
│   │   ├── main/
│   │   ├── conductor/
│   │   ├── architect-agent/
│   │   ├── coding-agent/
│   │   ├── qa-agent/
│   │   ├── devops-agent/
│   │   ├── research-agent/
│   │   ├── ux-agent/
│   │   └── growth-agent/
│   ├── workspaces/              # 9 个 Workspace 模板
│   │   ├── main/
│   │   ├── conductor/
│   │   ├── architect-agent/
│   │   └── ...
│   └── skills/                  # 自定义 Skills
│       ├── conductor/
│       ├── coding-agent/
│       └── ...
```

### 架构

```
main (阿龙) — 入口，分流日常/开发需求
         │
    conductor — 项目总监，调度工作流
      ┌──┬──┬──┬──┬──┬──┐
  architect coding qa devops research ux growth
```

### 维护

- 修改团队配置后，记得重新导出模板：
  ```bash
  # 手动更新 templates/ 目录
  ```
- 建议将此目录作为独立 git 仓库管理
