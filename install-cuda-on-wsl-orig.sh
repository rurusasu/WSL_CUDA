#!/bin/bash
# Copyright (c) 2021 astherier
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php
#
#install-cuda-on-wsl.sh
#WSL2のUbuntu側で行うCUDA on WSLのセットアップスクリプト
#最終更新: 2021/07/17
#https://astherier.com/blog/2021/07/windows11-cuda-on-wsl2-setup/

#CUDAリポジトリ名(DISTRO)とインストールするパッケージ名(APT_INSTALL)を指定してください。
#リポジトリ名を変更した場合、パッケージ名は明示的にCUDAツールキットを指定してください。
#(wsl-ubuntu以外のリポジトリから「cuda」をインストールすると、ディスプレイドライバーまでインストールしようとしてしまうため)
export DISTRO=wsl-ubuntu
export APT_INSTALL=cuda
#export DISTRO=ubuntu2004
#export APT_INSTALL=cuda-toolkit-11-4

#CUDAリポジトリの登録
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/${DISTRO}/x86_64/7fa2af80.pub
echo "deb http://developer.download.nvidia.com/compute/cuda/repos/${DISTRO}/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list
wget https://developer.download.nvidia.com/compute/cuda/repos/${DISTRO}/x86_64/cuda-${DISTRO}.pin
sudo mv cuda-${DISTRO}.pin /etc/apt/preferences.d/cuda-repository-pin-600

#CUDAツールキットのインストール
sudo apt update && sudo apt -y upgrade
sudo apt install -y ${APT_INSTALL}

#環境変数の設定
cat << 'EOS' >> ~/.profile

#Added by install-cuda-on-wsl.sh
#Ref: https://astherier.com/blog/2021/07/windows11-cuda-on-wsl2-setup/
export PATH=/usr/local/cuda-11.4/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-11.4/lib64\
            ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
#Added: end

EOS

#サードパーティーライブラリのインストール（任意）
sudo apt install -y g++ freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev

#サンプルプログラムのビルド（任意）
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