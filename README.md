# README



### Requirement

- Python 3.6 
- Numpy
- pandas 1.1.5
- statsmodels v0.12.2

## Data

- [paper: Physical Activity Levels and Diabetes Prevalence in US Adults: Findings from NHANES 2015–2016](https://link.springer.com/content/pdf/10.1007/s13300-020-00817-x.pdf)
- [NHANES 2015-2016](https://wwwn.cdc.gov/nchs/nhanes/continuousnhanes/default.aspx?BeginYear=2015)


## Programs

### Dataset Generation

- `activ_diabet9_csv.py`: 

  ```
  python activ_diabet9_csv.py B.csv
  ```
  下載NHANES的XPT檔，通過與SEQN捆綁僅提取所需的列，計算平均活動量METs等數值，並輸出B.csv。(gh和mets在數據生成過程中會被使用到，但由於未在比賽中使用而後被清除為0。)

  | gen  | age  | race  | edu        | mar      | bmi  | dep  | pir  | gh   | mets | qm   | dia  |
  | ---- | ---- | ----- | ---------- | -------- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
  | Male | 62   | White | Graduate   | Married  | 27.8 | 0    | 0    | 0    | 0    | Q2   | 1    |
  | Male | 53   | White | HighSchool | Divorced | 30.8 | 0    | 1    | 0    | 0    | Q1   | 0    |
  | Male | 78   | White | HighSchool | Married  | 28.8 | 0    | 0    | 0    | 0    | Q3   | 1    |


### Statistics Analysis 

- `ccount.py`　Cross Count 交叉合計

  ```
  python ccount.py [輸入.csv (合計.csv)]
  ```

  用0-10列的值對11列(diabetes)進行合計。
  連續值的話，根據$19 \le age \le 80$, $15 \le bmi \le 70$​ 這樣的編碼進行合計。
  是否憂鬱症，是否貧困此類則用0.5作為基準，用0, 1置換來計算。
  輸出的第1列(cnt)為count（行數），第2列是比率（在全行中的占比)。

- `cor.py` covariance 共變異數矩陣

  ```
  cor.py [輸入.csv(共變異數矩陣.csv)]
  ```

  用0-10列的值對11列(diabetes)進行合計。
  離散値用One Hot編碼，值用dummy變數進行轉換。（例，第0列為，`0_Male`, `0_Female`這樣的可選組合，將Male標為(1,0), Female標為(0,1)）

  對B.csv則輸出30 x 30的共變異數矩陣。

- `odds6.py`　Odds Ratio 勝算比

  ```
  odds6.py B.csv D.csv
  ```

  原資料B.csv和去識別化資料D.csv 的各自對作為糖尿病(dia)的目標變數進行多重羅吉斯迴歸分析，算出對各因子的勝算比(OR)和P值(p-value)。 算出B和D的勝算比之差後輸出平均誤差與最大誤差。

- `diabets_or.py`　糖尿病的罹患風險 OR

  ```
  diabets_or.py [輸入.csv(OR.csv)]
  ```

  gen + age + race + edu + mar + bmi + dep + pir + qm作為自變數對目標變數糖尿病dia輸出羅吉斯回歸．係數Coef，勝算比OR，p値p-value。

- `activ_diabet_count.py`:算出交叉合計表，讀取diabetes.csv。

- `activ_diabet_sklearn.py`: 羅吉斯回歸1. 讀取diabetes.csv，用sklearn函式庫輸出OR．

- `activ_diabet_stats.py`: 羅吉斯回歸2. 讀取diabetes.csv，用statsmodels函式庫輸出OR和p值。
### Anonymizing
- `top2.py`  Top coding 

  ```
  top2.py [輸入.csv] 列list　閾值list [行號.csv]
  例) top2.py B.csv 1_5 75_50 e-top.csv
  ```

  輸出列中比閾值theta更大的行
	例)	1列(age)75歲以上、5列(bmi)50以上	

