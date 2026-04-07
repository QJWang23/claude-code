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
