# AI-First 研发效能体系 - 第一阶段实施计划

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 构建第一阶段"夯实基础"所需的所有可落地资产：团队 CLAUDE.md 模板、共享配置、自定义命令、度量基线工具。

**Architecture:** 基于 Claude Code 插件体系，创建可复用的团队级 AI 配置资产，包含项目约定文件、自定义命令、工作流 Hooks，以及度量数据收集脚本。

**Tech Stack:** Claude Code 插件系统（commands/agents/hooks）、Markdown、JSON、Shell 脚本

---

## 前置条件

- Claude Code 已安装（>= 1.0.0）
- 目标项目为 Git 仓库
- 团队有权限修改项目 `.claude/` 目录

---

## Task 1: 创建团队 CLAUDE.md 模板

**Files:**
- Create: `ai-first-toolkit/templates/CLAUDE.md.template`

**Step 1: 创建目录结构**

Run: `mkdir -p ai-first-toolkit/templates`
Expected: Directory created successfully

**Step 2: 编写 CLAUDE.md 模板**

```markdown
# CLAUDE.md - 团队项目约定

> 此文件帮助 Claude Code 理解项目，确保 AI 生成的代码符合团队规范。
> 每个项目应根据实际情况调整此文件。

## 项目概述

<!-- 简要描述项目是什么、解决什么问题 -->
[项目名称] 是一个 [项目类型，如：后端 API 服务 / 微服务 / 全栈应用]。

## 技术栈

- 语言: [如：Java 17 / Go 1.21 / Python 3.11]
- 框架: [如：Spring Boot / Gin / FastAPI]
- 数据库: [如：PostgreSQL / MySQL / MongoDB]
- 缓存: [如：Redis]
- 消息队列: [如：Kafka / RabbitMQ]
- 容器化: [如：Docker / Kubernetes]

## 项目结构

\`\`\`
[项目根目录]/
├── [src/main/java/com/example/]    # 主要业务代码
│   ├── controller/                  # HTTP 接口层
│   ├── service/                     # 业务逻辑层
│   ├── repository/                  # 数据访问层
│   ├── model/                       # 领域模型
│   └── config/                      # 配置类
├── tests/                           # 测试代码
├── docs/                            # 文档
├── scripts/                         # 部署/运维脚本
└── [配置文件...]
\`\`\`

## 编码规范

### 命名约定
- 类名: PascalCase (如 `UserService`)
- 方法名: camelCase (如 `getUserById`)
- 常量: UPPER_SNAKE_CASE (如 `MAX_RETRY_COUNT`)
- 包名: 全小写 (如 `com.example.service`)

### 注释规范
- 公共方法必须有 Javadoc/Docstring
- 复杂逻辑必须有行内注释解释"为什么"
- 避免无意义的注释（如 `// getter`）

### 异常处理
- 业务异常使用自定义异常类
- 不捕获 Exception 后静默忽略
- 错误日志必须包含上下文信息

## 测试策略

### 测试覆盖要求
- Service 层: 单元测试覆盖率 >= 80%
- Controller 层: 集成测试覆盖核心场景
- 工具类: 100% 覆盖

### 测试命名
- 测试类: `[被测类]Test` (如 `UserServiceTest`)
- 测试方法: `should_[预期行为]_when_[条件]` 或 `test_[功能]_[场景]`

