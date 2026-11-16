# [Blue Planet](https://youtu.be/-2KzcaiyBFo)

台式机

## 准备安装

以 UEFI 模式启动 NixOS 安装介质，启用 TPM 2.0 并连接网络。

```bash
# 克隆配置
cd /tmp
nix --extra-experimental-features 'nix-command flakes' run nixpkgs#git -- clone https://github.com/sn0wm1x/os.git
cd os
```

## 进行分区

使用 [Disko](https://github.com/nix-community/disko) 分区并挂载。创建 LUKS 时输入临时口令。

```bash
sudo nix --extra-experimental-features 'nix-command flakes' run github:nix-community/disko -- --mode disko --flake .#blueplanet
```

## 安装系统

```bash
sudo nixos-install --no-root-passwd --flake .#blueplanet --extra-experimental-features 'nix-command flakes'
```

安装完成后，注册 TPM 并移除临时口令槽：

```bash
sudo systemd-cryptenroll --tpm2-device=auto --wipe-slot=password /dev/disk/by-partlabel/disk-main-luks
reboot
```

## 迁移配置

重启后 `/etc/nixos` 会丢失，只需重新克隆到用户文件夹。

```bash
# 创建用户文件夹
sudo mkdir -p /persist/home/kwa
# 设置文件夹权限
sudo chown -R kwa /persist/home/kwa
# 克隆到 ~/.os
cd ~ && git clone https://github.com/sn0wm1x/os.git .os
# 重建系统
just rebuild
```
