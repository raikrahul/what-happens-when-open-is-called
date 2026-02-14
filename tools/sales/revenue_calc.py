#!/usr/bin/env python3
from pathlib import Path
import csv

ROOT = Path(__file__).resolve().parents[2]
sales_file = ROOT / 'product/sell-now/sales.csv'

if not sales_file.exists():
    sales_file.write_text('date,offer,gross_usd,fee_usd,refund_usd,net_usd\n')
    print(f'created {sales_file}')
    raise SystemExit(0)

gross = fee = refund = net = 0.0
rows = 0
with sales_file.open() as f:
    r = csv.DictReader(f)
    for row in r:
        rows += 1
        gross += float(row.get('gross_usd', 0) or 0)
        fee += float(row.get('fee_usd', 0) or 0)
        refund += float(row.get('refund_usd', 0) or 0)
        n = row.get('net_usd')
        if n:
            net += float(n)
        else:
            net += float(row.get('gross_usd', 0) or 0) - float(row.get('fee_usd', 0) or 0) - float(row.get('refund_usd', 0) or 0)

print(f'rows={rows}')
print(f'gross_usd={gross:.2f}')
print(f'fee_usd={fee:.2f}')
print(f'refund_usd={refund:.2f}')
print(f'net_usd={net:.2f}')
