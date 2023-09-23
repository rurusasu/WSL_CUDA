#!/bin/bash
# Copyright (c) 2021 astherier
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php
#
# systemd-on-wsl.sh
# wsl2のUbuntu22.04でsystemdを実行するためのスクリプト
# 最終更新: 2023/0923

# Ubunut22.04で同梱されたsystemdのスクリプトを実行する
# REF: https://qiita.com/shigeokamoto/items/ca2211567771cf40a90d
#sudo /usr/libexec/wsl-systemd
# systemd を PID1 に移すためのバイナリを実行
#/usr/libexec/nslogin

# 引数で指定されたファイルのパスを変数に代入
FILE=/etc/wsl.conf

# WSLで systemd がサポートされる
# REF: https://learn.microsoft.com/ja-jp/windows/wsl/systemd
echo "[bool]" >> $FILE
echo "systemd=true" >> $FILE