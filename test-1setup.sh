#!/bin/bash

source test-0config.sh

test -d $Csv || mkdir $Csv

# 從CDC下載資料，耗時數秒
pytest main/anony_phase/begin/activ_diabet9_csv.py $B


