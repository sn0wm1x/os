# [Akahitoha](https://youtu.be/G-qkOhDNfq0)

ThinkBook 14 G6+ AHP

- CPU: AMD Ryzen 7 8845H
- GPU: AMD Radeon 780M Graphics
- RAM: 32GB LPDDR5X-7500
- DISK 0: SK hynix BC901 1TB

## 准备密钥

akahitoha 默认全盘加密，使用密钥文件启动。

```bash
# 新建文件夹
sudo mkdir -p /key
# 挂载 primary_key
sudo mount -n -t vfat -o rw ${primary_key} /key
# 在挂载目录下创建 os.key 文件，如已有则跳过
sudo dd if=/dev/random of=/key/os.key bs=8192 count=1
```

注意将 `os.key` 密钥文件复制到备用设备 `backup_key`，以免存储设备损坏导致无法启动系统。

## 进行分区

akahitoha 使用 [Disko](https://github.com/nix-community/disko) 进行分区，分区前需确认密钥已挂载。

```bash
# 移动到暂存目录并下载 disko 配置
cd /tmp && curl https://raw.githubusercontent.com/sn0wm1x/os/main/hosts/akahitoha/disko.nix -o /tmp/disko.nix
# 分区并挂载
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix
```

## 安装系统

```bash
# 创建 /mnt/etc 目录
cd /mnt && sudo mkdir etc && cd etc
# 克隆此仓库
sudo nix --experimental-features "nix-command flakes" run nixpkgs#git -- clone https://github.com/sn0wm1x/os.git nixos
# 进入目录并删除 .git 文件夹
cd nixos && sudo rm -rf .git
# 安装系统
NIX_CONFIG="experimental-features = nix-command flakes" sudo nixos-install --no-root-passwd --flake .#akahitoha
# 重启
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
