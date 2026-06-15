#!/usr/bin/env bash
# ============================================================
# 一键导出当前 OpenClaw 配置到 teams/dev/platforms/openclaw/templates/
# 在本地迭代后运行，保持 dev 团队模板最新。
# ============================================================
set -euo pipefail

OPENCLAW_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/templates"
DEV_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

echo "📦 导出多智能体开发团队配置..."

# ---------- 1. Agent 模板 ----------
echo "  1/5 导出 Agent 目录..."
for agent in main conductor architect-agent coding-agent qa-agent devops-agent research-agent ux-agent growth-agent; do
  src="$OPENCLAW_HOME/agents/$agent/agent"
  dst="$TEMPLATES_DIR/agents/$agent"
  mkdir -p "$dst"
  for f in IDENTITY.md SOUL.md AGENTS.md; do
    [ -f "$src/$f" ] && cp "$src/$f" "$dst/"
  done
  if [ -d "$src/plugins/deepseek" ]; then
    mkdir -p "$dst/plugins/deepseek"
    cp "$src/plugins/deepseek/catalog.json" "$dst/plugins/deepseek/"
  fi
done

# ---------- 2. Workspace 模板 ----------
echo "  2/5 导出 Workspace 目录..."
for agent in main conductor architect-agent coding-agent qa-agent devops-agent research-agent ux-agent growth-agent; do
  if [ "$agent" = "main" ]; then
    src="$OPENCLAW_HOME/workspace"
  else
    src="$OPENCLAW_HOME/workspace-$agent"
  fi
  dst="$TEMPLATES_DIR/workspaces/$agent"
  mkdir -p "$dst"
  for f in SOUL.md MEMORY.md AGENTS.md TOOLS.md USER.md HEARTBEAT.md IDENTITY.md; do
    [ -f "$src/$f" ] && cp "$src/$f" "$dst/"
  done
  mkdir -p "$dst/memory"
  touch "$dst/memory/.gitkeep"
done

# ---------- 3. Skills 模板 ----------
echo "  3/5 导出 Skills..."
SKILLS=(
  "conductor" "architect-agent" "coding-agent" "qa-agent" "devops-agent"
  "research-agent" "ux-agent" "growth-agent" "software-dev-workflow"
  "acpx" "find-skill" "github" "tavily"
  "lark-approval" "lark-attendance" "lark-base" "lark-calendar"
  "lark-contact" "lark-doc" "lark-drive" "lark-event" "lark-im"
  "lark-mail" "lark-markdown" "lark-minutes" "lark-okr"
  "lark-openapi-explorer" "lark-shared" "lark-sheets"
  "lark-skill-maker" "lark-slides" "lark-task" "lark-vc"
  "lark-whiteboard" "lark-wiki"
  "lark-workflow-meeting-summary" "lark-workflow-standup-report"
  "skill-vetter" "self-improving-agent"
)
for skill in "${SKILLS[@]}"; do
  src="$OPENCLAW_HOME/workspace/skills/$skill"
  dst="$TEMPLATES_DIR/skills/$skill"
  if [ -d "$src" ]; then
    mkdir -p "$dst"
    for file in "$src/"*; do
      [ -f "$file" ] && cp "$file" "$dst/"
    done 2>/dev/null || true
  fi
done

# ---------- 4. 全局配置模板 ----------
echo "  4/5 导出全局配置模板..."
python3 -c "
import json, os

OPENCLAW_HOME = os.environ.get('OPENCLAW_HOME', os.path.expanduser('~/.openclaw'))
TEMPLATES_DIR = '$TEMPLATES_DIR'

with open(os.path.join(OPENCLAW_HOME, 'openclaw.json')) as f:
    config = json.load(f)

team_config = {
    'agents': {
        'defaults': config['agents']['defaults'],
        'list': config['agents']['list']
    },
    'models': {'providers': {}}
}

if 'deepseek' in config.get('models', {}).get('providers', {}):
    ds = json.loads(json.dumps(config['models']['providers']['deepseek']))
    for m in ds['models']:
        if 'apiKey' in m:
            m['apiKey'] = '{{DEEPSEEK_API_KEY}}'
        m.pop('credentials', None)
    team_config['models']['providers']['deepseek'] = ds

if 'bindings' in config:
    team_config['bindings'] = config['bindings']

if 'plugins' in config:
    team_config['plugins'] = config['plugins']

feishu = config.get('channels', {}).get('feishu', {})
if feishu:
    team_config['channels'] = {'feishu': {'accounts': {}}}
    for name, acct in feishu.get('accounts', {}).items():
        team_config['channels']['feishu']['accounts'][name] = {
            'appId': acct.get('appId', ''),
            'appSecret': '***}}'
        }
    for key in ('bot', 'capabilities', 'generalConfig'):
        if key in feishu:
            team_config['channels']['feishu'][key] = feishu[key]

json_str = json.dumps(team_config, indent=2)
json_str = json_str.replace(OPENCLAW_HOME, '{{OPENCLAW_HOME}}')

with open(os.path.join(TEMPLATES_DIR, 'openclaw.json.template'), 'w') as f:
    f.write(json_str)

count = json_str.count('{{')
print(f'    占位符数: {count}')
"

# ---------- 5. 同步平台无关规范 ----------
echo "  5/5 同步 dev 团队规范..."
if [ -d "$DEV_DIR/roles" ]; then
  echo "     dev/roles/ ✅ 已同步"
fi

echo ""
echo "✅ 导出完成！"
echo "   模板文件: $(find "$TEMPLATES_DIR" -type f | wc -l) 个"
echo ""
echo "   同步到 git："
echo "     cd $(dirname "$(dirname "$(dirname "$SCRIPT_DIR")")") && git add -A && git commit -m \"sync: 更新 dev 团队配置\" && git push"