### 运行测试
\`\`\`bash
# 运行所有测试
[命令，如：./gradlew test / pytest tests/ / go test ./...]

# 运行特定测试
[命令示例]
\`\`\`

## 日志规范

### 日志级别
- ERROR: 影响业务运行的错误，需要立即关注
- WARN: 潜在问题，需要关注但不影响主流程
- INFO: 关键业务节点（请求开始/结束、状态变更）
- DEBUG: 详细调试信息（仅开发环境）

### 日志格式
- 必须包含: 时间戳、日志级别、类名、TraceId（如有）
- 敏感信息脱敏：密码、token、身份证号等

## API 规范

### RESTful 约定
- GET: 查询操作，不修改状态
- POST: 创建资源
- PUT: 全量更新
- PATCH: 部分更新
- DELETE: 删除资源

### 响应格式
\`\`\`json
{
  "code": 0,
  "message": "success",
  "data": { ... },
  "traceId": "xxx"
}
\`\`\`

### 错误码规范
- 0: 成功
- 1xxx: 参数错误
- 2xxx: 业务错误
- 3xxx: 系统错误
- 5xxx: 第三方服务错误

## 安全规范

### 敏感数据处理
- 密码必须使用 BCrypt/Argon2 加密存储
- Token 不记录到日志
- SQL 使用参数化查询，禁止字符串拼接

### 权限控制
- 所有 API 必须有鉴权
- 敏感操作需要二次验证

## 部署相关

### 环境变量
- 数据库连接: `DATABASE_URL`
- Redis 连接: `REDIS_URL`
- [其他关键配置...]

### 部署命令
\`\`\`bash
# 构建
[构建命令]

# 部署
[部署命令]
\`\`\`

## 已知技术债务

<!-- 列出需要关注但暂未解决的问题 -->
1. [债务描述] - 预计解决时间/优先级

## 常见问题

### Q: [问题1]
A: [答案1]

### Q: [问题2]
A: [答案2]
\`\`\`

Write to file: `ai-first-toolkit/templates/CLAUDE.md.template`

**Step 3: 验证文件创建**

Run: `cat ai-first-toolkit/templates/CLAUDE.md.template | head -20`
Expected: 文件前 20 行正确显示

**Step 4: Commit**

```bash
git add ai-first-toolkit/templates/CLAUDE.md.template
git commit -m "feat(toolkit): add team CLAUDE.md template"
```

---

## Task 2: 创建团队共享 settings.json

**Files:**
- Create: `ai-first-toolkit/config/settings.team.json`
- Create: `ai-first-toolkit/config/README.md`

**Step 1: 创建目录**

Run: `mkdir -p ai-first-toolkit/config`

**Step 2: 编写团队 settings.json**

```json
{
  "permissions": {
    "ask": [
      "Bash(rm:*)",
      "Bash(git push:*)",
      "Bash(git reset:*)"
    ],
    "allow": [
      "Read",
      "Edit",
      "Write",
      "Bash(npm:*)",
      "Bash(yarn:*)",
      "Bash(pnpm:*)",
      "Bash(gradle:*)",
      "Bash(mvn:*)",
      "Bash(go:*)",
      "Bash(python:*)",
      "Bash(pytest:*)",
      "Bash(git status:*)",
      "Bash(git diff:*)",
      "Bash(git log:*)",
      "Bash(git add:*)",
      "Bash(git commit:*)",
      "Bash(ls:*)",
      "Bash(cat:*)",
      "Bash(mkdir:*)"
    ]
  },
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "echo '[AI-Toolkit] Command executed at:' $(date)"
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "echo '[AI-Toolkit] Session ended. Remember to run tests if code was changed.'"
          }
        ]
      }
    ]
  }
}
```

Write to file: `ai-first-toolkit/config/settings.team.json`

**Step 3: 编写配置说明文档**

```markdown
# AI-First Toolkit 配置说明

## settings.team.json 使用方法

### 方法 1: 复制到项目
\`\`\`bash
cp ai-first-toolkit/config/settings.team.json your-project/.claude/settings.json
\`\`\`

### 方法 2: 全局配置（影响所有项目）
\`\`\`bash
# macOS/Linux
mkdir -p ~/.claude
cp ai-first-toolkit/config/settings.team.json ~/.claude/settings.json

# Windows
mkdir %USERPROFILE%\.claude
copy ai-first-toolkit\config\settings.team.json %USERPROFILE%\.claude\settings.json
\`\`\`

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
```

Write to file: `ai-first-toolkit/config/README.md`

**Step 4: Commit**

```bash
git add ai-first-toolkit/config/
git commit -m "feat(toolkit): add team settings.json and configuration guide"
```

---

## Task 3: 创建 /design-review 命令

**Files:**
- Create: `ai-first-toolkit/commands/design-review.md`

**Step 1: 创建目录**

Run: `mkdir -p ai-first-toolkit/commands`

**Step 2: 编写 design-review 命令**

