#!/usr/bin/env python3
import csv
import os
import shlex
import subprocess
from pathlib import Path
from datetime import datetime

ROOT = Path('/home/r/Desktop/what-happens-when-open-is-called')
CSV_PATH = ROOT / 'kernel/user/stage3/planning/STAGE3_DRIVER_PAIR_MATRIX.csv'
SUMMARY = ROOT / 'kernel/user/stage3/planning/STAGE3_FULL_TEST_SUMMARY.md'
SUMMARY_CSV = ROOT / 'kernel/user/stage3/planning/STAGE3_FULL_TEST_SUMMARY.csv'
SUDO_PASS = '1\n'


def run(cmd, cwd=None, check=False, timeout=None):
    p = subprocess.run(cmd, cwd=cwd, text=True, input=None, capture_output=True, timeout=timeout)
    if check and p.returncode != 0:
        raise RuntimeError(f"cmd failed: {' '.join(cmd)}\n{p.stdout}\n{p.stderr}")
    return p


def run_shell(cmd, check=False, timeout=None):
    p = subprocess.run(cmd, shell=True, text=True, capture_output=True, timeout=timeout)
    if check and p.returncode != 0:
        raise RuntimeError(f"cmd failed: {cmd}\n{p.stdout}\n{p.stderr}")
    return p


def sudo_cmd(args, check=False):
    p = subprocess.run(['sudo', '-S'] + args, input=SUDO_PASS, text=True, capture_output=True)
    if check and p.returncode != 0:
        raise RuntimeError(f"sudo cmd failed: {' '.join(args)}\n{p.stdout}\n{p.stderr}")
    return p


def detect_binary(src: Path):
    stem = src.stem
    cands = [src.with_suffix('.out'), src.parent / stem]
    if stem == 'user_trigger_raw_openat':
        cands.insert(0, src.parent / 'openat_raw')
    for c in cands:
        if c.exists() and os.access(c, os.X_OK):
            return c, 'existing'
    if src.suffix == '.c':
        out = src.parent / f"{stem}.auto.out"
        cmd = ['gcc', '-O2', '-Wall', '-Wextra', '-o', str(out), str(src), '-pthread']
        p = run(cmd)
        if p.returncode == 0 and out.exists():
            out.chmod(0o755)
            return out, 'compiled'
        return None, f"compile_failed: {p.stderr.strip()[:200]}"
    return None, 'no_runnable_binary'


def write_report(path: Path, data: dict):
    path.parent.mkdir(parents=True, exist_ok=True)
    txt = []
    txt.append(f"# Trace Report: {Path(data['userspace']).name}")
    txt.append("")
    txt.append(f"- Userspace source: `{data['userspace']}`")
    txt.append(f"- Driver source: `{data['driver_src']}`")
    txt.append(f"- Module: `{data['module']}`")
    txt.append(f"- Binary: `{data.get('binary','<none>')}`")
    txt.append(f"- Run timestamp: `{data['ts']}`")
    txt.append(f"- Final status: `{data['status']}`")
    txt.append("")
    txt.append("## Probe Counts")
    txt.append(f"- do_filp_open.entry: {data.get('cnt_filp_entry',0)}")
    txt.append(f"- do_filp_open.ret: {data.get('cnt_filp_ret',0)}")
    txt.append(f"- __d_alloc.entry: {data.get('cnt_dalloc_entry',0)}")
    txt.append(f"- __d_alloc.ret: {data.get('cnt_dalloc_ret',0)}")
    txt.append("")
    txt.append("## Return Signature Counts")
    txt.append(f"- ERR_PTR(-ENOENT) observed (fffffffffffffffe): {data.get('cnt_enoent_ptr',0)}")
    txt.append(f"- Non-error pointer returns observed: {data.get('cnt_nonerr_ptr',0)}")
    txt.append("")
    txt.append("## Commands")
    txt.append("```bash")
    for c in data.get('commands', []):
        txt.append(c)
    txt.append("```")
    txt.append("")
    if data.get('error'):
        txt.append("## Error")
        txt.append(f"`{data['error']}`")
        txt.append("")
    txt.append(f"## Dmesg")
    txt.append(f"`{data['dmesg_file']}`")
    path.write_text('\n'.join(txt) + '\n')


rows = list(csv.DictReader(CSV_PATH.open()))
results = []

