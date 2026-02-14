#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "usage: $0 <userspace_src_relpath> <target_comm>"
  exit 1
fi

ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
USER_SRC="$1"
TARGET_COMM="$2"

CSV="$ROOT/kernel/user/stage3/planning/STAGE3_DRIVER_PAIR_MATRIX.csv"
row="$(awk -F',' -v u="$USER_SRC" '$2==u {print $0}' "$CSV" | head -n1)"
if [[ -z "$row" ]]; then
  echo "pair not found for $USER_SRC"
  exit 2
fi

drv_src="$(echo "$row" | cut -d',' -f3)"
mod_name="$(basename "$drv_src" .c)"
drv_dir="$ROOT/$(dirname "$drv_src")"

echo "[run_stage3_pair] driver=$drv_src mod=$mod_name comm=$TARGET_COMM"
make -C "$drv_dir"

sudo insmod "$drv_dir/$mod_name.ko" target_comm="$TARGET_COMM"
echo "[run_stage3_pair] module loaded"

echo "[run_stage3_pair] run your userspace binary now"
read -r -p "Press Enter after userspace run completes..." _

sudo dmesg | tail -n 400
sudo rmmod "$mod_name"
echo "[run_stage3_pair] done"