```markdown
---
description: AI 审查设计文档/技术方案，检查完整性和潜在风险
argument-hint: 设计文档路径或描述
---

# 设计审查

你是一个资深技术架构师，负责审查设计文档和技术方案。

## 审查目标

对提供的设计文档进行全面审查，发现潜在问题，提出改进建议。

## 审查维度

### 1. 完整性检查
- [ ] 需求背景是否清晰？
- [ ] 目标是否明确可度量？
- [ ] 是否覆盖所有业务场景？
- [ ] 边界条件是否考虑？
- [ ] 异常处理是否完整？

### 2. 架构合理性
- [ ] 是否符合现有架构风格？
- [ ] 模块划分是否合理？
- [ ] 依赖关系是否清晰？
- [ ] 是否有过度设计？

### 3. 风险识别
- [ ] 技术风险：是否使用不熟悉的技术？
- [ ] 性能风险：是否有性能瓶颈？
- [ ] 安全风险：是否有安全隐患？
- [ ] 兼容风险：是否影响现有功能？
- [ ] 运维风险：部署和监控是否考虑？

### 4. 实现可行性
- [ ] 技术方案是否可行？
- [ ] 工时估算是否合理？
- [ ] 是否有替代方案？
- [ ] 依赖是否可满足？

### 5. 可维护性
- [ ] 代码结构是否清晰？
- [ ] 是否易于测试？
- [ ] 是否易于扩展？
- [ ] 文档是否完善？

## 输入处理

$ARGUMENTS

如果参数是文件路径，读取该文件内容进行审查。
如果参数是描述，基于描述生成审查问题。

## 输出格式

\`\`\`
## 审查结论

**整体评价**: [通过/有条件通过/需要修改]

**必须修改项** (阻碍上线):
1. [问题描述] - [建议修改方案]

**建议改进项** (推荐修改):
1. [问题描述] - [建议修改方案]

**疑问项** (需要澄清):
1. [疑问描述]

## 详细审查结果

### 完整性
[详细分析...]

### 架构合理性
[详细分析...]

### 风险识别
[详细分析...]

### 实现可行性
[详细分析...]

### 可维护性
[详细分析...]
\`\`\`
```

Write to file: `ai-first-toolkit/commands/design-review.md`

**Step 3: Commit**

```bash
git add ai-first-toolkit/commands/design-review.md
git commit -m "feat(toolkit): add /design-review command for design document review"
```

---

## Task 4: 创建 /tech-spec 命令

**Files:**
- Create: `ai-first-toolkit/commands/tech-spec.md`

**Step 1: 编写 tech-spec 命令**

```markdown
---
description: 根据需求生成技术方案文档，包含多方案对比
argument-hint: 需求描述或需求文档路径
---

# 技术方案生成

你是一个技术架构师，需要根据需求生成结构化的技术方案文档。

## 工作流程

### Phase 1: 需求理解

1. 读取并分析需求内容
2. 识别核心功能点
3. 提取技术约束
4. 列出需要澄清的问题

**如果需求不清晰，先向用户提问澄清后再继续。**

### Phase 2: 现有架构分析

1. 读取项目 CLAUDE.md 了解现有架构
2. 探索相关代码，了解现有实现
3. 识别可复用的组件和模式

### Phase 3: 方案设计

为需求设计 **2-3 种实现方案**，每种方案包含：

#### 方案结构

\`\`\`
### 方案 N: [方案名称]

#### 核心思路
[一句话概括方案核心思想]

#### 架构图/流程图
[使用 ASCII 或 Mermaid 画出关键架构]

#### 关键技术点
- [技术点1]: [说明]
- [技术点2]: [说明]

#### 改动范围
| 文件/模块 | 改动类型 | 改动内容 |
|----------|---------|---------|
| [路径] | 新增/修改 | [描述] |

#### 风险评估
| 风险 | 等级 | 应对措施 |
|-----|-----|---------|
| [风险描述] | 高/中/低 | [应对方案] |

#### 预估工时
- 开发: [人天]
- 测试: [人天]
- 总计: [人天]

#### 优缺点
**优点:**
- [优点1]
- [优点2]

**缺点:**
- [缺点1]
- [缺点2]
\`\`\`

### Phase 4: 方案对比与推荐

\`\`\`
## 方案对比

| 维度 | 方案1 | 方案2 | 方案3 |
|-----|------|------|------|
| 开发成本 | [评估] | [评估] | [评估] |
| 维护成本 | [评估] | [评估] | [评估] |
| 性能影响 | [评估] | [评估] | [评估] |
| 风险程度 | [评估] | [评估] | [评估] |
| 扩展性 | [评估] | [评估] | [评估] |

## 推荐

**推荐方案**: [方案N]

**理由**:
[详细说明为什么推荐这个方案]
\`\`\`

## 输入处理

$ARGUMENTS

## 输出

生成完整的技术方案文档，保存到 `docs/specs/[日期]-[功能名].md`
```

Write to file: `ai-first-toolkit/commands/tech-spec.md`

**Step 2: Commit**

```bash
git add ai-first-toolkit/commands/tech-spec.md
git commit -m "feat(toolkit): add /tech-spec command for technical specification generation"
```

---

## Task 5: 创建 /test-gen 命令

**Files:**
- Create: `ai-first-toolkit/commands/test-gen.md`

**Step 1: 编写 test-gen 命令**

