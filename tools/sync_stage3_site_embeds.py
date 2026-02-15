#!/usr/bin/env python3
import csv
import os
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SITE_STAGE3 = ROOT / "site" / "articles" / "stage3"
FOLDER_MATRIX = ROOT / "kernel" / "user" / "stage3" / "planning" / "STAGE3_FOLDER_TRACE_MATRIX.csv"

AUTO_START = "<!-- AUTO-EMBED START -->"
AUTO_END = "<!-- AUTO-EMBED END -->"


def read_text(p: Path) -> str:
    return p.read_text(encoding="utf-8", errors="replace")


def write_text(p: Path, s: str) -> None:
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(s, encoding="utf-8")


def replace_auto_block(dst: Path, block: str) -> None:
    old = read_text(dst) if dst.exists() else ""
    if AUTO_START in old and AUTO_END in old:
        pre, rest = old.split(AUTO_START, 1)
        _, post = rest.split(AUTO_END, 1)
        new = pre.rstrip() + "\n\n" + AUTO_START + "\n" + block.rstrip() + "\n" + AUTO_END + "\n" + post.lstrip()
        write_text(dst, new)
        return

    # Append
    s = old.rstrip() + ("\n\n" if old.strip() else "")
    s += AUTO_START + "\n" + block.rstrip() + "\n" + AUTO_END + "\n"
    write_text(dst, s)


def sanitize_heading(s: str) -> str:
    # Keep it ASCII-ish and stable for our pre-wrapped renderer.
    return s.replace("\r\n", "\n").replace("\r", "\n")


def embed_file(path: Path, title: str) -> str:
    body = read_text(path)
    body = sanitize_heading(body)
    rel = path.relative_to(ROOT)
    return (
        f"\n================================================================================\n"
        f"[EMBED] {title}\n"
        f"[SOURCE] {rel}\n"
        f"================================================================================\n"
        f"{body.rstrip()}\n"
    )


def list_dir_files(d: Path, suffix: str) -> list[Path]:
    if not d.exists():
        return []
    return sorted([p for p in d.iterdir() if p.is_file() and p.name.endswith(suffix)])


def case_config():
    # Keep explicit mapping so embeds are predictable and do not explode in size.
    return {
        "case1": {
            "user_dirs": ["kernel/user/stage3/case1"],
            "embed_worksheets": [
                "case1_relative_worksheet.md",
                "demo_at_fdcwd_worksheet.md",
                "demo_o_path_worksheet.md",
                "demo_o_path_dir_worksheet.md",
            ],
            "embed_reports": ["case1_relative_trace_report.md"],
            "embed_dmesg": ["case1_relative_dmesg.txt"],
        },
        "case2": {"user_dirs": ["kernel/user/stage3/case2_deep_miss"]},
        "case3": {"user_dirs": ["kernel/user/stage3/case3_deep_hit"]},
        "case4": {"user_dirs": ["kernel/user/stage3/case4_create_flow"]},
        "case5": {"user_dirs": ["kernel/user/stage3/case5_mount_jump"]},
        "case6": {"user_dirs": ["kernel/user/stage3/case6_symlink_loop"]},
        "case7": {"user_dirs": ["kernel/user/stage3/case7_symlink_fast"]},
        "case8": {"user_dirs": ["kernel/user/stage3/case8_creation_proof"]},
        "case10": {"user_dirs": ["kernel/user/stage3/case10_rename_investigation"]},
        "case11": {"user_dirs": ["kernel/user/stage3/case11_bulk_rename"]},
        "case12": {"user_dirs": ["kernel/user/stage3/case12_harder_puzzle"]},
        "case13": {"user_dirs": ["kernel/user/stage3/case13_salt_avalanche"]},
        "case14": {"user_dirs": ["kernel/user/stage3/case14_symmetry_break"]},
        "case15": {"user_dirs": ["kernel/user/stage3/case15_deep_trace"]},
        "case16": {
            "user_dirs": [
                "kernel/user/stage3/case16_do_filp_open_trace",
                "kernel/user/stage3/case16_do_sys_openat2_trace",
            ],
        },
        "case17": {"user_dirs": ["kernel/user/stage3/case17_do_filp_open_deep_trace"]},
    }


