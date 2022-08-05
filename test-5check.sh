#!/bin/bash

source test-0config.sh

# 去識別化資料(D, X)的格式檢查
pytest main/anony_phase/check/checkDX.py $B $D $X

# 攻擊資料(E)的格式檢查
pytest main/attack_phase/check/checkE.py $B $E