```markdown
---
description: 为指定代码生成测试用例，覆盖正常/异常/边界场景
argument-hint: 要测试的文件路径或函数名
---

# 测试用例生成

你是一个测试工程师，需要为目标代码生成全面的测试用例。

## 工作流程

### Phase 1: 代码分析

1. 读取目标代码文件
2. 识别公共方法和函数
3. 分析输入输出类型
4. 识别依赖项（需要 mock 的部分）

### Phase 2: 测试场景设计

为每个方法设计以下类型的测试：

#### 1. 正常场景 (Happy Path)
- 标准输入，预期输出
- 典型业务场景

#### 2. 边界条件
- 空值/null
- 空集合
- 最大/最小值
- 边界索引

#### 3. 异常场景
- 非法参数
- 依赖服务失败
- 并发场景（如适用）

#### 4. 业务规则
- 特定业务逻辑的验证
- 状态转换

### Phase 3: 测试代码生成

#### 测试命名规范
\`\`\`
[语言特定规范，参考 CLAUDE.md 中的测试策略]

示例:
- Java: should_returnUser_when_idExists()
- Python: test_get_user_by_id_exists()
- Go: TestGetUserByID_Exists
\`\`\`

#### 测试结构 (AAA 模式)
\`\`\`
// Arrange - 准备测试数据
// Act - 执行被测方法
// Assert - 验证结果
\`\`\`

### Phase 4: Mock 策略

识别需要 Mock 的依赖：
- 数据库访问
- 外部 API 调用
- 文件系统操作
- 时间依赖

## 输入处理

$ARGUMENTS

可以是：
- 文件路径: `src/service/UserService.java`
- 模块路径: `src/service/`
- 函数名: `UserService.getUserById`

## 输出格式

### 测试覆盖率分析

\`\`\`
## 被测方法: [方法名]

### 测试场景覆盖

| 场景类型 | 测试用例 | 覆盖情况 |
|---------|---------|---------|
| 正常场景 | [用例名] | ✅ |
| 边界条件 | [用例名] | ✅ |
| 异常场景 | [用例名] | ✅ |

### 未覆盖场景
- [场景描述] - [原因]
\`\`\`

### 生成的测试代码

\`\`\`[语言]
// 测试代码
\`\`\`

## 后续步骤

1. 将测试代码写入对应的测试文件
2. 运行测试确保通过
3. 检查覆盖率报告
```

Write to file: `ai-first-toolkit/commands/test-gen.md`

**Step 2: Commit**

```bash
git add ai-first-toolkit/commands/test-gen.md
git commit -m "feat(toolkit): add /test-gen command for test case generation"
```

---

## Task 6: 创建度量基线收集脚本

**Files:**
- Create: `ai-first-toolkit/scripts/collect-baseline.sh`
- Create: `ai-first-toolkit/scripts/analyze-metrics.py`

**Step 1: 创建目录**

Run: `mkdir -p ai-first-toolkit/scripts`

**Step 2: 编写基线收集脚本**

