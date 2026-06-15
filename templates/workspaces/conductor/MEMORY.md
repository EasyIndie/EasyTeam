# MEMORY.md - Long Term Memory

## 基本设定
- 助理名称：主管
- 用户称呼：老板
- 对话语言：中文，已固化
- 时区：Asia/Shanghai (GMT+8)

## 项目：EasySticker
- 技术栈：TypeScript + Fastify + 纯前端 public/
- 开发端口：3002 | 生产端口：3000（Docker）
- 代码托管：自建 Gogs + GitHub 镜像

### 已交付功能
- 多平台表情生成（微信/Telegram/WhatsApp/iMessage/Line/TelegramSticker）
- AI 生成模式 + 导入模式
- UX：粘性底栏、步骤导航、暗色模式、拖拽上传、预览放大、快捷键
- 历史记录（localStorage，前 10 条，可折叠可清空）
- 用户认证系统（JWT，localStorage 统一 token 管理）
- 管理后台（用户管理、统计、设置）
- 密码重置（SMTP 邮件 / console 模式）
- Playwright E2E 测试（33 项，覆盖率中）
- 邮箱验证流程（注册后自动发验证邮件）
- 对外服务差距：认证默认关闭（API_TOKEN 空时 authEnabled=false）、需 HTTPS、加固项待上线

### 安全与运营
- 管理员账号：admin@easysticker.app / admin888（仅开发环境）
- 生产环境必须设 ADMIN_PASSWORD + API_TOKEN 环境变量
- 部署配置：docker-compose.yml + .env.example + 部署指南

### 重要踩坑
- docker 容器重启后 ensureAdmin 随机密码记录丢失 → 必须 env 显式指定
- 飞书对话中不要写真实密码（系统会 `***` 替换）
- CSP header `script-src 'self'` 禁止 inline onclick → 已全部改为 addEventListener
- coding-agent (deepseek-v4-pro) 300s 超时对大块 JS 改动无效 → 大任务拆细或 conductor 直接改
