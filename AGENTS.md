# ⚡ harnexx

> AI-Assisted Development Harness
>
> 一套轻量级的 AI 辅助开发工作方法论。
> 从模糊 idea 到交付，AI 按 5 阶段工作流配合你，7 条红线自动遵守，4 个 Agent 各司其职。

## 快速使用

```bash
# 1. 把 harnexx 结构拷贝到你的项目
cp -r .claude docs sessions scripts /path/to/your/project/
cp STYLE.md /path/to/your/project/

# 2. 编辑 STYLE.md 填写项目信息

# 3. 开始对话
```

## 工作流

```
💬 聊 → 📝 定 → 🔪 拆 → 🔨 干 → ✅ 收
```

| 阶段 | 触发 | AI 行为 | Contract 状态 |
|------|------|---------|-------------|
| **1·聊** | "我想做个..." | 讨论模式，反问澄清，不写文档 | — |
| **2·定** | "建个 Contract" | 生成 Sprint Contract，你看一眼确认 | draft → confirmed |
| **3·拆** | "拆任务" | 切 5-8 个原子 task（1-3 文件，15-30min） | in_progress |
| **4·干** | "做 task 1" | 逐个实现，做给你看，确认继续 | review_pending |
| **5·收** | "收尾" | 补测试 + 更新 STYLE.md 决策 + incidents.md | completed |

## 目录结构

```
project/
├── STYLE.md                   # 项目方向 + 红线 + 会话机制 + 决策记录
├── .claude/
│   ├── agents/
│   │   ├── planner.md         # 含 Claude/GPT 双风格
│   │   ├── architect.md       # Platform Task 专用
│   │   ├── generator.md       # 含 Claude/GPT 双风格
│   │   └── evaluator.md       # 含 Claude/GPT 双风格
│   └── settings.json
├── docs/
│   ├── contracts/             # Sprint Contract（按需创建）
│   ├── architecture/
│   │   ├── index.md           # 架构总览
│   │   └── implicit-contracts.md  # 隐性约定
│   ├── standards/
│   │   ├── testing.md         # 测试规范
│   │   └── database.md        # 数据库规范
│   └── incidents.md           # 踩坑记录（按时间追加）
├── sessions/
│   ├── active-tasks.md        # 活跃任务
│   └── YYYY-MM-DD.md          # 每日记录（AI 自动创建）
└── scripts/
    ├── init.sh                # 初始化脚本（拷贝用）
    ├── session-start.sh       # 对话开始
    └── session-end.sh         # 对话结束
```

## Agent 角色

| Agent | 职责 | 来源 |
|-------|------|------|
| **Planner** | Intent Gate → 采访模式 → Clearance Checklist → Sprint Contract | oh-my-opencode Sisyphus |
| **Architect** | 代码库评估 → Oracle 三层输出（Essential/Expanded/Edge）+ Effort+Confidence | oh-my-opencode Oracle/Prometheus |
| **Generator** | TDD RED→GREEN→IMPROVE + 3-strikes-stop + Verification Check | code-review-harness + oh-my-opencode |
| **Evaluator** | 8 维 1-5 评分 + 三级问题（CRITICAL/WARNING/SUGGESTION）+ Approval Bias | oh-my-opencode Momus |

每个 Agent 内置 **Claude 模式（专业自驱）** 和 **GPT 模式（严格约束）** 双风格。

## 红线

1. 改前说清范围
2. 高风险路径专项审查
3. 边界不对废弃重来
4. 审查分离
5. 隐性约定必记
6. 禁止硬编码密钥
7. 数据库变更红线

## License

MIT