```bash
#!/bin/bash

# AI-First Toolkit - 度量基线收集脚本
# 用法: ./collect-baseline.sh <项目路径> <输出文件>

set -e

PROJECT_PATH=${1:-.}
OUTPUT_FILE=${2:-"baseline-metrics-$(date +%Y%m%d-%H%M%S).json"}

echo "=== AI-First Toolkit 度量基线收集 ==="
echo "项目路径: $PROJECT_PATH"
echo "输出文件: $OUTPUT_FILE"
echo ""

cd "$PROJECT_PATH"

# 收集 Git 统计
echo "收集 Git 统计..."
TOTAL_COMMITS=$(git rev-list --count HEAD 2>/dev/null || echo "0")
AUTHORS=$(git shortlog -sn | wc -l | tr -d ' ')
LAST_30_DAYS_COMMITS=$(git log --since="30 days ago" --oneline | wc -l | tr -d ' ')

# 收集代码统计
echo "收集代码统计..."
TOTAL_FILES=$(find . -name "*.java" -o -name "*.go" -o -name "*.py" -o -name "*.ts" -o -name "*.js" 2>/dev/null | grep -v node_modules | grep -v vendor | wc -l)
TOTAL_LINES=$(find . -name "*.java" -o -name "*.go" -o -name "*.py" -o -name "*.ts" -o -name "*.js" 2>/dev/null | grep -v node_modules | grep -v vendor | xargs wc -l 2>/dev/null | tail -1 | awk '{print $1}' || echo "0")

# 收集测试统计
echo "收集测试统计..."
TEST_FILES=$(find . -path "*/test*" -name "*.java" -o -path "*/test*" -name "*.go" -o -path "*/tests*" -name "*.py" -o -path "*/test*" -name "*.ts" 2>/dev/null | grep -v node_modules | wc -l)

# 生成 JSON 输出
cat > "$OUTPUT_FILE" << EOF
{
  "collected_at": "$(date -Iseconds)",
  "project_path": "$(pwd)",
  "git_metrics": {
    "total_commits": $TOTAL_COMMITS,
    "author_count": $AUTHORS,
    "commits_last_30_days": $LAST_30_DAYS_COMMITS
  },
  "code_metrics": {
    "total_source_files": $TOTAL_FILES,
    "total_lines_of_code": $TOTAL_LINES,
    "test_files": $TEST_FILES
  },
  "efficiency_metrics": {
    "note": "需要从工单系统手动收集",
    "avg_requirement_to_design_days": null,
    "avg_design_to_code_days": null,
    "avg_code_to_test_days": null,
    "avg_test_to_deploy_days": null,
    "avg_review_rounds": null,
    "bug_density_per_kloc": null
  },
  "quality_metrics": {
    "note": "需要从 CI/CD 或 SonarQube 收集",
    "test_coverage_percent": null,
    "code_smells": null,
    "security_issues": null
  }
}
EOF

echo ""
echo "=== 基线收集完成 ==="
echo "结果已保存到: $OUTPUT_FILE"
echo ""
echo "下一步："
echo "1. 手动填写 efficiency_metrics 中的字段（从工单系统获取）"
echo "2. 手动填写 quality_metrics 中的字段（从 CI/CD 获取）"
echo "3. 定期重新运行此脚本，对比数据变化"
```

Run: `chmod +x ai-first-toolkit/scripts/collect-baseline.sh`

Write to file: `ai-first-toolkit/scripts/collect-baseline.sh`

**Step 3: 编写度量分析脚本**

```python
#!/usr/bin/env python3
"""
AI-First Toolkit - 度量数据分析脚本
用法: python analyze-metrics.py <基线文件> <当前文件> [--output report.md]
"""

import json
import sys
from datetime import datetime
from pathlib import Path

def load_metrics(filepath):
    """加载度量数据文件"""
    with open(filepath, 'r') as f:
        return json.load(f)

def calculate_change(baseline, current):
    """计算变化百分比"""
    if baseline is None or current is None or baseline == 0:
        return None
    return ((current - baseline) / baseline) * 100

def generate_report(baseline, current, output_file=None):
    """生成对比报告"""
    report = []
    report.append("# AI-First 效能度量对比报告\n")
    report.append(f"基线采集时间: {baseline.get('collected_at', 'N/A')}")
    report.append(f"当前采集时间: {current.get('collected_at', 'N/A')}\n")

    # Git 指标
    report.append("## Git 指标\n")
    report.append("| 指标 | 基线 | 当前 | 变化 |")
    report.append("|------|------|------|------|")

    bg = baseline.get('git_metrics', {})
    cg = current.get('git_metrics', {})

    for key, label in [
        ('total_commits', '总提交数'),
        ('author_count', '贡献者数'),
        ('commits_last_30_days', '近30天提交')
    ]:
        b_val = bg.get(key)
        c_val = cg.get(key)
        change = calculate_change(b_val, c_val)
        change_str = f"{change:+.1f}%" if change is not None else "N/A"
        report.append(f"| {label} | {b_val or 'N/A'} | {c_val or 'N/A'} | {change_str} |")

    # 代码指标
    report.append("\n## 代码指标\n")
    report.append("| 指标 | 基线 | 当前 | 变化 |")
    report.append("|------|------|------|------|")

    bc = baseline.get('code_metrics', {})
    cc = current.get('code_metrics', {})

    for key, label in [
        ('total_source_files', '源文件数'),
        ('total_lines_of_code', '代码行数'),
        ('test_files', '测试文件数')
    ]:
        b_val = bc.get(key)
        c_val = cc.get(key)
        change = calculate_change(b_val, c_val)
        change_str = f"{change:+.1f}%" if change is not None else "N/A"
        report.append(f"| {label} | {b_val or 'N/A'} | {c_val or 'N/A'} | {change_str} |")

    # 效率指标（手动填写的数据）
    be = baseline.get('efficiency_metrics', {})
    ce = current.get('efficiency_metrics', {})

    if any(be.values()) or any(ce.values()):
        report.append("\n## 效率指标\n")
        report.append("| 指标 | 基线 | 当前 | 效率提升 |")
        report.append("|------|------|------|----------|")

        for key, label in [
            ('avg_requirement_to_design_days', '需求→设计（天）'),
            ('avg_design_to_code_days', '设计→编码（天）'),
            ('avg_code_to_test_days', '编码→测试（天）'),
            ('avg_test_to_deploy_days', '测试→上线（天）'),
            ('avg_review_rounds', 'Review轮次'),
            ('bug_density_per_kloc', '缺陷密度/千行')
        ]:
            b_val = be.get(key)
            c_val = ce.get(key)
            if b_val and c_val:
                improvement = ((b_val - c_val) / b_val) * 100
                imp_str = f"+{improvement:.1f}%"
            else:
                imp_str = "N/A"
            report.append(f"| {label} | {b_val or 'N/A'} | {c_val or 'N/A'} | {imp_str} |")

    # 质量指标
    bq = baseline.get('quality_metrics', {})
    cq = current.get('quality_metrics', {})

    if any(bq.values()) or any(cq.values()):
        report.append("\n## 质量指标\n")
        report.append("| 指标 | 基线 | 当前 | 变化 |")
        report.append("|------|------|------|------|")

        for key, label in [
            ('test_coverage_percent', '测试覆盖率（%）'),
            ('code_smells', '代码异味'),
            ('security_issues', '安全问题')
        ]:
            b_val = bq.get(key)
            c_val = cq.get(key)
            change = calculate_change(b_val, c_val)
            change_str = f"{change:+.1f}%" if change is not None else "N/A"
            report.append(f"| {label} | {b_val or 'N/A'} | {c_val or 'N/A'} | {change_str} |")

    report_text = '\n'.join(report)

    if output_file:
        Path(output_file).write_text(report_text, encoding='utf-8')
        print(f"报告已保存到: {output_file}")
    else:
        print(report_text)

def main():
    if len(sys.argv) < 3:
        print("用法: python analyze-metrics.py <基线文件> <当前文件> [--output report.md]")
        sys.exit(1)

    baseline_file = sys.argv[1]
    current_file = sys.argv[2]
    output_file = None

    if len(sys.argv) >= 4 and sys.argv[3] == '--output':
        output_file = sys.argv[4]

    baseline = load_metrics(baseline_file)
    current = load_metrics(current_file)

    generate_report(baseline, current, output_file)

if __name__ == '__main__':
    main()
```

