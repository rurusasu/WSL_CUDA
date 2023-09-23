#!/bin/bash
# Copyright (c) 2021 astherier
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php
#
# install-nvidia-docker2-on-wsl.sh
# wsl2のUbuntu22.04にnvidia-docker2パッケージを実行するためのスクリプト。
# このスクリプトは、次の2つの条件が満たされた Ubuntu22.04で実行されることを前提とする。
# 1. install-cuda-on-wsl.sh が実行された後の環境である。
# 2. systemd-on-wsl.sh が実行された後の環境である。
# 最終更新: 2023/09/23
# REF: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker

# NVIDIA コンテナツールキットのセットアップ
# パッケージリポジトリとGPGキーを設定します。
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
    && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
    && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
        sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
        sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# パッケージ・リストを更新した後に、パッケージ (および依存関係) をインストールします。
sudo apt -y update && apt install --no-install-recommends -y \
  nvidia-docker2 \
  && apt clean \
  && rm -r /var/lib/apt/lists/*

#sudo nvidia-ctk runtime configure --runtime=docker

# デフォルトのランタイムを設定した後、Dockerデーモンを再起動してインストールを完了します。
sudo systemctl restart docker