#!/usr/bin/env bash
# ============================================================
# 多智能体软件开发团队工作流 — 一键部署脚本
# 迁移到新设备时，在 OpenClaw 已安装并启动后运行。
# ============================================================
set -euo pipefail

echo "============================================"
echo "  多智能体团队工作流 — 部署脚本"
echo "============================================"

# ---------- 配置 -------------
# 新设备的 OpenClaw 主目录
OPENCLAW_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"
# 本脚本所在目录（即团队配置包路径）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# 配置文件模板目录
TEMPLATES_DIR="$SCRIPT_DIR/templates"

# ---------- 前置检查 ----------
if [ ! -f "$OPENCLAW_HOME/openclaw.json" ]; then
  echo "❌ 未找到 $OPENCLAW_HOME/openclaw.json"
  echo "   请先在目标设备上启动一次 OpenClaw，确保基础配置文件已生成。"
  exit 1
fi

if ! command -v openclaw &>/dev/null; then
  echo "⚠️  openclaw 命令不可用，部分操作将跳过。"
fi

echo "📦 OPENCLAW_HOME = $OPENCLAW_HOME"

# ---------- 1. 创建 agent 目录 ----------
echo ""
echo "━━━ 1/5 创建 Agent 目录 ━━━"
AGENTS=("main" "conductor" "architect-agent" "coding-agent" "qa-agent" \
        "devops-agent" "research-agent" "ux-agent" "growth-agent")

for agent in "${AGENTS[@]}"; do
  agent_dir="$OPENCLAW_HOME/agents/$agent/agent"
  src_dir="$TEMPLATES_DIR/agents/$agent"
  mkdir -p "$agent_dir"
  if [ -d "$src_dir" ]; then
    cp "$src_dir/IDENTITY.md" "$agent_dir/" 2>/dev/null || true
    cp "$src_dir/SOUL.md" "$agent_dir/" 2>/dev/null || true
    cp "$src_dir/AGENTS.md" "$agent_dir/" 2>/dev/null || true
    # 插件目录
    if [ -d "$src_dir/plugins" ]; then
      cp -r "$src_dir/plugins" "$agent_dir/" 2>/dev/null || true
    fi
    echo "  ✅ $agent"
  else
    echo "  ⚠️  $agent — 未找到模板文件，跳过"
  fi
done

# ---------- 2. 创建 workspace 目录 ----------
echo ""
echo "━━━ 2/5 创建 Workspace 目录 ━━━"
for agent in "${AGENTS[@]}"; do
  if [ "$agent" = "main" ]; then
    ws_dir="$OPENCLAW_HOME/workspace"
  else
    ws_dir="$OPENCLAW_HOME/workspace-$agent"
  fi
  src_dir="$TEMPLATES_DIR/workspaces/$agent"
  mkdir -p "$ws_dir" "$ws_dir/memory"
  if [ -d "$src_dir" ]; then
    for f in SOUL.md MEMORY.md AGENTS.md TOOLS.md USER.md HEARTBEAT.md IDENTITY.md; do
      [ -f "$src_dir/$f" ] && cp "$src_dir/$f" "$ws_dir/" 2>/dev/null || true
    done
  fi
  echo "  ✅ $agent workspace"
done

# ---------- 3. 部署 Skills ----------
echo ""
echo "━━━ 3/5 部署 Skills ━━━"
if [ -d "$TEMPLATES_DIR/skills" ]; then
  mkdir -p "$OPENCLAW_HOME/workspace/skills"
  cp -r "$TEMPLATES_DIR/skills/"* "$OPENCLAW_HOME/workspace/skills/" 2>/dev/null || true
  echo "  ✅ Skills 已部署"
else
  echo "  ⚠️  未找到 skills 模板"
fi

# ---------- 4. 写入全局配置文件 ----------
echo ""
echo "━━━ 4/5 写入全局配置 ━━━"
if [ -f "$TEMPLATES_DIR/openclaw.json.template" ]; then
  # 替换路径占位符
  sed "s|{{OPENCLAW_HOME}}|$OPENCLAW_HOME|g" \
      "$TEMPLATES_DIR/openclaw.json.template" > /tmp/openclaw-team-config.json

  echo "⚠️  以下内容需要在目标设备手动填写："
  echo "    • deepseek API Key（环境变量 DEEPSEEK_API_KEY 注入，或直接修改配置）"
  echo "    • 飞书机器人 appId / appSecret（9 个账号）"
  echo ""
  echo "   生成的临时配置文件：/tmp/openclaw-team-config.json"
  echo "   合并到 $OPENCLAW_HOME/openclaw.json 前请先填写密钥。"
  echo ""
  echo "   也可以手动合并："
  echo "   1. 编辑 /tmp/openclaw-team-config.json 补全 API Key 和飞书凭据"
  echo "   2. 然后执行：openclaw config apply < /tmp/openclaw-team-config.json"
  echo "   3. 重启：openclaw gateway restart"
else
  echo "  ⚠️  未找到 openclaw.json.template"
fi

# ---------- 5. 重启网关 ----------
echo ""
echo "━━━ 5/5 重启网关（可选）━━━"
if command -v openclaw &>/dev/null; then
  echo "  配置写入后，建议重启网关："
  echo "    openclaw gateway restart"
fi

echo ""
echo "============================================"
echo "  ✅ 多智能体团队工作流部署完成"
echo "============================================"
echo ""
echo "  部署清单："
echo "    • ${#AGENTS[@]} 个 Agent 目录  ✅"
echo "    • ${#AGENTS[@]} 个 Workspace   ✅"
echo "    • Skills 目录                  ✅"
echo "    • 全局配置文件模板              ✅"
echo ""
echo "  剩余手动步骤："
echo "    1. 填写 deepseek API Key"
echo "    2. 配置 9 个飞书机器人凭证"
echo "    3. 运行 openclaw gateway restart"
echo "    4. 测试：发送消息检查分流是否正常"
echo ""
echo "============================================"