- `bottom2.py` Botom coding 

  ```
  bottom2.py [輸入.csv] 列list　閾值list [行號.csv]
  例) bottom2.py B.csv 1_5 22_20 e-bot.csv
  ```

	輸出 列中比閾值theta更小的行
	例)	1列(age)22歲以上、5列(bmi)20以上

- `kanony2.py` K-anonimity 

  ```
  kanony2.py [輸入.csv] k 列list [行號.csv]
  例)  kanony2.py B.csv 7 2_3_4  e-ka.csv
  ```

    將列作為準標識符，輸出 不滿足k-匿名的行
    例)	將第2列(人種)，第3列(學歷)，第2列(婚姻狀況)作為準標識符，把不滿足k =     7的k-匿名性的行號輸出到`e-ka.csv`

- join.py 

  ```
  join.py 行號檔案list > 綜合行號.csv
  ```

  用行號檔案list（任意個）指定綑綁複數的行號（去除重複）並輸出(只輸出）。與`sort e1.csv e2.csv e3.csv | uniq > e-x.csv`等價。

- exclude.py 

  ```
  exclude.py [輸入.csv] [排除行號.csv] [剩餘資料.csv] [剩餘行號.csv]
  例) exclude.py B.csv e-x.csv c-in.csv e-in.csv
  ```

  輸出從輸入`B.csv`裡被排除的行號`e-x.csv` 以外的剩餘資料`C-in.csv`。

- `rr.py` Randomized Response 

  ```
  rr.py C.csv p D.csv 列list
  例) rr.py $Csv/c-in.csv  0.9 d-xrr.csv  0_2_3_4_6_7_10
  ```

對輸入C中指定的列進行維持機率p的隨機化回答(在值域中用1-p的機率替換)
例)	0, 2, 3, 4, 6, 7, 10列全部用0.9的機率進行隨機化，輸入到`d-xrr.csv`

- `dp2.py` Differential Privacy

  ```
  dp2.py [輸入.csv] 列list εlist [加工檔案.csv]
  例) dp2.py d-xrr.csv 1_5 1.0_2.0 d-xrrdp.csv
  ```

  根據隱私成本為指定的列添加拉普拉斯噪聲   
  $$
  \frac{\epsilon}{2} e^{-\epsilon |x|}
  $$
  例)	根據1列(age)的ϵ = 1.0，5列(bmi)的ϵ = 2.0來添加噪音，因為sensitivity = 1，而對ϵ進行調整。

- quantify2.py 	後述

### Recode Linking

