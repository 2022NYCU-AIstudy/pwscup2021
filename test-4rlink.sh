#!/bin/bash

source test-0config.sh

# 攻撃
pytest attack/${Team}/rlink.py $CT  $D  $E

# 安全性評價
pytest main/attack_phase/mark/lmark.py  $EA  $E
