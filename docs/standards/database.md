# 数据库规范

## 禁止操作

- DROP TABLE — 不允许
- DELETE 无 WHERE — 不允许
- TRUNCATE — 不允许
- 删除 .db 文件 — 不允许
- 依赖 cwd 的路径 — 必须用环境变量

## 变更流程

- ALTER TABLE 必须经过审查
- 数据库路径必须用环境变量
- 变更前创建备份
