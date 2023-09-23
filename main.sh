#!/bin/bash
# Copyright (c) 2021 astherier
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php
#
# main.sh
# WSL 上で Docker を使用し、その上でCUDAを使用可能にする
# 環境を構築するスクリプト。
# 最終更新: 2023/09/23

# CUDA のインストール先
CUDA_DIR=/usr/local/cuda
# Dockerのインストール先
DOCKER_FILE=/usr/bin/docker

# インストール先に CUDA ディレクトリが存在しない場合
# インストールを実行
if [ ! -d $CUDA_DIR ]; then
    source ./lib/cuda/install-cuda-on-wsl.sh
fi

# 引数で指定されたファイルのパスを変数に代入
FILE=/etc/wsl.conf
# grepコマンドでファイル内にsystemd=trueという文字列があるか検索
# -qオプションで標準出力を抑制
grep -q "systemd=true" $FILE
# $?は直前のコマンドの終了ステータスを表す
# grepコマンドはマッチした場合は0、マッチしなかった場合は1を返す
if [ $? -eq 1 ]; then
    # マッチしなかった場合はコマンドを追加する。
    source ./lib/utils/systemd-on-wsl.sh
fi

# インストール先に Dockerファイルが存在しない場合
# インストールを実行
if [ ! -f $DOCKER_FILE ]; then
    source ./lib/docker/install-docker-on-wsl.sh
fi

# nvidia-docker2 をインストール
source ./lib/install-nvidia-docker2-on-wsl.sh

# テスト用のDockerImageを取得し
# DockerImage上でGPUが使用可能か確認
source ./lib/utils/EnvironmentConstructionVerification.sh