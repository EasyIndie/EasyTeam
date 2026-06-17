#!/usr/bin/env bash
# ============================================================
# 内容团队 — OpenClaw 一键配置
# ============================================================
set -euo pipefail

echo "============================================"
echo "  内容团队配置 — OpenClaw 适配"
echo "============================================"

OPENCLAW_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"

# 注册内容团队工作流 skill
SKILL_DIR="$OPENCLAW_HOME/workspace/skills/content-workflow"
mkdir -p "$SKILL_DIR"

cat > "$SKILL_DIR/SKILL.md" << 'SKILL'
---
name: "content-workflow"
description: "6阶段内容生产工作流：选题→写稿→设计→视频→发布→数据"
status: proposal
version: "v1"
---

# 内容生产工作流

## 角色映射（OpenClaw）

内容团队的角色不创建独立 Agent，通过 main 的 sessions_spawn 调度：

| 角色 | 实现方式 |
|------|---------|
| editor-in-chief | main 直接充当，或 spawn 自由 |
| writer | sessions_spawn(main, task="写稿...") |
| designer | sessions_spawn(main, task="设计配图...") |
| video-editor | sessions_spawn(main, task="剪辑视频...") |
| publisher | sessions_spawn(main, task="排版发布...") |
| researcher | 可复用 dev 团队的 research-agent |

## 6 阶段流程

### 🎯 阶段 1：热点选题
- 输入：热点趋势 / 用户需求
- 动作：分析热词 → 出选题列表（含热度、角度、预期效果）
- 输出：选题清单 → 用户确认

### ✍️ 阶段 2：写稿
- 输入：选题方向
- 动作：撰写初稿 → 审核修订 → 定稿
- 输出：最终稿件

### 🎨 阶段 3：配图设计
- 输入：稿件内容
- 动作：设计封面图 + 内文配图 + 社交分享图
- 输出：图片素材

### 🎬 阶段 4：视频制作（可选）
- 输入：稿件 + 脚本
- 动作：视频剪辑 + 配乐 + 字幕
- 输出：成品视频

### 📤 阶段 5：排版发布
- 输入：稿件 + 配图（+ 视频）
- 动作：排版 → 发布到各平台 → 留档
- 输出：发布记录

### 📊 阶段 6：数据分析
- 输入：发布后的数据
- 动作：统计阅读/互动/转化 → 出报告
- 输出：数据报告 + 优化建议

## 进度同步
每阶段完成主动同步给用户。
SKILL

echo "✅ 内容团队配置完成"
echo "   Skill: $SKILL_DIR/SKILL.md"
echo ""
echo "  使用方法：main 收到内容需求后，按 6 阶段 spawn 子任务。"
