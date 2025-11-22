import pandas as pd, pathlib, re

raw_dir = pathlib.Path("raw_data")
clean_dir = pathlib.Path("cleaned_data")
clean_dir.mkdir(exist_ok=True)

def clean_columns(df):
    df.columns = [re.sub(r'\W+', '_', c.strip().lower()) for c in df.columns]
    return df

for f in raw_dir.glob("*.csv"):
    df = pd.read_csv(f)
    df = clean_columns(df)
    # drop empty unnamed columns
    df = df.loc[:, ~df.columns.str.contains('unnamed')]
    # fill missing squad names (if any)
    if 'squad' in df.columns:
        df['squad'] = df['squad'].fillna(method='ffill')
    # save with simpler name
    newname = f.name.split("_table")[0].replace("_20252026","").replace("premier_league","team")
    out = clean_dir / (newname + ".csv")
    df.to_csv(out, index=False)
    print(f"Cleaned {f.name} → {out.name}")
