# 2022 年 8月
* wsl2上のUbuntu22.04内にdockerをインストールし、さらにその上に仮想環境を構築する場合、後者の仮想環境上でcudaを認識させるには、[nvidia/cudaイメージ](https://hub.docker.com/r/nvidia/cuda/#!)を使用すると良いみたい。
* nvidia/cudaコンテナを使用するには、wsl2上のUbuntu22.04に[nvidia-docker2パッケージ](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)を事前にインストールしておく必要がある。
* nvidia-docker2パッケージをインストールする手順をまとめたシェルスクリプト `install-nvidia-docker2-on-wsl.sh` を作成した。
* nvidia/cuda コンテナを docker-compose から作成するには、いくつかのコマンドをcompose.yamlに追記する必要がある。
* [Compose における GPU アクセスの有効化](https://matsuand.github.io/docs.docker.jp.onthefly/compose/gpu-support/) を参考にコマンドを追加する。

# 2022 年 5月
* Docker Desktop の Linux 版が発表される。
* Docker Desktop は GUI にて操作するため、コマンドラインから操作を行うことが多いwsl2では、これまで通りDocker-cliを使用して環境構築を行うことになりそう。

# 2022 年 4月
* Ubuntu 22.04 が WSL で正式に利用可能になった。
* wsl-systemd というシェルスクリプトが同梱され、wsl上でも簡単に systemdを実行可能に。
* 『[WSL2+Ubuntu22.04に標準で入ったsystemdを試す](https://qiita.com/shigeokamoto/items/ca2211567771cf40a90d)』を参考に、Ubuntu22.04にてsystemdを実行確認。
* systemd 実行手順をまとめたシェルスクリプト `systemd-on-wsl.sh` を作成した。

# 2021 年 7月
* [このサイト](https://astherier.com/blog/2021/07/windows11-cuda-on-wsl2-setup/)を参考に、Windows 11のWSL2+Ubuntu 20.04環境にCUDAドライバやCUDAツールキットをインストールし、WSL2上でCUDAが動くようになった。
* インストール手順をまとめたシェルスクリプト `install-cuda-on-wsl.sh` を作成した。
