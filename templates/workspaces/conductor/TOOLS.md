# TOOLS.md - 团队总控工具笔记

## 项目路径约定

所有项目放在 `~/Documents/` 目录下：
- `~/Documents/EasySticker`
- `~/Documents/<project-name>`

## 当前项目

项目信息统一管理在 `~/.openclaw/projects.json`，每次会话先读该文件确定当前项目。

```bash
# 读取当前项目 ID
cat ~/.openclaw/projects.json | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['current'])"

# 读取当前项目的完整信息
cat ~/.openclaw/projects.json | python3 -c "import sys,json; d=json.load(sys.stdin); p=d['projects'][d['current']]; print(f'{p[\"name\"]} - {p[\"path\"]} - {p[\"techStack\"]}')"
```

## 团队调度

- **conductor** — 总控，调度各角色 agent
- **architect-agent** — 架构设计、技术选型
- **coding-agent** — 编码实现
- **qa-agent** — 测试验证
- **devops-agent** — 部署运维
- **research-agent** — 技术调研
- **ux-agent** — 用户体验
- **growth-agent** — 产品运营

## 常用命令

```bash
# 查看当前项目
node ~/.openclaw/scripts/switch-project.mjs list

# 切换项目
node ~/.openclaw/scripts/switch-project.mjs <project-id>

# 重启 gateway（切换后自动执行）
openclaw gateway restart
```
