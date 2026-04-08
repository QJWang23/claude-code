# AI-First 研发效能工具包

第一阶段"夯实基础"所需的所有可复用资产。

## 目录结构

```
ai-first-toolkit/
├── templates/
│   └── CLAUDE.md.template      # 团队项目约定模板
├── config/
│   ├── settings.team.json      # 团队共享 Claude Code 配置
│   └── README.md               # 配置说明
├── commands/
│   ├── design-review.md        # /design-review 设计审查命令
│   ├── tech-spec.md            # /tech-spec 技术方案生成命令
│   └── test-gen.md             # /test-gen 测试用例生成命令
├── scripts/
│   ├── collect-baseline.sh     # 度量基线收集脚本
│   └── analyze-metrics.py      # 度量数据分析脚本
├── guides/
│   └── super-individual-pilot.md  # 超级个体试点指南
├── install.sh                  # 一键安装脚本
└── README.md                   # 本文件
```

## 快速开始

### 一键安装

```bash
cd your-project
/path/to/ai-first-toolkit/install.sh
```

安装脚本会：
1. 复制 CLAUDE.md 模板到项目根目录
2. 复制 settings.json 到 `.claude/` 目录
3. 复制自定义命令到 `.claude/commands/` 目录

### 手动安装

#### 1. 配置 CLAUDE.md

```bash
cp templates/CLAUDE.md.template ./CLAUDE.md
# 编辑 CLAUDE.md，填写项目实际情况
```

#### 2. 配置 settings.json

```bash
mkdir -p .claude
cp config/settings.team.json .claude/settings.json
# 根据需要调整权限配置
```

#### 3. 安装自定义命令

```bash
mkdir -p .claude/commands
cp commands/*.md .claude/commands/
```

## 命令使用

### /design-review - 设计审查

```bash
/design-review docs/specs/feature-x.md
/design-review "实现用户登录功能，支持账号密码和 OAuth"
```

### /tech-spec - 技术方案生成

```bash
/tech-spec "需要实现一个分布式任务调度系统"
/tech-spec docs/requirements/scheduler.md
```

### /test-gen - 测试用例生成

```bash
/test-gen src/service/UserService.java
/test-gen src/service/
/test-gen UserService.getUserById
```

## 度量基线收集

### 收集基线数据

```bash
cd your-project
/path/to/ai-first-toolkit/scripts/collect-baseline.sh . baseline-$(date +%Y%m%d).json
```

### 对比分析

```bash
python /path/to/ai-first-toolkit/scripts/analyze-metrics.py baseline-20260101.json baseline-20260401.json --output report.md
```

## 与现有工具集成

### 复用 Claude Code 官方插件

本工具包与 Claude Code 官方插件兼容，推荐同时使用：

- `feature-dev`: 完整的 7 阶段功能开发工作流
- `code-review`: PR 代码审查
- `pr-review-toolkit`: 多维度 PR 审查

### Cursor 用户

如果团队同时使用 Cursor：

1. 将 `CLAUDE.md` 中的关键约定同步到 `.cursorrules`
2. Cursor 的代码补全会遵循相同的规范

## 下一步

1. 为 2-3 名成员配置完整的 AI 工具环境
2. 选择 1-2 个需求，用 AI 全流程完成
3. 运行度量基线收集，建立对比基线
4. 记录各环节耗时，用于后续效率对比

## 问题反馈

如有问题或建议，请联系团队 AI Champion 或在内部频道反馈。
