#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT"

OUT="product/sell-now/assets"
mkdir -p "$OUT"

FREE_LIST=$(mktemp)
PRO_LIST=$(mktemp)

# Free sample: matrix + summary + 3 representative case reports/worksheets
cat > "$FREE_LIST" <<LIST
kernel/user/stage3/planning/STAGE3_FULL_TEST_SUMMARY.md
kernel/user/stage3/planning/STAGE3_PROBE_FLOW_GRAPH.md
kernel/user/stage3/planning/STAGE3_WORKSHEET_INDEX.md
kernel/user/stage3/case2_deep_miss/reports/case2_deep_miss_trace_report.md
kernel/user/stage3/case2_deep_miss/worksheets/case2_deep_miss_worksheet.md
kernel/user/stage3/case3_deep_hit/reports/case3_deep_hit_trace_report.md
kernel/user/stage3/case3_deep_hit/worksheets/case3_deep_hit_worksheet.md
kernel/user/stage3/case17_do_filp_open_deep_trace/reports/user_trigger_trace_report.md
kernel/user/stage3/case17_do_filp_open_deep_trace/worksheets/user_trigger_worksheet.md
LIST

# Pro pack: all reports + worksheets + planning
find kernel/user/stage3 -type f \( -name '*_trace_report.md' -o -name '*_worksheet.md' -o -name '*_dmesg.txt' \) | sort > "$PRO_LIST"
find kernel/user/stage3/planning -type f | sort >> "$PRO_LIST"

rm -f "$OUT/stage3-free-sample.zip" "$OUT/stage3-pro-pack.zip"
zip -q -@ "$OUT/stage3-free-sample.zip" < "$FREE_LIST"
zip -q -@ "$OUT/stage3-pro-pack.zip" < "$PRO_LIST"

rm -f "$FREE_LIST" "$PRO_LIST"

echo "built: $OUT/stage3-free-sample.zip"
echo "built: $OUT/stage3-pro-pack.zip"
