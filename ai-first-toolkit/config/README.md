# AI-First Toolkit 配置说明

## settings.team.json 使用方法

### 方法 1: 复制到项目
```bash
cp ai-first-toolkit/config/settings.team.json your-project/.claude/settings.json
```

### 方法 2: 全局配置（影响所有项目）
```bash
# macOS/Linux
mkdir -p ~/.claude
cp ai-first-toolkit/config/settings.team.json ~/.claude/settings.json

# Windows
mkdir %USERPROFILE%\.claude
copy ai-first-toolkit\config\settings.team.json %USERPROFILE%\.claude\settings.json
```

## 配置说明

### permissions
- `ask`: 执行前需要确认的命令（如删除、强制推送）
- `allow`: 自动允许执行的命令（如读取、构建、测试）

### hooks
- `PostToolUse`: 工具执行后的钩子
- `Stop`: 会话结束前的钩子

## 自定义修改

根据团队实际情况调整：
1. 增加或减少 `ask` 中的命令
2. 调整 `allow` 中的权限
3. 添加自定义 hooks（如自动运行测试、检查代码规范）
