#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
W1_FILE="$BASE_DIR/16_7_DAY_PREWRITTEN_X_POSTS.md"
W2_FILE="$BASE_DIR/17_7_DAY_PREWRITTEN_X_POSTS_WEEK2.md"

usage() {
  cat <<USAGE
Usage:
  $(basename "$0") --week 1 --day 3
  $(basename "$0") --week 2 --today

Options:
  --week <1|2>   Required unless inferred with --today default week=1
  --day <1-14>   Day number (1-7 for week1, 8-14 for week2)
  --today        Use day-of-week mapping (Mon=1 ... Sun=7 for week1, 8..14 for week2)
USAGE
}

week=""
day=""
use_today=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --week)
      week="${2:-}"; shift 2;;
    --day)
      day="${2:-}"; shift 2;;
    --today)
      use_today=1; shift;;
    -h|--help)
      usage; exit 0;;
    *)
      echo "Unknown arg: $1" >&2; usage; exit 1;;
  esac
done

if [[ $use_today -eq 1 ]]; then
  dow=$(date +%u) # 1..7
  if [[ -z "$week" ]]; then
    week="1"
  fi
  if [[ "$week" == "1" ]]; then
    day="$dow"
  elif [[ "$week" == "2" ]]; then
    day=$((dow + 7))
  else
    echo "week must be 1 or 2" >&2; exit 1
  fi
fi

if [[ -z "$week" || -z "$day" ]]; then
  usage; exit 1
fi

if [[ "$week" == "1" ]]; then
  file="$W1_FILE"
elif [[ "$week" == "2" ]]; then
  file="$W2_FILE"
else
  echo "week must be 1 or 2" >&2; exit 1
fi

if [[ ! -f "$file" ]]; then
  echo "Missing file: $file" >&2; exit 1
fi

# Print from "## Day X" until next level-2 section or EOF
awk -v target="## Day $day" '
  $0 == target {print_block=1}
  print_block && $0 ~ /^## / && $0 != target {exit}
  print_block {print}
' "$file" || true

# If nothing printed, fail clearly.
if ! awk -v target="## Day $day" '$0 == target {found=1} END{exit(found?0:1)}' "$file"; then
  echo "Day $day not found in $file" >&2
  exit 1
fi
