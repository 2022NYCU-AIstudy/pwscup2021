#!/bin/bash

source test-0config.sh

# 採樣，同時得到解答行號 e-a.csv
pytest main/attack_phase/begin/pick.py  $B  $X  $CT  $EA

