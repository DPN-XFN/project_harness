#!/usr/bin/env bash
# init.sh — 把 harnexx 骨架拷贝到目标项目
#
# 用法:
#   cd /path/to/your/project && bash /path/to/harnexx/init.sh

set -e

HERE="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-.}"

echo "🚀 Copying harnexx skeleton to: $(cd "$TARGET"; pwd)"
echo ""

cp "$HERE/STYLE.md" "$TARGET/"
mkdir -p "$TARGET/.claude" "$TARGET/.claude/agents"
cp -r "$HERE/.claude/agents/"* "$TARGET/.claude/agents/"
cp "$HERE/.claude/settings.json" "$TARGET/.claude/"
mkdir -p "$TARGET/docs/contracts" "$TARGET/docs/architecture" "$TARGET/docs/standards"
cp "$HERE/docs/architecture/"* "$TARGET/docs/architecture/"
cp "$HERE/docs/standards/"* "$TARGET/docs/standards/"
cp "$HERE/docs/incidents.md" "$TARGET/docs/"
mkdir -p "$TARGET/sessions"
cp "$HERE/sessions/active-tasks.md" "$TARGET/sessions/"
mkdir -p "$TARGET/scripts"
cp "$HERE/scripts/session-start.sh" "$HERE/scripts/session-end.sh" "$TARGET/scripts/"
chmod +x "$TARGET/scripts/session-start.sh" "$TARGET/scripts/session-end.sh"

echo "✅  Done! Files copied to $TARGET"
echo ""
echo "   Next steps:"
echo "     1. Edit STYLE.md 填写项目信息"
echo "     2. 开始对话，用自然语言描述需求"
echo "     3. AI 自动按 5 阶段工作流推进"
