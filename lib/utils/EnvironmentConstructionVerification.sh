#!/bin/bash
# Copyright (c) 2021 astherier
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php
#
# EnvironmentConstructionVerification
# 構築した環境の検証を行うモジュール
# 最終更新: 2023/09/23

# DockerをつかったGPUベンチマーク
# REF: https://zenn.dev/usagi1975/articles/2023-02-18-1400_docker-gpu-bench

docker run --rm --gpus all nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -gpu -benchmark -numbodies=640000

