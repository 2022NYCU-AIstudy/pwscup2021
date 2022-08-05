# wrote by Hiroaki Kikuchi, 2021
import pandas as pd
import sys

seed = 100


def pick(df, x):
    dfC = df.drop(x)
    dfC[12] = range(dfC.shape[0])   # 調整行號
    df1 = df.loc[x, :].sample(n=50, random_state=seed)  # 反例50
    df2 = dfC.sample(n=50, random_state=seed)  # 正例50
    df3 = pd.concat([df1, df2.iloc[:, 0:12]])
    df3[12] = df2[12]   # C的相對行號
    df3.loc[df1.index, 12] = -1
    df3[12] = df3[12].astype(int)
    return df3.iloc[:, 0:12], df3.iloc[:, 12]


if __name__ == "__main__":
    if len(sys.argv) == 1:
        print(sys.argv[0], 'B.csv Ex.csv C.csv Ea.csv')
        sys.exit(0)
       # 從B的Ex(排除行)選50行，~Ex(保留行)選50行進行隨機採樣
       # 輸出：採樣的100行 C.csv 解答行號 Ea.csv

    df = pd.read_csv(sys.argv[1], header=None)
    ex = pd.read_csv(sys.argv[2], header=None, index_col=0)
    dfc, ea = pick(df, ex.index)

    dfc.sort_index().to_csv(sys.argv[3], header=None, index=None)
    ea.sort_index().to_csv(sys.argv[4], header=None, index=None)

'''
dfC = df.drop(ex.index)
dfC[12] = range(dfC.shape[0])   # 調整行號
df1 = df.loc[ex.index,:].sample(n = 50, random_state = seed)	# 反例50
df2 = dfC.sample(n = 50, random_state = seed)	# 正例50
df3 = pd.concat([df1,df2.iloc[:,0:12]])

df3.sort_index().to_csv(sys.argv[3], header=None, index = None)

df3[12] = df2[12]   # C的相對行號
df3.loc[df1.index,12] = -1 
df3[12] = df3[12].astype(int)
# df3.loc[df1.index,12] = -1 * df1.index 
df3[12].sort_index().to_csv(sys.argv[4], header=None, index = None)
'''