- Pick.py 測試資料的採樣

  ```
  pick.py B.csv Ex.csv C.csv Ea.csv
  例）pick.py B.csv e-x.csv c-100.csv e-a.csv
  ```

  從B的`E-x.csv` (排除行）採樣50行，Ex以外的保留行裡再採樣50行，輸出共100行的測試資料`C.csv`與正解的行號`e-a.csv`。

  |  B   |  Ex  |  C   |  Ea  |  D   |
  | :--: | :--: | :--: | :--: | :--: |
  |  0   |      |      |      |  0   |
  |  1   |      |      |      |  1   |
  |  2   |  2   |  ○   |  -1  |      |
  |  3   |      |  ●   |  2   |  2   |
  |  4   |      |  ●   |  3   |  3   |
  |  5   |  5   |      |      |      |
  |  6   |  6   |      |      |      |
  |  7   |      |      |      |  4   |
  |  8   |  8   |  ○   |  -1  |      |
  |  9   |      |      |      |  5   |

  以上為例．Ea為正解行．

- attack.py 根據Record linkage的Membership攻擊．構築並探索基於歐幾里得距離的KDTree(參照PWS Cup 2020)

- rlink.py 

  ```
  rlink.py  C.csv D.csv E.csv
  例)rlink.py c-100.csv d-xrrdp.csv e-100xrrdp.csv
  ```
  每一行測試資料C中，如果不屬於去識別化資料D，則為-1（非Membership）。如果屬於去則要以最有可能的前k(=3)位推測是第幾行，並輸出為E。將各列中大於中位數的行推斷為-1（要正好把50行標為-1）。至於資料間的距離使用經過One Hot編碼後的歐幾里得距離。不使用第8列(gh)和9(mets)。 
  
  | 1st  | 2nd  | 3rd  |
  | :--: | :--: | :--: |
  |  29  | 847  | 2599 |
  |  -1  |  -1  |  -1  |
  |  -1  |  -1  |  -1  |
  |  -1  |  -1  |  -1  |
  | 134  | 1820 | 2580 |
  | 138  | 967  | 2636 |
  |  -1  |  -1  |  -1  |
  
  推測C的2,3,4,7行不屬於D(從B裡被刪除）。第1行推測的第1候補為C的第29行，第2，第3候補各為第847, 2599行。



### 有用性評價 Utility Metirics 
- `umark.py`		**U**tlity bench**mark** 

  ```
  umark B.csv D.csv
  ```

  有用性評價。輸出B和D的交叉合計(cnt, rate), 勝算比(Coef,OR,pvalue), 共變異數cor的最大值與平均值．

  |      | cnt   | rate  | Coef  | OR    | pvalue | cor   |
  | ---- | ----- | ----- | ----- | ----- | ------ | ----- |
  | max  | 69    | 0.020 | 0.309 | 0.061 | 0.159  | 0.006 |
  | mean | 2.530 | 0.001 | 0.031 | 0.017 | 0.028  | 8E-05 |

- `Iloss.py` **I**nformation **Loss**

  ```
  iloss.py C.csv D.csv
  ```
  
  有用性評價。對C和D的行所對應之L1距離的最大值進行評估。(Max列的Max行的值)
  例）

	|      | 1    | 5    | cat  | Max  |
  | ---- | ---- | ---- | ---- | ---- |
  |mean |1.085297| 0.723084| 0.443483| 1.085297|
	|max  |8.000000| 4.400000| 4.000000| 8.000000|




### 安全性評價 Privacy Metrics 
- `lmark.py`　**L**inkage bench**mark** 

  ```
  lmark     Ea.csv  E.csv [out.csv]
  例) lmark.py e-a.csv e-100xrrdp.csv
  ```

  檢查正解行號Ea.csv 與推測行號E.csv，評估接下來的安全性 recall, precision, top-k。
  $$
  recall = \frac{|E_a \cap E|}{|E_a|}, \, prec = \frac{|E_a \cap E|}{|E|}, top_k = \frac{|\{x \in E_a| x \in E[x]\}|}{k}
  $$
  E_a 和E是`Ea.csv` 和`E.csv` 中的行號(＝沒被排除的行號）所形成的集合．$E[x]$​​ 是對應行x的推測行號的前k位之集合。
  
  

### 安全性評價 Unique Rate 

- `uniqrt.py`　**Uniq**ue Rate  

  ```
  uniqrt.py  B.csv C.csv
  例) uniqrt.py CSV/B.csv Csv/c-in.csv
  ```

  進行第一去識別化（刪除特異行）的資料C.csv中，評估唯一行的比例。對於連續值(age, bmi)四捨五入到最近的10。
  $$
  \begin{eqnarray}
  %unique_1(C) &=& \frac{|\{c_i \in C| \forall c_j \in C-\{c_i\}, c_i \ne c_j\}|}{|C|} \\
  unique_2(C) &=& \frac{|\{c_i \in C| \forall c_j \in C-\{c_i\}, c_i \ne c_j\}|}{|B|} \\
  \end{eqnarray}
  $$
  
  
  

### 格式檢查

- `checkDX.py`　
  加工階段的提出檔案(去識別化資料D, 排除行資料X)的格式檢查

  ```
  checkDX.py B.csv D.csv X.csv
  例）python3 checkDX.py Csv/B.csv Csv/d-xrrdp.csv Csv/e-x.csv 
  D: num OK
  D: obj OK
  0 OK
  2 OK
  3 OK
  4 OK
  10 OK
  (2724, 12) OK
  X: int OK
  X: unique OK
  (695, 1) OK
  ```

  對於D，

  1. 數值列(1,5,6,7,11)是否為整數或是實數
  2. 名義列(0,2,3,4,10)是否為Object
  3. 列1(年齢)，列5(BMI)的值域是否在[13, 85], [13, 75]，列6(憂鬱症)，列7(貧困), 列11(糖尿病)的值域是否為{0,1}．
  4. 列0 (性別)，列2(人種)，列3(學歷)，列4(婚姻狀態)，列10(活動量)是否在B.csv 的值域
  5. D的行數是否在$|B|/2 = 1709$以上，是否有12列。
  
  進行以上的檢查。對於X，
  
  1. 是否為整數型(int)
  2. 是否指定到重複的行
  3. 是否為$|X|_{行數}+|D|_{行數} = |B|_{行數}$​
  
  進行以上的檢查。全數OK即合格。
  
- `checkE.py`

  攻擊階段的提出檔案(推定行號資料E)的格式檢查

  ```
  checkE.py B.csv E.csv
  例） python3 checkE.py Csv/B.csv Csv/pre_attack_00_from_00.csv
  (100, 3) OK
  E: int OK
  E: max OK
  E: min OK
  ```

  對於推定行號，

  1. 是否為100行，3列的資料
  2. 全部的列是否為整數型(int)
  3. 全部的列是否在$-1 \le 推定行 \le n$​​ 的範圍內

  進行以上的檢查。全數OK即合格．



### 施行腳本

施行`bash 腳本名`。（在OS無法用sh的時候，只按順序執行腳本中的pytest部分）

1. `test-0config.sh` 自己的隊伍編號Team, 攻撃方隊伍編號You，python的路徑，設置生成檔案儲存目錄的csv等等。

2. `test-1setup.sh` 把衛生保健資料從CDC下載。最一開始運行即可。刪除所有文件需要幾秒鐘。

3. `test-2anonymize.sh` （去識別化階段）對加工進行有用性評價。Category_encoders會出現warning。rr, dp有隨機的要素存在，毎回結果會有差異．

     ```
     $ bash test-2anonymize.sh
     top2.py Csv/B.csv 1_5 75_50 Csv/e-top.csv
     bottom2.py Csv/B.csv 1_5 22_20 Csv/e-bot.csv
     kanony2.py Csv/B.csv 7 2_3_4 Csv/e-ka.csv
     exclude.py Csv/B.csv Csv/pre_anony_00_x.csv Csv2/C.csv Csv2/e-in2.csv
     umark.py Csv/B.csv Csv/C.csv
                  cnt      rate      Coef        OR    pvalue       cor
     max   519.000000  0.061190  0.749521  0.288657  0.383715  0.135895
     mean  114.106061  0.007815  0.101983  0.072791  0.086014  0.012597
     uniqrt.py Csv/C.csv
     2360 0.7038473009245452 0.5632458233890215
     rr.py Csv/C.csv 0.9 Csv/d-xrr2.csv 0_2_3_4_6_7_10
     dp2.py Csv/d-xrr2.csv 1_5 1.0_2.0 Csv2/pre_anony_00_d.csv
     umark.py Csv/B.csv Csv/pre_anony_00_d.csv
                  cnt      rate      Coef        OR    pvalue       cor
     max   596.000000  0.065067  0.385540  0.218689  0.455050  0.182816
     mean  114.606061  0.010027  0.102278  0.082985  0.129358  0.015871
     ```

4. `test-3pick.sh`　將評價資料從來自B的測試資料CT採樣出來，交給評審處理。

5. `test-4rlink.sh` （攻擊階段）進行membership推定與record link，輸出推定結果。

   ```
   $ bash test-4rlink.sh 
   rlink.py Csv/pre_anony_00_c.csv Csv/pre_anony_00_d.csv Csv/pre_attack_00_from_00.csv
   lmark.py Csv/pre_anony_00_ea.csv Csv/pre_attack_00_from_00.csv
   lmark.py Ea.csv E.csv out.csv
   recall    0.84
   prec      0.84
   topk      0.74
   dtype: float64
   ```

6. `test-5check.sh` 進行提出檔案(D, X, E)的格式檢查。全部都印出OK則合格。