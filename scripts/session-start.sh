#!/usr/bin/env bash
# 对话开始时执行：检查 active-tasks
echo "📋 当前活跃任务:"
cat sessions/active-tasks.md 2>/dev/null || echo "  (无活跃任务)"
