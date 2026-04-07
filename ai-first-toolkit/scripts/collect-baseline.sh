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