def load_folder_matrix() -> dict[str, dict[str, str]]:
    if not FOLDER_MATRIX.exists():
        return {}
    out: dict[str, dict[str, str]] = {}
    with FOLDER_MATRIX.open(newline="") as f:
        r = csv.DictReader(f)
        for row in r:
            folder = (row.get("folder") or "").strip()
            if not folder:
                continue
            out[folder] = {k: (v or "").strip() for k, v in row.items()}
    return out


def parse_trace_report_counts(report_md: str) -> dict[str, int]:
    # Pull the stable counters we already emit in every *_trace_report.md.
    def pick_int(pat: str) -> int:
        m = re.search(pat, report_md)
        return int(m.group(1)) if m else 0

    return {
        "filp_entry": pick_int(r"do_filp_open\.entry:\s*(\d+)"),
        "filp_ret": pick_int(r"do_filp_open\.ret:\s*(\d+)"),
        "dalloc_entry": pick_int(r"__d_alloc\.entry:\s*(\d+)"),
        "dalloc_ret": pick_int(r"__d_alloc\.ret:\s*(\d+)"),
        "enoent_ptr": pick_int(r"ERR_PTR\(-ENOENT\).*:\s*(\d+)"),
        "nonerr_ptr": pick_int(r"Non-error pointer returns observed:\s*(\d+)"),
    }


def default_embed_lists(user_dir: Path) -> tuple[list[str], list[str], list[str]]:
    reports_dir = user_dir / "reports"
    worksheets_dir = user_dir / "worksheets"

    report_mds = [p.name for p in list_dir_files(reports_dir, "_trace_report.md")]
    dmesg_txts = [p.name for p in list_dir_files(reports_dir, "_dmesg.txt")]
    # base worksheets only
    ws_mds = [p.name for p in list_dir_files(worksheets_dir, "_worksheet.md")]
    return ws_mds, report_mds, dmesg_txts


