# 多智能体团队工作流 — 模板库

支持**多种团队类型**，每种类型包含平台无关规范 + 各平台适配层，统一在同一个 git 仓库下管理。

## 目录结构

```
├── shared/               ← 跨团队共享的角色/能力（可选复用）
└── teams/                ← 每个团队类型一个子目录
    ├── dev/              ← 软件开发团队
    │   ├── workflow.md        平台无关工作流
    │   ├── roles/             角色职责定义
    │   ├── prompts/           prompt 模板
    │   └── platforms/         各平台适配
    │       ├── openclaw/      export.sh + setup.sh + templates/
    │       ├── claude-code/   CLAUDE.md
    │       └── codex/         初始 prompt
    ├── content/           ← 内容团队（规划中）
    ├── video/             ← 视频团队（规划中）
    ├── company/           ← 全能公司团队（规划中）
    └── app/               ← 应用团队（规划中）
```

## 团队类型

| 团队 | 说明 | 状态 |
|------|------|------|
| dev | 软件开发团队（9 角色：conductor/coding/qa/devops/等） | ✅ 已就绪 |
| content | 内容团队：热点、选题、写稿、配图、剪视频、发布 | 📋 规划中 |
| video | 视频团队：选题、编剧、分镜、配音、剪辑、发布、数据分析 | 📋 规划中 |
| company | 全能公司：CEO、产品、开发、运营、客服、财务、增长 | 📋 规划中 |
| app | 应用团队：产品、架构、开发、测试、发布 | 📋 规划中 |

## 已有团队 — 开发团队 dev

### 架构

```
main (阿龙) — 入口，分流日常/开发需求
         │
    conductor — 项目总监，调度工作流
      ┌──┬──┬──┬──┬──┬──┐
  architect coding qa devops research ux growth
```

### 部署

```bash
# OpenClaw
cd teams/dev/platforms/openclaw
bash setup.sh
# 补填 API Key + 飞书凭据后
openclaw gateway restart

# 迭代后导出
bash export.sh
git add -A && git commit -m "sync" && git push

# Claude Code
# 复制 teams/dev/platforms/claude-code/CLAUDE.md 到项目根目录

# Codex (ChatGPT)
# 从 teams/dev/platforms/codex/README.md 复制合并 prompt
```

### 质量门禁

- 架构文档：推荐方案 + 备选方案 + 风险评估
- 测试报告：通过数/总数 + 失败详情
- 部署：健康检查
- 每阶段主动同步进度

## 新增团队模板

要添加新团队（如内容团队），在 `teams/` 下创建目录：

```
teams/content/
├── workflow.md             平台无关工作流
├── roles/                  角色定义（可引用 shared/ 下的角色）
├── prompts/                该团队特定的 prompt 模板
└── platforms/              各平台适配
    ├── openclaw/
    ├── claude-code/
    └── codex/
```

然后按需要实现对应平台的 export.sh/setup.sh。
