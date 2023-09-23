#!/bin/bash
# Copyright (c) 2021 astherier
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php
#
# install-cuda-on-wsl.sh
# WSL2のUbuntu側で行うCUDA on WSLのセットアップスクリプト
# 最終更新：2023/08/14
# https://astherier.com/blog/2021/07/windows11-cuda-on-wsl2-setup/

# CUDAリポジトリ名(DISTRO)とインストールするパッケージ名(APT_INSTALL)を指定してください。
# リポジトリ名を変更した場合、パッケージ名は明示的にCUDAツールキットを指定してください。
# (wsl-ubuntu以外のリポジトリから「cuda」をインストールすると、ディスプレイドライバーまでインストールしようとしてしまうため)
export DISTRO=wsl-ubuntu
export APT_INSTALL=cuda
export CUDA_VERSION_MAJOR=12
export CUDA_VERSION_MINOR=2

echo '
============================================
Setup Windows subsystem for Linux on CUDA!
============================================
'

# CUDAリポジトリの登録
# Origファイルより更新(NVIDIAのサイト準拠に変更)
# https://docs.nvidia.com/cuda/wsl-user-guide/index.html
rm -r /tmp/cuda/*
wget https://developer.download.nvidia.com/compute/cuda/repos/${DISTRO}/x86_64/cuda-keyring_1.1-1_all.deb -O /tmp/cuda
cd /tmp/cuda/
sudo dpkg -i cuda-keyring_1.1-1_all.deb

# CUDAツールキットのインストール
sudo apt update && sudo apt -y upgrade
sudo apt install -y ${APT_INSTALL}

# 環境変数の設定
cat << 'EOS' >> ~/.profile

#Added by install-cuda-on-wsl.sh
#Ref: https://astherier.com/blog/2021/07/windows11-cuda-on-wsl2-setup/
export PATH=/usr/local/cuda-${CUDA_VERSION_MAJOR}.${CUDA_VERSION_MINOR}/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-${CUDA_VERSION_MAJOR}.${CUDA_VERSION_MINOR}/lib64\
            ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
#Added: end

EOS

# debファイルの削除
sudo rm cuda-keyring_1.1-1_all.deb

# サードパーティーライブラリのインストール（任意）
sudo apt install -y g++ freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev

# サンプルプログラムのビルド（任意）
cd /usr/local/cuda/samples/1_Utilities/deviceQuery/
sudo make
cd /usr/local/cuda/samples/1_Utilities/bandwidthTest/
sudo make
cd /usr/local/cuda/samples/7_CUDALibraries/simpleCUBLAS/
sudo make
cd /usr/local/cuda/samples/7_CUDALibraries/simpleCUFFT/
sudo make

cd /usr/local/cuda/samples/bin/x86_64/linux/release/

echo "

CUDA on WSLのセットアップが終了しました。
いくつかサンプルをコンパイルしていますので、正常に動くか確認してください。
（例）
$ cd /usr/local/cuda/samples/bin/x86_64/linux/release/
$ ./deviceQuery

"