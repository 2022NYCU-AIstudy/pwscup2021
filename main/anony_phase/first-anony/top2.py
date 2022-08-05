# wrote by Hiroaki Kikuchi, 2021
import pandas as pd
import sys

if __name__ == "__main__":
    if len(sys.argv) != 5:
        print(sys.argv[0], ' diabetes.csv  col  theta  [ex.csv]')
        # sys.exit(0)
        # top coding - 輸出比列col的閾值theta更大的行

    df = pd.read_csv(sys.argv[1], header=None)
    cols = sys.argv[2].split('_')
    thetas = sys.argv[3].split('_')
    out = sys.argv[4] if len(sys.argv) == 5 else sys.stdout
    ex = df[0] == None
    for i in range(len(cols)):
        x = df.loc[:, int(cols[i])]
        ex |= x > int(thetas[i])
    ex = ex[ex].index.to_series()
    ex.to_csv(out, index=None, header=None)
