#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT"

bash tools/sales/build_offer_assets.sh

if rg -q 'https://example.com' product/sell-now/checkout_links.env site/sell.html; then
  echo "ERROR: placeholder checkout links still present"
  echo "Update product/sell-now/checkout_links.env and site/sell.html first"
  exit 2
fi

make publish MSG="sales funnel update"

TAG="v-sales-$(date +%Y%m%d-%H%M)"
if command -v gh >/dev/null 2>&1; then
  gh release create "$TAG" \
    product/sell-now/assets/stage3-free-sample.zip \
    product/sell-now/assets/stage3-pro-pack.zip \
    --title "Stage3 Trace Packs" \
    --notes-file product/sell-now/launch_thread.md || true
fi

echo "Sales publish done."
