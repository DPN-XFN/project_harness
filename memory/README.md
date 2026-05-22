# 跨 Session 持久记忆目录

在 `.claude-hooks/` 或 `memory/` 中存储跨 session 需要记住的信息。

## 用法

由 AI 自动管理（写入/查询），无需手动维护。

### 存储内容

- 用户代码风格偏好（命名规范、格式偏好）
- 架构决策理由（为什么选 A 不选 B）
- 常见错误模式（以 incidents.md 为主）
- 用户工作习惯（TDD/后补测试/不走测试）

### 与 incidents.md 的区别

- `docs/incidents.md`：**问题级别的踩坑记录**（现象→根因→解决→预防）
- `memory/`：**更广泛的知识**（偏好、决策、模式）

## 推荐配合

- **claude-mem** (`npx claude-mem install`) — 自动捕获 session 上下文，语义检索
- **agentmemory** — 简单的本地 key-value 记忆
