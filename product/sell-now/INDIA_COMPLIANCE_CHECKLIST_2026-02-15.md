# India Compliance Checklist (Digital Products / Services)

Date baseline: **2026-02-15**
Scope: Indian resident selling digital trace packs + consulting sessions to India and overseas buyers.

## 1) Legality (Go/No-Go)
1. Selling digital products/services from India: **allowed**.
2. Use compliant payment channels (platform payout to bank).
3. Keep invoice + payment trail for every sale.

## 2) GST - Core Actions
1. Determine if GST registration is required for your facts (state, customer mix, threshold, place of supply).
2. If exporting services, apply zero-rated route correctly (LUT/bond or IGST+refund path).
3. Ensure export-of-services conditions are met before treating as zero-rated.
4. Keep GST invoices, LUT (if used), and filing acknowledgments.

## 3) Export-of-Services Checks (Per Invoice)
1. Supplier location = India.
2. Recipient location = outside India.
3. Place of supply = outside India.
4. Payment receipt condition satisfied (foreign exchange / INR where permitted under RBI framework).
5. Supplier and recipient are not merely distinct establishments of same person.

If any condition fails, do not auto-classify as export; evaluate domestic/interstate GST treatment.

## 4) FEMA / FX Realization Hygiene
1. Keep bank realization evidence for overseas receipts.
2. Track invoice date vs receipt date.
3. Follow AD bank requests for export/service reporting details.
4. Maintain IRM/FIRC-like evidence as provided by bank/payment flow.

## 5) Income Tax Hygiene
1. Classify receipts as business/professional income.
2. Keep expense records and platform fee records.
3. Evaluate presumptive scheme eligibility (44ADA/44AD where applicable).
4. Pay advance tax if applicable.
5. File return with reconciled books/payment statements.

## 6) Documents to Keep (Per Sale)
1. Invoice PDF
2. Customer country + tax classification note
3. Checkout/platform transaction ID
4. Bank credit proof / payout statement
5. GST treatment note (export/domestic logic)
6. Refund/chargeback record (if any)

## 7) Weekly Reconciliation Loop
1. Export `sales.csv` from your tracker.
2. Match each row with platform payout rows.
3. Match payout rows with bank credits.
4. Flag missing-doc rows and complete within 48h.

## 8) Monthly Compliance Loop
1. GST filings (as applicable) with reconciled sales buckets.
2. Income tax working update (receipts/expenses/advance tax).
3. Backup: invoices + ledgers + statements + filings (offline + cloud).

## 9) High-Risk Mistakes to Avoid
1. Marking all foreign clients as zero-rated without payment-condition checks.
2. Missing document trail for one-off service sessions.
3. No reconciliation between platform gross, fees, net, and bank credits.
4. Treating legal/tax thresholds as static forever.

## 10) Repo Integration (Already present)
1. Sales tracker: `product/sell-now/sales.csv`
2. Leads tracker: `product/sell-now/leads.csv`
3. Revenue calculator: `tools/sales/revenue_calc.py`
4. Sell playbook: `product/sell-now/START_SELLING_60_MIN.md`

## Official References (verify latest before filing)
1. CBIC IGST Act text (zero-rated supply, export framework):
   - https://cbic-gst.gov.in/hindi/IGST-bill-e.html
2. CBIC Sectoral FAQ (export of services practical points):
   - https://cbic-gst.gov.in/hindi/sectoral-faq.html
3. RBI Master Direction - Export of Goods and Services (updated listing):
   - https://systemhealth.rbi.org.in/Scripts/BS_ViewMasterDirections.aspx.html
   - https://systemhealth.rbi.org.in/Scripts/BS_ViewMasDirections.aspx_id%3D10395%283%29.html
4. Income Tax Act Section 44ADA (official text):
   - https://incometaxindia.gov.in/Acts/Income-tax%20Act%2C%201961/2021/102120000000076872.htm

## Operational Note
Use this as implementation checklist, not final legal opinion. Before first large payout cycle, get one CA review and lock your GST/FEMA/tax treatment template.
