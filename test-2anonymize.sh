#!/bin/bash

source test-0config.sh

# 第1去識別化: 適用top, bottom, k-匿名，目的為刪除列
pytest main/anony_phase/first-anony/top2.py $B 1_5 75_50 anony/${Team}/$Csv/e-top.csv
pytest main/anony_phase/first-anony/bottom2.py $B 1_5 22_20 anony/${Team}/$Csv/e-bot.csv
pytest main/anony_phase/first-anony/kanony2.py $B 7 2_3_4  anony/${Team}/$Csv/e-ka.csv

# 綑綁三個檔案的行號
$python main/anony_phase/first-anony/join.py anony/${Team}/$Csv/e-top.csv anony/${Team}/$Csv/e-bot.csv anony/${Team}/$Csv/e-ka.csv > $X
pytest main/anony_phase/first-anony/exclude.py $B $X $C anony/${Team}/$Csv/e-in2.csv

# 有用性評價，唯一率評價
pytest main/anony_phase/mark/umark.py $B $C
pytest main/anony_phase/mark/uniqrt.py  $C

# 第2去識別化: 使用rr, dp, quantify，不可刪除行
pytest main/anony_phase/second-anony/rr.py $C  0.9 anony/${Team}/$Csv/d-xrr2.csv  0_2_3_4_6_7_10
pytest main/anony_phase/second-anony/dp2.py anony/${Team}/$Csv/d-xrr2.csv 1_5 1.0_2.0 $D
pytest main/anony_phase/mark/umark.py $B $D

pytest main/anony_phase/mark/iloss.py $C $D


