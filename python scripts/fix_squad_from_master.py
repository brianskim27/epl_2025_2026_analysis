# fix_squad_from_master.py (verbose)
from pathlib import Path
import pandas as pd

SRC = Path("cleaned_data")
OUT = Path("cleaned_data_official")
OUT.mkdir(exist_ok=True)

MASTER_FILE = SRC / "11_squad_standard_stats_team.csv"  # change if your master is named differently
MASTER_COL_CANDIDATES = ["Squad", "squad", "Team", "team"]

print(f"[info] Looking for files in: {SRC.resolve()}")
print(f"[info] Writing to:          {OUT.resolve()}")

if not MASTER_FILE.exists():
    raise SystemExit(f"[error] Could not find master file: {MASTER_FILE}")

m = pd.read_csv(MASTER_FILE, dtype=str)
print(f"[info] Master columns: {list(m.columns)}  (rows={len(m)})")
squad_col = next((c for c in m.columns if c in MASTER_COL_CANDIDATES), None)
if squad_col is None:
    raise SystemExit("[error] No 'Squad' column found in master CSV.")

master_squads = m[squad_col].astype(str).tolist()

files = sorted(SRC.glob("*_team.csv"))
if not files:
    raise SystemExit(f"[error] No *_team.csv files found in {SRC}")

for csv in files:
    print(f"[work] {csv.name}")
    df = pd.read_csv(csv, dtype=str)
    cols = [c.lower() for c in df.columns]
    has_squad = ("squad" in cols) or ("team" in cols)
    if has_squad:
        # normalize to 'squad' if needed
        rename_map = {}
        for c in df.columns:
            if c.lower() in ("squad", "team"):
                rename_map[c] = "squad"
        if rename_map:
            df = df.rename(columns=rename_map)
        out = OUT / csv.name
        df.to_csv(out, index=False)
        print(f"[kept] {csv.name} -> {out.name} (already had squad)")
        continue

    if len(df) != len(master_squads):
        raise SystemExit(f"[error] Row mismatch: {csv.name} has {len(df)} rows; master has {len(master_squads)}")

    df.insert(0, "squad", master_squads)
    out = OUT / csv.name
    df.to_csv(out, index=False)
    print(f"[fixed] {csv.name} -> {out.name}")

print("[done] Use files from cleaned_data_with_squad/ for import.")
