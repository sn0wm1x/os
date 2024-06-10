[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

# sn0wm1x/os

我的 Nix 配置，仅供参考。

## 特征

- Flakes
  - flake-parts (TODO)
- Disko + Impermanence
  - 基于 USB 密钥文件的 LUKS2 全盘加密
  - Btrfs, 强制 zstd:1 压缩，文件去重
- Wayland GTK4 桌面
  - GNOME 46+, PaperWM
  - niri (TODO)
  - [nix-colors](https://github.com/Misterio77/nix-colors) with [flavours](https://github.com/Misterio77/flavours) (TODO)
- 性能调优
  - linux-xanmod
  - sched-ext (TODO)
- Nushell + Starship + carapace
- Gaming (TODO)
  - fufexan/nix-gaming
  - Juvian-NixOS
- VR (TODO)
  - ALVR
  - Immersed (with wlr-randr?)

<!-- ## Useful links

- https://github.com/nix-community/disko/blob/master/docs/quickstart.md
- https://github.com/Misterio77/nix-starter-configs/tree/main/minimal
- https://github.com/Misterio77/nix-config -->

## Platforms

### NixOS

- [x] NixOS x86_64
- [ ] NixOS aarch64 (maybe)
- [ ] [Mobile NixOS](https://github.com/NixOS/mobile-nixos) (maybe)
  - https://github.com/chuangzhu/nixpkgs-gnome-mobile
- [ ] [NixOS on WSL2](https://github.com/nix-community/NixOS-WSL) (maybe)

### Nix

- [ ] [Nix on Droid](https://github.com/nix-community/nix-on-droid) (maybe)
