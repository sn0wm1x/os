[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

# kwaa/nixos

我的 Nix 配置，仅供参考。

## 特征

- Flakes
  - flake-parts (TODO)
- Disko + Impermanence
  - 基于 USB 密钥文件的 LUKS2 全盘加密
  - Btrfs, 强制 zstd:1 压缩，文件去重
- Wayland GTK4 桌面
  - GNOME 45+, PaperWM
  - niri (TODO)
- Nushell + Starship + carapace
- VR (TODO)
  - ALVR
  - Immersed (with wlr-randr?)
- Gaming (TODO)
  - fufexan/nix-gaming
  - Juvian-NixOS

<!-- ## Usage

###### Setup Cryptkey

```bash
sudo mkdir -p /key
lsblk && ls -l /dev/disk/by-id
sudo mount -n -t vfat -o rw /dev/disk/by-id/usb-Acer_USB_Flash_Drive_2235079219404-0:0-part1 /key
sudo dd if=/dev/random of=/key/nixos.key bs=8192 count=1
```

###### Partition & Format & Mount

```bash
cd /tmp
curl https://raw.githubusercontent.com/kwaa/nixos/main/hosts/bluestar/disko.nix -o /tmp/disko.nix
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix
```

###### Install

```bash
cd /etc
sudo nix --experimental-features "nix-command flakes" run nixpkgs#git -- clone https://github.com/kwaa/nixos.git
cd nixos
NIX_CONFIG="experimental-features = nix-command flakes" sudo nixos-install --flake .#bluestar --no-root-passwd
# sudo chmod -v 755 /mnt/etc/nixos
reboot
```

###### Move & Rebuild

```bash
# https://nixos.wiki/wiki/NixOS_configuration_editors#Editing_as_normal_user
cd ~
git clone https://github.com/kwaa/nixos.git .nixos
sudo nixos-rebuild switch --flake .#bluestar
sudo ln -s ~/.nixos/ /etc/nixos
```

## Useful links

- https://github.com/nix-community/disko/blob/master/docs/quickstart.md
- https://github.com/Misterio77/nix-starter-configs/tree/main/minimal -->

## Platforms

### NixOS

- [x] NixOS x86_64
- [ ] NixOS aarch64 (maybe)
- [ ] [Mobile NixOS](https://github.com/NixOS/mobile-nixos) (maybe)
- [ ] [NixOS on WSL2](https://github.com/nix-community/NixOS-WSL) (maybe)

### Nix

- [ ] [Nix on Droid](https://github.com/nix-community/nix-on-droid) (maybe)
