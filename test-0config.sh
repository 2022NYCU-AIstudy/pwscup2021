#!/bin/bash

Team=00		# 自己隊伍的編號
You=00		# 攻擊方隊伍的編號
python=python3
Csv=Csv
B=$Csv/B.csv
C=$Csv/C.csv
X=$Csv/pre_anony_${Team}_x.csv
D=$Csv/pre_anony_${Team}_d.csv
CT=$Csv/pre_anony_${Team}_c.csv 
EA=$Csv/pre_anony_${Team}_ea.csv
E=$Csv/pre_attack_${You}_from_${Team}.csv

pytest(){
	echo $*
	$python  $* 
}







