#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
SUMMARY_MD="$ROOT_DIR/kernel/user/stage3/planning/STAGE3_FULL_TEST_SUMMARY.md"

if [[ ! -f "$SUMMARY_MD" ]]; then
  echo "[STAGE3_GATE] FAIL: summary file missing: $SUMMARY_MD" >&2
  exit 1
fi

total_pairs=$(awk -F': ' '/^- Total pairs:/ {print $2}' "$SUMMARY_MD" | head -n1 | tr -d '\r')
pass_hits=$(awk -F': ' '/^- pass_probe_hits:/ {print $2}' "$SUMMARY_MD" | head -n1 | tr -d '\r')
partial_hits=$(awk -F': ' '/^- partial:/ {print $2}' "$SUMMARY_MD" | head -n1 | tr -d '\r')
fail_hits=$(awk -F': ' '/^- fail\/exception:/ {print $2}' "$SUMMARY_MD" | head -n1 | tr -d '\r')

if [[ -z "${total_pairs:-}" || -z "${pass_hits:-}" || -z "${partial_hits:-}" || -z "${fail_hits:-}" ]]; then
  echo "[STAGE3_GATE] FAIL: could not parse summary fields from $SUMMARY_MD" >&2
  exit 1
fi

echo "[STAGE3_GATE] total_pairs=$total_pairs pass_probe_hits=$pass_hits partial=$partial_hits fail_exception=$fail_hits"

if [[ "$total_pairs" != "41" ]]; then
  echo "[STAGE3_GATE] FAIL: expected Total pairs = 41" >&2
  exit 1
fi

if [[ "$pass_hits" != "41" ]]; then
  echo "[STAGE3_GATE] FAIL: expected pass_probe_hits = 41" >&2
  exit 1
fi

if [[ "$partial_hits" != "0" ]]; then
  echo "[STAGE3_GATE] FAIL: expected partial = 0" >&2
  exit 1
fi

if [[ "$fail_hits" != "0" ]]; then
  echo "[STAGE3_GATE] FAIL: expected fail/exception = 0" >&2
  exit 1
fi

echo "[STAGE3_GATE] PASS: publish gate satisfied."
