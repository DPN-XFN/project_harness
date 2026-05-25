# [项目名称]

> **项目定位**：[一句话描述]
> **技术栈**：[语言/框架/数据库/关键依赖]
> **构建与测试**：[构建命令] / [测试命令] / [lint 命令]

---

## 什么是 agent harness

```
LLM（大脑）  →  Agent Harness（身体+神经系统）  →  Agent（有职业的人）
```

**LLM 是大脑** — 只输入输出文字，没有工具、没有记忆、没有时间概念。

**Agent Harness 是身体和神经系统** — 为 LLM 提供元能力：

- 模型客户端（通信、重试、成本控制）
- Context 组装（压缩、保留策略）
- 工具系统（定义、调用、并发、失败处理）
- 执行环境（沙箱、文件系统、网络）
- 状态与记忆（会话状态、长期记忆、checkpoint）
- 调度循环（何时继续、结束、反思）
- 身份与权限
- 可观测性（记录、replay、debug）
- 安全策略（防 prompt injection）

**Agent 是有职业的人** — 大脑 + 身体 + 特定领域的 skill、知识、流程和判断标准。

> 模型决定上限，harness 决定兑现率。
> 两个 IQ 完全相同的人，一个受过专业训练、有合适工具、有团队配合；另一个赤手空拳。最后能交付的工作完全不在一个量级。

---

## 红线（任何情况不可违反）

1. **改之前先说清楚** — 要改什么、为什么改、边界在哪。不允许直接动手写代码
2. **高风险路径专项审查** — SQL、配置文件、密钥、权限相关改动必须单独审查
3. **proposal 边界不对就废弃重来** — 第一版 proposal 通常只是草案，不要硬着头皮执行
4. **审查步骤必须分离** — verify、review、架构审查、SQL 审查各司其职，不能混在一起
5. **隐性约定必须记录** — 发现口头约定或业务隐含规则，立即写入 `docs/architecture/implicit-contracts.md`
6. **禁止硬编码密钥** — 密码、token、API key 必须走环境变量或密钥管理
7. **数据库变更红线** — 禁止 DROP TABLE、DELETE 无 WHERE、TRUNCATE 等破坏性 SQL；禁止删除 .db 文件；ALTER TABLE 必须经过审查；数据库路径必须用环境变量，不允许依赖 cwd

---

## 会话机制

AI 每次对话自动遵循以下规则。

### 规则 1：对话开始时
1. 读取 `sessions/active-tasks.md`（了解当前待办）
2. 读取 `sessions/YYYY-MM-DD.md`（当天文件，如存在）
3. 读取 `docs/learnings.md`（了解历史教训和代码库约定）
4. 当天文件不存在时，基于模板创建，从 active-tasks.md 填写"今日目标"

### 规则 2：关键节点记录任务
满足以下任一条件时，在当天 session 的"会话记录"区块追加一条，同步更新 active-tasks.md：
- 写了/改了代码
- 做出了技术决策
- 产生了新任务或完成任务
- 发现了隐性约定

**重要：会话中产出的任务只记录不自动执行，等用户说"开始"才动手。**

### 规则 3：对话结束时
1. 生成"今日总结"
2. 新产生的任务同步到 active-tasks.md
3. 已完成的任务从 active-tasks.md 移除（标记归档）

### 会话文件模板

```markdown
# YYYY-MM-DD 会话

## 今日目标
<!-- AI 从 active-tasks.md 读取待办，填写这里 -->

## 会话记录
<!-- 关键节点实时追加 -->

### HH:MM - [事件标题]
- 做了什么
- 决策/结论
- 产出文件

## 任务清单
### 新增
- [ ] TASK-NNN: 描述 (P0/P1/P2)

### 进行中
- [ ] TASK-NNN: 描述 (Pn, 来自 YYYY-MM-DD)

### 已完成
- [x] TASK-NNN: 描述

## 今日总结
- 完成了什么
- 未完成/待跟进
- 新产生的任务（已同步到 active-tasks.md）
```

---

## 工作流（5 阶段 + Contract 状态机）

所有中大型任务走以下流程。每个阶段完成后**主动暂停**，等用户说"继续"。

### 任务分流

- **Business Task**：功能开发、bugfix、局部改造、测试补充
- **Platform Task**：架构设计、知识平台、运行时升级、编排规则、会话机制、能力治理

### Contract 状态机

`draft → confirmed → in_progress → review_pending → completed`

### 阶段 1：聊（idea 模糊时）
用户触发："我想做一个..."
→ AI 自动进入讨论模式，反问澄清
→ 不需要建 Contract，纯对话
→ 聊清楚了再建 Contract 进入下一阶段

### 阶段 2：定（Contract）
用户触发："建个 Contract" 或 "我们讨论清楚了"
→ AI 创建 docs/contracts/YYYY-MM-DD-<task-name>.md，状态 draft
→ 用户看一眼，说"可以" → 状态 confirmed

### 阶段 3：拆（原子任务）
用户触发："拆任务"
→ AI 切成 5-8 个原子 task（每个 1-3 文件，15-30min）
→ 状态 in_progress

### 阶段 4：干（逐个实现）
用户触发："做 task 1"
→ AI 实现，做完展示结果
→ 用户确认后继续下一个 task
→ 都做完 → 状态 review_pending

### 阶段 5：收（测试 + 沉淀）
用户触发："收尾"
→ AI 补测试
→ 追加学习日志到 `docs/learnings.md`（做了什么、学到什么、踩了什么坑）
→ 更新 STYLE.md 决策记录
→ 用户看完没问题 → 状态 completed
→ 自动更新 sessions/ 和 incidents.md（如果踩坑了）

---

## 知识组织

```
sessions/              # 会话机制（运营日志）
├── active-tasks.md    # 跨天活跃任务汇总
└── YYYY-MM-DD.md      # 每日会话记录

docs/                  # 项目知识（参考型）
├── contracts/         # Sprint Contract
├── architecture/
│   ├── index.md       # 架构总览
│   └── implicit-contracts.md  # 隐性约定
├── standards/
│   ├── testing.md     # 测试规范
│   └── database.md    # 数据库规范
├── learnings.md       # 学习日志（只追加，头部为 Codebase Patterns）
└── incidents.md       # 踩坑记录（按时间追加）
```

---

## 自检清单（每次变更后快速过一遍）

- [ ] 改之前有没有说清楚范围？
- [ ] 有没有碰到高风险路径？碰了有没有专项审查？
- [ ] 改完有没有验证实现和意图一致？
- [ ] 有没有混入非本次变更范围的改动？
- [ ] 有没有发现新的隐性约定需要记录？
- [ ] 学习日志已更新（学到了什么新东西）？
- [ ] 决策记录已更新到 STYLE.md 的决策记录区？

---

## 决策记录

### [YYYY-MM-DD] - [决策标题]

**背景**：[为什么要做这个决定]
**选择**：[做了什么选择]
**理由**：[为什么是这个方案]
**后果**：[正面/负面影响]