# wrote by Hiroaki Kikuchi, 2021
import pandas as pd
import sys

if len(sys.argv) == 1:
    print(sys.argv[0], 'input.csv  exclude.csv [left.csv] [e-left.csv]')
    sys.exit(0)
   # 從輸入input.csv裡剃除掉exclude.csv寫入的行號，輸出剩餘資料left.csv和剩餘行號e-left.csv

df = pd.read_csv(sys.argv[1], header=None)
ex = pd.read_csv(sys.argv[2], header=None)
out = sys.argv[3] if len(sys.argv) >= 4 else sys.stdout
df2 = df.drop(ex[0])
df2.to_csv(out, index=None, header=None)
if len(sys.argv) >= 5:
    df2.index.to_series().to_csv(sys.argv[4], index=None, header=None)
