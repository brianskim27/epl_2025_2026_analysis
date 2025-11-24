# save as fbref_parse_file.py
import argparse, os, re, pandas as pd
from bs4 import BeautifulSoup, Comment

def slugify(s: str) -> str:
    s = re.sub(r'[\s/]+', '_', s.strip().lower())
    s = re.sub(r'[^a-z0-9_]+', '', s)
    return re.sub(r'_+', '_', s).strip('_')

def clean_columns(df: pd.DataFrame) -> pd.DataFrame:
    if isinstance(df.columns, pd.MultiIndex):
        df.columns = ['_'.join([c for c in t if c]).strip() for t in df.columns]
    df.columns = [slugify(str(c)) for c in df.columns]
    drop = [c for c in df.columns if c.startswith('unnamed') or c == '']
    return df.drop(columns=drop, errors='ignore')

def read_all_tables_from_html(html: str):
    out = []
    soup = BeautifulSoup(html, "lxml")

    # visible
    for table in soup.find_all("table"):
        cap = table.find("caption")
        name = slugify(cap.get_text(" ", strip=True)) if cap else "table"
        try:
            df = pd.read_html(str(table), flavor="lxml")[0]
            out.append((name, df))
        except ValueError:
            pass

    # commented (FBref hides many here)
    for c in soup.find_all(string=lambda t: isinstance(t, Comment)):
        block = str(c)
        if "<table" not in block:
            continue
        try:
            mini = BeautifulSoup(block, "lxml")
            caps = [cap.get_text(" ", strip=True) for cap in mini.find_all("caption")]
            for i, df in enumerate(pd.read_html(block, flavor="lxml")):
                name = slugify(caps[i]) if i < len(caps) and caps[i] else f"comment_table_{i}"
                out.append((name, df))
        except ValueError:
            continue
    return out

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--html", required=True, help="Path to saved FBref HTML file")
    ap.add_argument("--outdir", required=True, help="Output folder for CSVs")
    args = ap.parse_args()

    os.makedirs(args.outdir, exist_ok=True)
    html = open(args.html, "r", encoding="utf-8", errors="ignore").read()

    tables = read_all_tables_from_html(html)
    written = []
    for i, (name, df) in enumerate(tables):
        if df.empty: 
            continue
        # drop duplicated header rows in data
        for col in ("Player","Squad","Team"):
            if col in df.columns:
                df = df[df[col] != col]
        df = clean_columns(df)
        fname = f"{i:02d}_{name}.csv"
        fpath = os.path.join(args.outdir, fname)
        df.to_csv(fpath, index=False)
        written.append(fpath)

    print(f"Wrote {len(written)} tables")
    for p in written:
        print(" -", p)

if __name__ == "__main__":
    main()
