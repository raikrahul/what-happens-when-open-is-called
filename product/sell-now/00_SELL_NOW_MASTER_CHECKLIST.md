# Sell Now: End-to-End Checklist

## Problem Statement
You have Stage3 kernel tracing assets. Goal: convert them into paid products without hosting cost.

## Offer Stack
1. Free: repo + public worksheets + public case explainers.
2. Low-ticket ($19-$39): "Trace Pack" (logs + worksheets + walkthrough notes).
3. Mid-ticket ($79-$149): "Pro Case Pack" (deeper pair reports + debugging scripts).
4. High-ticket ($299+): 1:1 debugging session (90 min).

## Exact Steps
1. Pick one payment rail: Gumroad or Lemon Squeezy.
2. Create 3 products: Trace Pack, Pro Case Pack, 1:1 Session.
3. Put checkout links in `product/sell-now/checkout_links.env`.
4. Update site page `site/sell.html` with those links.
5. Build and publish: `make build-site && make publish MSG="sales page live"`.
6. Post launch thread (template in `product/sell-now/launch_thread.md`).
7. DM 50 targeted people/day (template in `product/sell-now/dm_templates.md`).
8. Log every lead in `product/sell-now/leads.csv`.
9. Weekly price test: run rows from `product/sell-now/price_test_matrix.csv`.
10. Every Sunday: calculate net using `python3 tools/sales/revenue_calc.py`.

## Daily KPI
1. New leads
2. Calls booked
3. Sales count
4. Refund count
5. Net revenue

