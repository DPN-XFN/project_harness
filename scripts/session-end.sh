#!/usr/bin/env bash
# session-end.sh — 对话结束时执行
# 用于：同步任务、生成总结提醒
set -e

TODAY=$(date +%Y-%m-%d)
SESSION_FILE="sessions/${TODAY}.md"

echo "📝 会话结束: ${TODAY}"
echo ""

if [ -f "$SESSION_FILE" ]; then
  echo "  今日记录: ${SESSION_FILE}"
else
  echo "  今日记录: (尚未创建 session 文件)"
fi

echo "  活跃任务: sessions/active-tasks.md"

if [ -d "memory" ]; then
  echo "  长期记忆: memory/ (可用 agentmemory 管理)"
fi

echo ""
echo "💡 建议: 确保关键决策已写入 memory/ 和 STYLE.md 决策记录"
