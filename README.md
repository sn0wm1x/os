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

<!-- ## Useful links

- https://github.com/nix-community/disko/blob/master/docs/quickstart.md
- https://github.com/Misterio77/nix-starter-configs/tree/main/minimal
- https://github.com/Misterio77/nix-config -->

## Platforms

### NixOS

- [x] NixOS x86_64
- [ ] NixOS aarch64 (maybe)
- [ ] [Mobile NixOS](https://github.com/NixOS/mobile-nixos) (maybe)
- [ ] [NixOS on WSL2](https://github.com/nix-community/NixOS-WSL) (maybe)

### Nix

- [ ] [Nix on Droid](https://github.com/nix-community/nix-on-droid) (maybe)
