# [Blue Planet](https://youtu.be/-2KzcaiyBFo)

A770 推理服务器

## 基础系统

安装最新版 Ubuntu Server：

https://ubuntu.com/tutorials/install-ubuntu-server

## 安装 Nix

这里使用 [Determine Nix Installer](https://determinate.systems/nix-installer)：

```bash
# determine nix: no
# nix install plan: yes
curl -sSf -L https://install.determinate.systems/nix | sudo sh -s -- install
```

## 安装环境

```bash
# 克隆到 ~/.os
cd ~ && git clone https://github.com/sn0wm1x/os.git .os
# 激活配置
sudo -i
cd /home/kwa/.os
nix run 'github:numtide/system-manager' -- switch --flake '.#blueplanet'
```
