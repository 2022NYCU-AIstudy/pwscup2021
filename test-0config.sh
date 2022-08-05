#!/bin/bash

Team=00		# 自己隊伍的編號
You=00		# 攻擊方隊伍的編號
python=python3
Csv=Csv
B=anony/${Team}/$Csv/B.csv
C=anony/${Team}/$Csv/C.csv
X=anony/${Team}/$Csv/pre_anony_${Team}_x.csv
D=anony/${Team}/$Csv/pre_anony_${Team}_d.csv
CT=anony/${Team}/$Csv/pre_anony_${Team}_c.csv 
EA=anony/${Team}/$Csv/pre_anony_${Team}_ea.csv
E=attack/${You}/$Csv/pre_attack_${You}_from_${Team}.csv

pytest(){
	echo $*
	$python  $* 
}







