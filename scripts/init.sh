#!/usr/bin/env bash
# =============================================================================
# harnexx-init.sh — 一键初始化 AI-assisted 开发项目骨架
#
# 用法:
#   cd /path/to/your/project && bash <(curl -sL https://raw.githubusercontent.com/DPN-XFN/project_harness/main/scripts/init.sh)
#   或直接运行: bash harnexx-init.sh
#
# 创建结构:
#   project/
#   ├── STYLE.md                    # 项目方向 + 红线 + 决策记录（一个文件）
#   ├── .claude/
#   │   └── agents/
#   │       ├── planner.md          # 含 Claude/GPT 双风格
#   │       ├── architect.md        # Platform Task 专用
#   │       ├── generator.md        # 含 Claude/GPT 双风格
#   │       └── evaluator.md        # 含 Claude/GPT 双风格
#   ├── docs/
#   │   ├── contracts/
#   │   ├── architecture/
#   │   │   ├── index.md
#   │   │   └── implicit-contracts.md
#   │   ├── standards/
#   │   │   ├── testing.md
#   │   │   └── database.md
#   │   ├── learnings.md
#   │   └── incidents.md
#   ├── sessions/
#   │   ├── active-tasks.md
#   │   └── archive/
#   └── scripts/
#       ├── session-start.sh
#       └── session-end.sh
#
# 工作流: 聊 → 定 → 拆 → 干 → 收
# =============================================================================

set -e

TARGET_DIR="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 如果脚本在 ~/harnexx-init.sh 被直接运行，找 templates 目录
if [ -d "$SCRIPT_DIR/templates" ]; then
    TEMPLATES_DIR="$SCRIPT_DIR/templates"
elif [ -d "$(dirname "$SCRIPT_DIR")/templates" ]; then
    TEMPLATES_DIR="$(dirname "$SCRIPT_DIR")/templates"
elif [ -d "$HOME/.hermes/skills/harnexx-init/templates" ]; then
    TEMPLATES_DIR="$HOME/.hermes/skills/harnexx-init/templates"
else
    echo "❌ 找不到模板目录 templates/"
    echo "   请确保 templates/ 与 init.sh 在同一目录或 ~/.hermes/skills/harnexx-init/templates/ 下"
    exit 1
fi

cd "$TARGET_DIR"

echo "🚀 Initializing harnexx project skeleton in: $(pwd)"
echo ""

# ─── 创建目录结构 ──────────────────────────────────────────────────────────
mkdir -p .claude/agents
mkdir -p docs/contracts
mkdir -p docs/architecture
mkdir -p docs/standards
mkdir -p sessions/archive
mkdir -p scripts

echo "✅  directory structure created"

# ─── 拷贝模板文件 ──────────────────────────────────────────────────────────
cp "$TEMPLATES_DIR/STYLE.md" ./STYLE.md
echo "✅  STYLE.md"

cp "$TEMPLATES_DIR/.claude/agents/planner.md" .claude/agents/
cp "$TEMPLATES_DIR/.claude/agents/architect.md" .claude/agents/
cp "$TEMPLATES_DIR/.claude/agents/generator.md" .claude/agents/
cp "$TEMPLATES_DIR/.claude/agents/evaluator.md" .claude/agents/
echo "✅  .claude/agents/ (4 files)"

cp "$TEMPLATES_DIR/docs/architecture/index.md" docs/architecture/
cp "$TEMPLATES_DIR/docs/architecture/implicit-contracts.md" docs/architecture/
echo "✅  docs/architecture/"

cp "$TEMPLATES_DIR/docs/standards/testing.md" docs/standards/
cp "$TEMPLATES_DIR/docs/standards/database.md" docs/standards/
echo "✅  docs/standards/"

cp "$TEMPLATES_DIR/docs/learnings.md" docs/
cp "$TEMPLATES_DIR/docs/incidents.md" docs/
echo "✅  docs/learnings.md + incidents.md"

cp "$TEMPLATES_DIR/sessions/active-tasks.md" sessions/
echo "✅  sessions/active-tasks.md"

cp "$TEMPLATES_DIR/scripts/session-start.sh" scripts/
cp "$TEMPLATES_DIR/scripts/session-end.sh" scripts/
chmod +x scripts/session-start.sh scripts/session-end.sh
echo "✅  scripts/"

# ─── 完成 ─────────────────────────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "  ✅  harnexx 项目骨架初始化完成！"
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "  目录结构:"
echo "    $(pwd)/"
echo "    ├── STYLE.md — 项目方向 + 红线 + 决策记录"
echo "    ├── .claude/agents/ — 4 个 Agent 角色定义"
echo "    ├── sessions/ — 会话记录与任务管理"
echo "    ├── docs/ — 项目知识体系"
echo "    │   ├── learnings.md — 学习日志（每次收尾追加）"
echo "    │   └── incidents.md — 踩坑记录"
echo "    └── scripts/ — 自动化 hooks"
echo ""
echo "  使用方式:"
echo "    1. 编辑 STYLE.md 填写项目信息"
echo "    2. 开始对话，用自然语言描述需求"
echo "    3. AI 自动按 5 阶段工作流推进"
echo ""
