#!/usr/bin/env bash
# 对话结束时执行：写今日总结、同步任务
TODAY=$(date +%Y-%m-%d)
echo "📝 会话结束: ${TODAY}"
echo "  今日记录: sessions/${TODAY}.md"
echo "  活跃任务: sessions/active-tasks.md"