Write to file: `ai-first-toolkit/scripts/analyze-metrics.py`

**Step 4: Commit**

```bash
git add ai-first-toolkit/scripts/
git commit -m "feat(toolkit): add baseline collection and analysis scripts"
```

---

## Task 7: 创建工具包 README 和安装脚本

**Files:**
- Create: `ai-first-toolkit/README.md`
- Create: `ai-first-toolkit/install.sh`

**Step 1: 编写 README**

```markdown
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
./scripts/collect-baseline.sh . baseline-$(date +%Y%m%d).json
```

### 对比分析

```bash
python scripts/analyze-metrics.py baseline-20260101.json baseline-20260401.json --output report.md
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
```

Write to file: `ai-first-toolkit/README.md`

**Step 2: 编写安装脚本**

```bash
#!/bin/bash

# AI-First Toolkit - 一键安装脚本
# 用法: ./install.sh [目标项目路径]

set -e

TOOLKIT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR=${1:-.}

echo "=== AI-First Toolkit 安装 ==="
echo "工具包路径: $TOOLKIT_DIR"
echo "目标项目: $TARGET_DIR"
echo ""

cd "$TARGET_DIR"

# 1. 安装 CLAUDE.md
echo "[1/4] 安装 CLAUDE.md..."
if [ -f "CLAUDE.md" ]; then
    echo "  CLAUDE.md 已存在，跳过（如需更新请手动覆盖）"
else
    cp "$TOOLKIT_DIR/templates/CLAUDE.md.template" ./CLAUDE.md
    echo "  已创建 CLAUDE.md，请根据项目实际情况修改"
fi

# 2. 安装 settings.json
echo "[2/4] 安装 settings.json..."
mkdir -p .claude
if [ -f ".claude/settings.json" ]; then
    echo "  .claude/settings.json 已存在，跳过"
else
    cp "$TOOLKIT_DIR/config/settings.team.json" .claude/settings.json
    echo "  已创建 .claude/settings.json"
fi

# 3. 安装自定义命令
echo "[3/4] 安装自定义命令..."
mkdir -p .claude/commands
for cmd in "$TOOLKIT_DIR/commands"/*.md; do
    cmd_name=$(basename "$cmd")
    cp "$cmd" ".claude/commands/$cmd_name"
    echo "  已安装 /${cmd_name%.md}"
done

# 4. 创建度量目录
echo "[4/4] 创建度量目录..."
mkdir -p docs/metrics
echo "  已创建 docs/metrics/"

echo ""
echo "=== 安装完成 ==="
echo ""
echo "下一步："
echo "1. 编辑 CLAUDE.md，填写项目实际情况"
echo "2. 重启 Claude Code 使配置生效"
echo "3. 尝试使用 /design-review、/tech-spec、/test-gen 命令"
echo "4. 运行 $TOOLKIT_DIR/scripts/collect-baseline.sh 收集度量基线"
```

