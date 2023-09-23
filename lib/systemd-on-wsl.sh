#!/bin/bash
# Copyright (c) 2021 astherier
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php
#
# systemd-on-wsl.sh
# wsl2のUbuntu22.04でsystemdを実行するためのスクリプト
# 最終更新: 2022/08/07
# https://qiita.com/shigeokamoto/items/ca2211567771cf40a90d

#Ubunut22.04で同梱されたsystemdのスクリプトを実行する
sudo /usr/libexec/wsl-systemd
# systemd を PID1 に移すためのバイナリを実行
/usr/libexec/nslogin