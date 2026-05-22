# ⚡ harnexx — AI-Assisted Development Harness

一套轻量级的 AI 辅助开发工作方法论。从模糊 idea 到交付，AI 按 **5 阶段工作流**配合你，**7 条红线**自动遵守，**4 个 Agent** 各司其职，**可选记忆层** 提供跨 session 持久化。

## 快速开始

```bash
# 1. 把 harnexx 骨架拷贝到你的项目
cd /path/to/your/project
bash /path/to/project_harness/scripts/init.sh

# 2. 编辑 STYLE.md 填写项目信息

# 3. 开始对话，AI 自动按 5 阶段推进
```

💡 **想获得跨 session 记忆能力？**
```bash
bash /path/to/project_harness/scripts/init.sh --with-mem
# 或单独安装：npx claude-mem install
```

## 工作流

```
💬 聊 → 📝 定 → 🔪 拆 → 🔨 干 → ✅ 收
```

| 阶段 | 触发 | AI 行为 |
|------|------|---------|
| **1·聊** | "我想做个..." | 讨论模式，反问澄清，不写文档 |
| **2·定** | "建个 Contract" | 生成 Sprint Contract，你确认 |
| **3·拆** | "拆任务" | 切 5-8 个原子 task（1-3 文件，15-30min） |
| **4·干** | "做 task 1" | 逐个实现，做给你看 |
| **5·收** | "收尾" | 补测试 + 更新决策记录 |

## Agent 角色

| Agent | 职责 | 特色 |
|-------|------|------|
| **Planner** | Intent Gate → 采访 → Sprint Contract | Clearance Checklist 自检 |
| **Architect** | 代码库评估 → 架构设计 | Oracle 三层输出 + Effort/Confidence |
| **Generator** | TDD RED→GREEN→IMPROVE | 3-strikes-stop + Verification Check |
| **Evaluator** | 8 维评分 + 三级问题 | Approval Bias（偏向通过） |

每个 Agent 内置 **Claude 模式（专业自驱）** 和 **GPT 模式（严格约束）** 双风格。

## 红线（7 条）

1. **改前说清范围** — 要改什么、为什么改、边界在哪
2. **高风险专项审查** — SQL/配置/密钥/权限走单独审查
3. **边界不对废弃重来** — 第一版 proposal 只是草案
4. **审查分离** — verify / review / 架构审查各司其职
5. **隐性约定必记** — 发现口头约定立即写入 implicit-contracts.md
6. **禁止硬编码密钥** — 密码/token/API 走环境变量
7. **数据库变更红线** — 禁止 DROP/DELETE无WHERE/TRUNCATE

## 初始化后目录结构

```
project/
├── STYLE.md                        # 项目方向 + 红线 + 决策记录
├── .claude/
│   ├── agents/
│   │   ├── planner.md              # 规划 Agent
│   │   ├── architect.md            # 架构 Agent（Platform Task 专用）
│   │   ├── generator.md            # 实现 Agent
│   │   └── evaluator.md            # 审查 Agent
│   └── settings.json               # Claude Code 配置
├── docs/
│   ├── contracts/                  # Sprint Contract（按需创建）
│   ├── architecture/
│   │   ├── index.md                # 架构总览
│   │   └── implicit-contracts.md   # 隐性约定
│   ├── standards/
│   │   ├── testing.md              # 测试规范
│   │   └── database.md             # 数据库规范
│   └── incidents.md                # 踩坑记录（按时间追加）
├── sessions/
│   ├── active-tasks.md             # 跨天活跃任务
│   └── YYYY-MM-DD.md               # 每日会话记录（AI 自动创建）
├── memory/                         # 跨 session 持久记忆
└── scripts/
    ├── init.sh                     # 初始化脚本
    ├── session-start.sh            # 对话开始时 hook
    └── session-end.sh              # 对话结束时 hook
```

## 记忆层（可选，强烈推荐）

harnexx 支持两层记忆，按需选择：

| 方案 | 一句话 | 安装 | 需要 embedding？ |
|------|--------|:---:|:---:|
| **claude-mem** 🏆 | 77k ⭐ 自动捕获 session → 语义检索 | `npx claude-mem install` | ✅ 本地免费模型 |
| **agentmemory** | 简单 key-value 本地记忆 | 已内置在 Hermes | ❌ 不需要 |
| **手动 memory/** | 自己写 Markdown 文件 | 零依赖 | ❌ 不需要 |

**推荐：** `bash init.sh --with-mem` 一步到位装 claude-mem。

## 设计来源

| 灵感来源 | 借鉴内容 |
|---------|---------|
| **oh-my-opencode** (11 Agents) | Intent Gate、Approval Bias、3-strikes、Oracle 三层输出、Draft 外部记忆 |
| **code-review-harness** | 红线、会话机制、Contract 状态机、任务分流、自检清单 |
| **spec-workflow** (3738⭐) | 原子任务（1-3 文件 / 15-30min） |
| **Anthropic 官方 Sub-Agent** | YAML frontmatter 格式、subagent 最佳实践 |
| **claude-mem** (77k ⭐) | 跨 session 记忆持久化、渐进式披露 |

## 变更日志

### v2.0 (2026-05-22)
- 🧠 引入可选记忆层（claude-mem + agentmemory）
- 🔧 修复 hooks 配置为 Claude Code v2.x 兼容格式
- 📝 所有 Agent 增加 memory/ 目录感知
- 🚀 init.sh 支持 `--with-mem` 一键安装
- 🔄 session-start/end.sh 增加记忆检查

## License

MIT
