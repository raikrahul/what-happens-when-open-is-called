# Start Selling in 60 Minutes

## 0) Inputs
- repo: `https://github.com/raikrahul/what-happens-when-open-is-called`
- proof count: 41 userspace+driver pairs
- latest full test summary: `kernel/user/stage3/planning/STAGE3_FULL_TEST_SUMMARY.md`

## 1) Build product artifacts (10 min)
```bash
bash tools/sales/build_offer_assets.sh
```
Outputs:
- `product/sell-now/assets/stage3-free-sample.zip`
- `product/sell-now/assets/stage3-pro-pack.zip`

## 2) Create payment products (15 min)
- Gumroad/LemonSqueezy products:
1. Trace Pack ($29)
2. Pro Case Pack ($99)
3. 1:1 Session ($299)

## 3) Paste links (5 min)
- Edit `product/sell-now/checkout_links.env`
- Edit `site/sell.html` links

## 4) Publish (5 min)
```bash
make publish MSG="sales links live"
```

## 5) Open release with assets (10 min)
```bash
gh release create "v-sales-$(date +%Y%m%d-%H%M)" \
  product/sell-now/assets/stage3-free-sample.zip \
  product/sell-now/assets/stage3-pro-pack.zip \
  --title "Stage3 Trace Packs" \
  --notes-file product/sell-now/launch_thread.md
```

## 6) Launch outreach (15 min)
- Post thread from `product/sell-now/launch_thread.md`
- Send first 30 DMs using `product/sell-now/dm_templates.md`
- Log to `product/sell-now/leads.csv`

## Revenue math
- 10 sales/day × $29 = $290/day gross
- 3 sales/day × $99 = $297/day gross
- 1 session/week × $299 ≈ $42/day gross equivalent
- combined ≈ $629/day gross before fees/refunds
