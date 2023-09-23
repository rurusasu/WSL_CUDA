#!/bin/bash

# PCL installer
# WSL2のUbuntu側で行う PCL のセットアップスクリプト
# 最終更新: 2023/09/23

# Ubuntu へのDocker Engineのインストール方法
# https://docs.docker.com/engine/install/ubuntu/

echo '
============================================
Setup Windows subsystem for Linux on Docker!
============================================
'

#次のコマンドを実行して、競合するすべてのパッケージをアンインストールします。
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

# 必要なパッケージのインストール
sudo apt -y update && \
sudo apt -y upgrade && \
sudo apt -y install --no-install-recommends \
    ca-certificates \
    curl \
    gnupg

# Dockerリポジトリの証明書が信頼されていることを確認
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# OK の場合、パッケージで使用可能なリポジトリのリストにDockerリポジトリを追加
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get -y update

# パッケージを更新し、DockerとDockerCLIをインストール
sudo apt -y install --no-install-recommends \
     docker-ce \
     docker-ce-cli \
     containerd.io \
     docker-buildx-plugin \
     docker-compose-plugin
#sudo snap install docker

# Docker デーモンを起動
# sudo service docker start

# dockerという名前のDockerグループにユーザーを追加
sudo usermod -aG docker $USER