def build_case_embed(case_id: str, cfg: dict) -> tuple[str, str, str, str]:
    # Keep this stable across builds; do not inject timestamps.
    proof_block = f"[AUTO] case={case_id}\n"
    worksheet_block = f"[AUTO] case={case_id}\n"
    explanation_block = f"[AUTO] case={case_id}\n"
    textbook_block = f"[AUTO] case={case_id}\n"

    folder_matrix = load_folder_matrix()

    for ud_rel in cfg["user_dirs"]:
        ud = ROOT / ud_rel
        ws_mds, report_mds, dmesg_txts = default_embed_lists(ud)

        # Overrides: allow caller to pin.
        if "embed_worksheets" in cfg and ud_rel == cfg["user_dirs"][0]:
            ws_mds = cfg["embed_worksheets"]
        if "embed_reports" in cfg and ud_rel == cfg["user_dirs"][0]:
            report_mds = cfg["embed_reports"]
        if "embed_dmesg" in cfg and ud_rel == cfg["user_dirs"][0]:
            dmesg_txts = cfg["embed_dmesg"]

        worksheet_block += f"\n[USERDIR] {ud_rel}\n"
        for w in ws_mds:
            p = ud / "worksheets" / w
            if p.exists():
                worksheet_block += embed_file(p, title=w)

        proof_block += f"\n[USERDIR] {ud_rel}\n"
        for r in report_mds:
            p = ud / "reports" / r
            if p.exists():
                proof_block += embed_file(p, title=r)
        for d in dmesg_txts:
            p = ud / "reports" / d
            if p.exists():
                proof_block += embed_file(p, title=d)

        # Explanation/Textbook: promote one "primary" report per userdir so E/T pages
        # can stand alone like Stage2, without making the reader jump to P/W panes.
        folder_key = ud.name  # e.g. case2_deep_miss
        mx = folder_matrix.get(folder_key, {})
        if mx:
            explanation_block += (
                f"\n[FOLDER] {folder_key}\n"
                f"[INTENT] {mx.get('intent','')}\n"
                f"[BASELINE_PROBES] {mx.get('baseline_probes','')}\n"
                f"[EXTRA_PROBES] {mx.get('extra_probes','')}\n"
                f"[EXPECTED_SIGNATURES] {mx.get('expected_signatures','')}\n"
            )
            textbook_block += (
                f"\n[FOLDER] {folder_key}\n"
                f"[INTENT] {mx.get('intent','')}\n"
            )

        # Pick first report as "primary".
        if report_mds:
            r0 = ud / "reports" / report_mds[0]
            if r0.exists():
                rep_txt = read_text(r0)
                counts = parse_trace_report_counts(rep_txt)
                explanation_block += embed_file(r0, title=f"{report_mds[0]} (primary)")
                textbook_block += (
                    f"\n[INVARIANTS] source={r0.relative_to(ROOT)}\n"
                    f"- filp_open entry={counts['filp_entry']} ret={counts['filp_ret']}\n"
                    f"- __d_alloc entry={counts['dalloc_entry']} ret={counts['dalloc_ret']}\n"
                    f"- ERR_PTR(-ENOENT) count={counts['enoent_ptr']}\n"
                    f"- non-error file* count={counts['nonerr_ptr']}\n"
                    f"- check: entry==ret (filp_open) => {1 if counts['filp_entry']==counts['filp_ret'] else 0}\n"
                    f"- check: entry==ret (__d_alloc) => {1 if counts['dalloc_entry']==counts['dalloc_ret'] else 0}\n"
                )

        if dmesg_txts:
            d0 = ud / "reports" / dmesg_txts[0]
            if d0.exists():
                explanation_block += embed_file(d0, title=f"{dmesg_txts[0]} (primary)")

        # Case17 extra proof artifacts: these are the “deep proof” not in /reports.
        if case_id == "case17" and ud_rel.endswith("case17_do_filp_open_deep_trace"):
            extra = [
                "DLOOKUP_REPLAY_RUN_LOG.txt",
                "REVERSE_FULL_TRACE_MISSING_FILE_CASE17_PSTREE.md",
                "DLOOKUP_CRITICAL_BLOCK_NUMERIC.md",
                "LOOKUP_OPEN_PSEUDODEBUG_TRACE_MISSING_FILE.md",
            ]
            for name in extra:
                p = ud / name
                if p.exists():
                    proof_block += embed_file(p, title=name)
                    explanation_block += embed_file(p, title=f"{name} (deep)")
                    textbook_block += f"\n[DEEP] {p.relative_to(ROOT)}\n"

    return worksheet_block, proof_block, explanation_block, textbook_block


def main() -> int:
    if not SITE_STAGE3.exists():
        print(f"site stage3 dir missing: {SITE_STAGE3}")
        return 2

    cfgs = case_config()
    for case_id, cfg in cfgs.items():
        case_dir = SITE_STAGE3 / case_id
        ws_md = case_dir / "worksheet.md"
        proof_md = case_dir / "proof.md"
        exp_md = case_dir / "explanation.md"
        tb_md = case_dir / "textbook.md"

        if not ws_md.exists() or not proof_md.exists():
            # Keep silent; stage3 index includes only certain cases.
            continue

        worksheet_block, proof_block, explanation_block, textbook_block = build_case_embed(case_id, cfg)
        replace_auto_block(ws_md, worksheet_block)
        replace_auto_block(proof_md, proof_block)
        if exp_md.exists():
            replace_auto_block(exp_md, explanation_block)
        if tb_md.exists():
            replace_auto_block(tb_md, textbook_block)

    # Fix case16 metadata drift: case16 is "filp_open + sys_openat2" but pages list only filp_open.
    case16_exp = SITE_STAGE3 / "case16" / "explanation.md"
    if case16_exp.exists():
        txt = read_text(case16_exp)
        if AUTO_START in txt and AUTO_END in txt:
            # leave user edits
            return 0
        add = (
            f"[AUTO] case16 also includes syscall-frontdoor path\n"
            f"- userspace root (sys_openat2 focus): `kernel/user/stage3/case16_do_sys_openat2_trace`\n"
            f"- driver root (sys_openat2 focus): `kernel/drivers/stage3/case16_do_sys_openat2_trace`\n"
        )
        replace_auto_block(case16_exp, add)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
