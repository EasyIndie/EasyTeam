#!/usr/bin/env bash
# ============================================================
# 公司团队 — OpenClaw 一键配置
# ============================================================
set -euo pipefail

echo "============================================"
echo "  公司团队配置 — OpenClaw 适配"
echo "============================================"

OPENCLAW_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"

# 注册公司团队工作流 skill
SKILL_DIR="$OPENCLAW_HOME/workspace/skills/company-workflow"
mkdir -p "$SKILL_DIR"

cat > "$SKILL_DIR/SKILL.md" << 'SKILL'
---
name: "company-workflow"
description: "7阶段公司运营工作流：战略→产品→开发→运营→客服→财务→复盘"
status: proposal
version: "v1"
---

# 公司团队工作流

## 角色映射

| 角色 | 实现方式 |
|------|---------|
| ceo | main 充当 |
| product-manager | sessions_spawn(main/architect, task="产品方案...") |
| developer | 转给 conductor → dev 团队的 coding-agent |
| operator | sessions_spawn(main, task="运营方案...") |
| customer-service | 人工 / 客服系统 |
| finance | sessions_spawn(main, task="财务分析...") |
| growth | 可复用 dev 团队的 growth-agent |

## 7 阶段流程

### 🏛️ 阶段 1：战略决策
- 动作：分析需求 + 确定方向 + 目标 + OKR
- 输出：战略方向文档
- 同步用户确认

### 📋 阶段 2：产品定义
- 动作：需求分析 → PRD → 原型
- spawn architect-agent（有架构决策时）
- 输出：PRD + 原型

### 🛠️ 阶段 3：技术实现
- 转给 conductor → 执行 dev 团队 5 阶段流程
- 如有架构决策 → spawn architect-agent

### 📣 阶段 4：运营推广
- 运营策略 + 市场推广
- 可复用 growth-agent

### 💬 阶段 5：客服反馈
- 收集反馈 + 整理 FAQ
- 汇总给 PM 和 developer

### 💰 阶段 6：财务分析
- 定价 + 成本 + 盈利分析

### 🔄 阶段 7：复盘迭代
- 汇总成果 → 复盘 → 下轮计划

## 进度同步
每阶段完成主动同步用户。
SKILL

echo "✅ 公司团队配置完成"
echo "   Skill: $SKILL_DIR/SKILL.md"
