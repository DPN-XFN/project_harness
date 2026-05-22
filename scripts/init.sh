#!/usr/bin/env bash
# init.sh — 把 harnexx 骨架拷贝到目标项目
#
# 用法:
#   cd /path/to/your/project && bash /path/to/harnexx/init.sh
#   cd /path/to/your/project && bash /path/to/harnexx/init.sh --with-mem
#
# 选项:
#   --with-mem    同时安装 claude-mem（跨 session 持久记忆）
#   --help        显示帮助

set -e

HERE="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-.}"
INSTALL_MEM=false

# 解析参数
for arg in "$@"; do
  case "$arg" in
    --with-mem) INSTALL_MEM=true ;;
    --help)
      echo "用法: bash init.sh [目标目录] [选项]"
      echo ""
      echo "选项:"
      echo "  --with-mem    同时安装 claude-mem（跨 session 持久记忆）"
      echo "  --help        显示帮助"
      exit 0
      ;;
  esac
done

echo "🚀 Copying harnexx skeleton to: $(cd "$TARGET"; pwd)"
echo ""

# 拷贝核心配置文件
cp "$HERE/STYLE.md" "$TARGET/"

# .claude 目录
mkdir -p "$TARGET/.claude/agents"
cp -r "$HERE/.claude/agents/"* "$TARGET/.claude/agents/"
cp "$HERE/.claude/settings.json" "$TARGET/.claude/"

# docs 目录
mkdir -p "$TARGET/docs/contracts" \
         "$TARGET/docs/architecture" \
         "$TARGET/docs/standards"
cp "$HERE/docs/architecture/"* "$TARGET/docs/architecture/"
cp "$HERE/docs/standards/"* "$TARGET/docs/standards/"
cp "$HERE/docs/incidents.md" "$TARGET/docs/"

# sessions 目录
mkdir -p "$TARGET/sessions"
cp "$HERE/sessions/active-tasks.md" "$TARGET/sessions/"

# memory 目录（用于 agentmemory 或 claude-mem）
mkdir -p "$TARGET/memory"

# scripts 目录
mkdir -p "$TARGET/scripts"
cp "$HERE/scripts/session-start.sh" "$HERE/scripts/session-end.sh" "$TARGET/scripts/"
chmod +x "$TARGET/scripts/session-start.sh" "$TARGET/scripts/session-end.sh"

echo "✅  Done! Files copied to $TARGET"
echo ""

# 可选安装 claude-mem
if [ "$INSTALL_MEM" = true ]; then
  echo "📦 Installing claude-mem..."
  if command -v npx &>/dev/null; then
    npx claude-mem install 2>&1 || echo "⚠️  claude-mem install failed. You can install later with: npx claude-mem install"
  else
    echo "⚠️  npx not found. Install Node.js first, then run: npx claude-mem install"
  fi
fi

echo ""
echo "   Next steps:"
echo "     1. Edit STYLE.md 填写项目信息"
echo "     2. 开始对话，用自然语言描述需求"
echo "     3. AI 自动按 5 阶段工作流推进"
if [ "$INSTALL_MEM" = false ]; then
  echo ""
  echo "   💡 想获得跨 session 记忆能力？"
  echo "      Run: npx claude-mem install"
  echo "      或重新运行: bash init.sh --with-mem"
fi