for i, r in enumerate(rows, 1):
    userspace = ROOT / r['userspace_source']
    driver_src = ROOT / r['dedicated_driver_target']
    report_path = ROOT / r['report_target']
    driver_dir = driver_src.parent
    module = driver_src.stem
    ts = datetime.now().isoformat(timespec='seconds')

    data = {
        'index': i,
        'userspace': str(userspace.relative_to(ROOT)),
        'driver_src': str(driver_src.relative_to(ROOT)),
        'module': module,
        'report': str(report_path.relative_to(ROOT)),
        'ts': ts,
        'status': 'not_started',
        'commands': [],
        'dmesg_file': str(report_path.with_name(report_path.stem.replace('_trace_report', '_dmesg') + '.txt').relative_to(ROOT)),
    }

    dmesg_path = ROOT / data['dmesg_file']
    dmesg_path.parent.mkdir(parents=True, exist_ok=True)

    try:
        if not driver_src.exists():
            data['status'] = 'fail_driver_missing'
            data['error'] = 'driver source missing'
            write_report(report_path, data)
            results.append(data)
            continue

        p = run(['make', '-C', str(driver_dir)])
        data['commands'].append(f"make -C {driver_dir.relative_to(ROOT)}")
        if p.returncode != 0:
            data['status'] = 'fail_driver_build'
            data['error'] = (p.stderr or p.stdout)[-600:]
            write_report(report_path, data)
            results.append(data)
            continue

        binary, bstate = detect_binary(userspace)
        if not binary:
            data['status'] = 'fail_user_binary'
            data['error'] = bstate
            write_report(report_path, data)
            results.append(data)
            continue

        data['binary'] = str(binary.relative_to(ROOT))
        data['commands'].append(f"{data['binary']}")

        # clear dmesg for clean capture
        sudo_cmd(['dmesg', '-C'])
        data['commands'].append('sudo dmesg -C')

        target_comm = binary.name[:15]
        ko = driver_dir / f"{module}.ko"

        p_ins = sudo_cmd(['insmod', str(ko), f"target_comm={target_comm}"])
        data['commands'].append(f"sudo insmod {ko.relative_to(ROOT)} target_comm=\"{target_comm}\"")
        if p_ins.returncode != 0:
            data['status'] = 'fail_insmod'
            data['error'] = (p_ins.stderr or p_ins.stdout)[-600:]
            write_report(report_path, data)
            results.append(data)
            continue

        # run userspace
        run_rc = None
        run_err = None
        try:
            p_run = run([str(binary)], timeout=12)
            run_rc = p_run.returncode
        except subprocess.TimeoutExpired:
            run_rc = 124
            run_err = 'timeout'

        data['user_rc'] = run_rc
        if run_err:
            data['error'] = run_err

        # collect dmesg and unload
        p_dm = sudo_cmd(['dmesg'])
        logs = p_dm.stdout
        filt = []
        tag = f"[{module}]"
        for line in logs.splitlines():
            if tag in line:
                filt.append(line)
        dmesg_path.write_text('\n'.join(filt) + ('\n' if filt else ''))

        sudo_cmd(['rmmod', module])
        data['commands'].append(f"sudo rmmod {module}")

        text = '\n'.join(filt)
        data['cnt_filp_entry'] = text.count('do_filp_open.entry')
        data['cnt_filp_ret'] = text.count('do_filp_open.ret')
        data['cnt_dalloc_entry'] = text.count('__d_alloc.entry')
        data['cnt_dalloc_ret'] = text.count('__d_alloc.ret')
        data['cnt_enoent_ptr'] = text.count('ret=fffffffffffffffe')

        nonerr = 0
        for line in filt:
            if 'do_filp_open.ret' in line and 'ret=' in line and 'ret=fffffffffffffffe' not in line:
                nonerr += 1
        data['cnt_nonerr_ptr'] = nonerr

        if data['cnt_filp_entry'] > 0 and data['cnt_filp_ret'] > 0:
            data['status'] = 'pass_probe_hits'
        else:
            data['status'] = 'partial_no_filp_hits'

    except Exception as e:
        data['status'] = 'exception'
        data['error'] = str(e)[:600]

    write_report(report_path, data)
    results.append(data)

# write summary
with SUMMARY_CSV.open('w') as f:
    f.write('index,userspace,driver,module,binary,status,user_rc,filp_entry,filp_ret,dalloc_entry,dalloc_ret,enoent_ptr,nonerr_ptr,report,dmesg\n')
    for d in results:
        f.write(','.join([
            str(d.get('index','')),
            d.get('userspace',''),
            d.get('driver_src',''),
            d.get('module',''),
            d.get('binary',''),
            d.get('status',''),
            str(d.get('user_rc','')),
            str(d.get('cnt_filp_entry',0)),
            str(d.get('cnt_filp_ret',0)),
            str(d.get('cnt_dalloc_entry',0)),
            str(d.get('cnt_dalloc_ret',0)),
            str(d.get('cnt_enoent_ptr',0)),
            str(d.get('cnt_nonerr_ptr',0)),
            d.get('report',''),
            d.get('dmesg_file',''),
        ]) + '\n')

ok = sum(1 for d in results if d['status']=='pass_probe_hits')
partial = sum(1 for d in results if d['status'].startswith('partial'))
fail = len(results) - ok - partial

with SUMMARY.open('w') as f:
    f.write('# Stage3 Full Test Summary\n\n')
    f.write(f'- Total pairs: {len(results)}\n')
    f.write(f'- pass_probe_hits: {ok}\n')
    f.write(f'- partial: {partial}\n')
    f.write(f'- fail/exception: {fail}\n\n')
    f.write('## Per pair\n\n')
    for d in results:
        f.write(f"- {d['index']}. `{d['userspace']}` -> `{d['status']}` | filp={d.get('cnt_filp_entry',0)}/{d.get('cnt_filp_ret',0)} dalloc={d.get('cnt_dalloc_entry',0)}/{d.get('cnt_dalloc_ret',0)} | report `{d['report']}`\n")

print(f"DONE total={len(results)} pass={ok} partial={partial} fail={fail}")