Run: `chmod +x ai-first-toolkit/install.sh`

Write to file: `ai-first-toolkit/install.sh`

**Step 3: Commit**

```bash
git add ai-first-toolkit/
git commit -m "feat(toolkit): add README and install script for AI-First toolkit"
```

---

## Task 8: 创建"超级个体"试点指南

**Files:**
- Create: `ai-first-toolkit/guides/super-individual-pilot.md`

**Step 1: 创建目录**

Run: `mkdir -p ai-first-toolkit/guides`

**Step 2: 编写试点指南**

```markdown
# "超级个体"试点指南

本指南帮助试点成员使用 AI 工具完成从需求到上线的全流程。

## 试点前准备

### 环境配置

- [ ] Claude Code 已安装并登录
- [ ] 项目 CLAUDE.md 已配置
- [ ] 自定义命令已安装（/design-review, /tech-spec, /test-gen）
- [ ] 了解 feature-dev 7 阶段工作流

### 选择试点需求

建议选择：
- 中等复杂度的需求（预估 3-5 人天）
- 需求文档相对清晰
- 非紧急需求（有试错空间）

## 全流程执行

### Step 1: 需求理解（人 + AI）

**目标**: 确保完全理解需求，消除歧义

**操作**:
1. 将需求文档提供给 Claude Code
2. 使用命令:
   ```
   分析以下需求，识别：
   1. 核心功能点
   2. 需要澄清的问题
   3. 潜在的技术挑战

   [粘贴需求文档]
   ```
3. 与产品经理确认澄清的问题
4. **记录耗时**: `需求理解开始时间` -> `需求理解结束时间`

**产出**: 需求确认清单

---

### Step 2: 架构设计（AI 生成 + 人决策）

**目标**: 产出经过评审的技术方案

**操作**:
1. 使用命令:
   ```
   /tech-spec [需求描述或需求文档路径]
   ```
2. Claude 会生成 2-3 种方案
3. 评估方案，选择最合适的
4. 使用命令进行方案审查:
   ```
   /design-review [生成的方案文档]
   ```
5. 根据审查意见调整方案
6. 提交给技术 Lead 评审
7. **记录耗时**: `设计开始时间` -> `设计评审通过时间`

**产出**: 技术方案文档（保存到 `docs/specs/`）

---

### Step 3: 编码实现（AI 主导 + 人工 Review）

**目标**: 按方案实现功能

**操作**:
1. 使用 feature-dev 工作流:
   ```
   /feature-dev [功能描述]
   ```
2. Claude 会按照 7 阶段流程执行:
   - Phase 1: Discovery（确认理解）
   - Phase 2: Codebase Exploration（探索代码）
   - Phase 3: Clarifying Questions（澄清问题）
   - Phase 4: Architecture Design（架构设计）
   - Phase 5: Implementation（编码实现）
   - Phase 6: Quality Review（质量审查）
   - Phase 7: Summary（总结）

3. 在关键节点进行人工 Review:
   - Phase 4 后: 确认架构方案
   - Phase 5 中: 每个模块完成后检查代码
   - Phase 6 后: 确认问题修复

4. **记录耗时**: `编码开始时间` -> `编码完成时间`
5. **记录数据**:
   - AI 生成代码行数
   - 人工修改的代码行数
   - 代码采纳率 = (AI 生成 - 人工修改) / AI 生成

**产出**: 功能代码 + 变更文件清单

---

### Step 4: 测试生成（AI 主导）

**目标**: 生成高覆盖率的测试代码

**操作**:
1. 为核心模块生成测试:
   ```
   /test-gen src/service/CoreService.java
   ```
2. 审查生成的测试用例:
   - 覆盖场景是否完整？
   - 边界条件是否考虑？
   - Mock 是否合理？
3. 运行测试确保通过
4. 检查覆盖率报告
5. **记录耗时**: `测试开始时间` -> `测试完成时间`
6. **记录数据**: 测试覆盖率变化

**产出**: 测试代码 + 覆盖率报告

---

### Step 5: 代码审查（AI 预审 + 人工终审）

**目标**: 确保代码质量

**操作**:
1. 提交 PR 前，使用 AI 审查:
   ```
   对以下变更进行代码审查，检查：
   1. 代码规范
   2. 潜在 Bug
   3. 性能问题
   4. 安全风险
   ```
2. 根据 AI 审查意见修复问题
3. 提交 PR
4. 如有 code-review 插件，使用:
   ```
   /code-review [PR号]
   ```
5. 等待人工 Review
6. **记录数据**: Review 轮次、问题数量

**产出**: 通过审查的 PR

---

### Step 6: 交付上线

**目标**: 安全上线

**操作**:
1. AI 生成部署检查清单:
   ```
   为本次变更生成部署检查清单，包括：
   1. 配置变更
   2. 数据库迁移
   3. 依赖更新
   4. 回滚方案
   ```
2. 执行部署
3. 验证上线结果
4. **记录耗时**: `PR 合并时间` -> `上线完成时间`

**产出**: 上线成功 + 验证报告

---

## 数据记录模板

完成试点后，填写以下数据：

```yaml
试点成员: [姓名]
需求名称: [需求名称]
需求复杂度: [简单/中等/复杂]

