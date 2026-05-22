#!/usr/bin/env bash
# session-start.sh — 对话开始时执行
# 用于：检查活跃任务、加载记忆上下文
set -e

echo "📋 当前活跃任务:"
cat sessions/active-tasks.md 2>/dev/null || echo "  (无活跃任务)"
echo ""

# 如果有 memory 目录，检查是否有历史记忆
if [ -d "memory" ]; then
  MEM_COUNT=$(find memory -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$MEM_COUNT" -gt 0 ]; then
    echo "🧠 历史记忆: $MEM_COUNT 条记录"
  fi
fi

# 如果有 claude-mem 的状态文件，提示可用
if [ -f "$HOME/.claude-mem/settings.json" ]; then
  echo "🔗 claude-mem 已安装 — AI 自动检索跨 session 上下文"
fi
