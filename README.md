# ⚡ harnexx — AI-Assisted Development Harness

一套轻量级的 AI 辅助开发工作方法论。从模糊 idea 到交付，AI 按 5 阶段工作流配合你，7 条红线自动遵守，4 个 Agent 各司其职。

## 快速开始

```bash
# 1. 把 harnexx 拷贝到你的项目
cd /path/to/your/project
bash /path/to/project_harness/scripts/init.sh

# 2. 编辑 STYLE.md 填写项目信息

# 3. 开始对话，AI 自动按 5 阶段推进
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

## 红线

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
│   │   ├── planner.md
│   │   ├── architect.md
│   │   ├── generator.md
│   │   └── evaluator.md
│   └── settings.json
├── docs/
│   ├── contracts/
│   ├── architecture/
│   │   ├── index.md
│   │   └── implicit-contracts.md
│   ├── standards/
│   │   ├── testing.md
│   │   └── database.md
│   └── incidents.md
├── sessions/
│   ├── active-tasks.md
│   └── YYYY-MM-DD.md               # AI 自动创建
└── scripts/
    ├── session-start.sh
    └── session-end.sh
```

## 设计来源

| 灵感来源 | 借鉴内容 |
|---------|---------|
| **oh-my-opencode** (11 Agents) | Intent Gate、Approval Bias、3-strikes、Oracle 三层输出、Draft 外部记忆 |
| **code-review-harness** | 红线、会话机制、Contract 状态机、任务分流、自检清单 |
| **spec-workflow** (3738⭐) | 原子任务（1-3 文件 / 15-30min） |
| **Anthropic 官方 Sub-Agent** | YAML frontmatter 格式、subagent 最佳实践 |

## License

MIT