耗时数据:
  需求理解: [小时]
  架构设计: [小时]
  编码实现: [小时]
  测试编写: [小时]
  代码审查: [小时]
  部署上线: [小时]
  总计: [小时]

质量数据:
  代码变更行数: [行]
  AI生成行数: [行]
  人工修改行数: [行]
  代码采纳率: [百分比]
  测试覆盖率变化: [+X%]
  Review轮次: [次]
  Review问题数: [个]

效率对比:
  传统方式预估: [人天]
  AI辅助实际: [人天]
  效率提升: [百分比]

经验总结:
  做得好的: [描述]
  遇到的问题: [描述]
  改进建议: [描述]
```

## 注意事项

### AI 的局限性

1. **复杂业务逻辑**: AI 可能无法完全理解业务上下文，需要人工审查
2. **跨系统集成**: 涉及其他系统的变更，AI 可能不了解约束
3. **性能优化**: 性能敏感的代码，需要人工评估
4. **安全相关**: 安全相关的代码，必须人工仔细审查

### 最佳实践

1. **小步提交**: 不要让 AI 一次生成大量代码，分模块进行
2. **持续验证**: 每完成一个模块就运行测试
3. **保持上下文**: 长时间对话后，考虑重新开始会话以获取最新上下文
4. **记录问题**: 遇到 AI 无法解决的问题，记录下来用于改进

## 问题排查

### Q: AI 生成的代码不符合项目规范
A: 检查 CLAUDE.md 是否完整描述了编码规范，补充缺失的约定

### Q: AI 不了解现有的工具类/公共组件
A: 在 CLAUDE.md 中添加常用工具类的说明和使用示例

### Q: AI 生成的测试无法运行
A: 检查测试依赖是否正确，Mock 配置是否合理

### Q: 效率没有明显提升
A: 检查是否在不适合的场景使用 AI（复杂业务、创新功能），尝试选择更标准的任务
```

Write to file: `ai-first-toolkit/guides/super-individual-pilot.md`

**Step 3: Commit**

```bash
git add ai-first-toolkit/guides/
git commit -m "feat(toolkit): add super-individual pilot guide"
```

---

## 完成检查

所有任务完成后，验证文件结构：

Run: `find ai-first-toolkit -type f | sort`

Expected output:
```
ai-first-toolkit/README.md
ai-first-toolkit/commands/design-review.md
ai-first-toolkit/commands/tech-spec.md
ai-first-toolkit/commands/test-gen.md
ai-first-toolkit/config/README.md
ai-first-toolkit/config/settings.team.json
ai-first-toolkit/guides/super-individual-pilot.md
ai-first-toolkit/install.sh
ai-first-toolkit/scripts/analyze-metrics.py
ai-first-toolkit/scripts/collect-baseline.sh
ai-first-toolkit/templates/CLAUDE.md.template
```

---

## 后续步骤

1. 将 `ai-first-toolkit/` 复制到团队共享位置或内部仓库
2. 在试点项目中运行 `install.sh`
3. 选择 2-3 名成员开始"超级个体"试点
4. 定期收集度量数据，对比效率变化
5. 根据反馈迭代改进工具包
