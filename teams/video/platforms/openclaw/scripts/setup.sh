#!/usr/bin/env bash
# ============================================================
# 视频团队 — OpenClaw 一键配置
# ============================================================
set -euo pipefail

echo "============================================"
echo "  视频团队配置 — OpenClaw 适配"
echo "============================================"

OPENCLAW_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"

# 注册视频团队工作流 skill
SKILL_DIR="$OPENCLAW_HOME/workspace/skills/video-workflow"
mkdir -p "$SKILL_DIR"

cat > "$SKILL_DIR/SKILL.md" << 'SKILL'
---
name: "video-workflow"
description: "6阶段视频制作工作流：选题→编剧配音→剪辑→发布→分析"
status: proposal
version: "v1"
---

# 视频制作工作流

## 角色映射

| 角色 | 实现方式 |
|------|---------|
| producer | main 充当 |
| screenwriter | sessions_spawn(main, task="写脚本...") |
| voice-actor | 人工 / TTS 工具（非 AI Agent） |
| editor | sessions_spawn(main, task="剪辑指导...") |
| publisher | sessions_spawn(main, task="发布...") |
| analyst | sessions_spawn(main, task="数据分析...") |

## 6 阶段流程

### 🎯 阶段 1：选题策划
- 输入：趋势 / 方向
- 动作：选题描述 + 目标观众 + 竞品参考 + 预期
- 输出：选题策划文档 → 用户确认

### 📝 阶段 2：编剧分镜
- 输入：选题
- 动作：脚本撰写 + 分镜设计
- 输出：脚本 + 分镜方案

### 🎤 阶段 3：配音
- 输入：脚本
- 动作：录制配音 / TTS 生成
- 输出：配音文件

### ✂️ 阶段 4：剪辑成片
- 输入：素材 + 脚本 + 配音
- 动作：粗剪 → 精剪 → 调色 → 字幕 → 配乐
- 输出：成品视频

### 📤 阶段 5：发布
- 输入：成品视频
- 动作：上传各平台 + 封面 + 标签 + 描述
- 输出：发布记录

### 📊 阶段 6：数据分析
- 输入：播放数据
- 动作：出报告 + 优化建议
- 输出：数据报告

## 进度同步
每阶段完成主动同步用户。
SKILL

echo "✅ 视频团队配置完成"
echo "   Skill: $SKILL_DIR/SKILL.md"
