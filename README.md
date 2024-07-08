<br />
<div align="center">
<img src="https://github.com/sn0wm1x.png" alt="sn0wm1x" />
</div>

<h1 align="center">SN0WM1X (Nix) OS</h1>

<div align="center">

**[<kbd> <br> Home <br> </kbd>](/home/)** 
**[<kbd> <br> Hosts <br> </kbd>](/hosts/)** 
**[<kbd> <br> Overlays <br> </kbd>](/overlays/)** 
**[<kbd> <br> Packages <br> </kbd>](/pkgs/)**

</div>

---

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

我的 Nix 配置，仅供参考。

## 特征

- Flakes
  - [nixos-flake](https://github.com/srid/nixos-flake) + [flake-parts](https://github.com/hercules-ci/flake-parts) (TODO)
- Disko + Impermanence
  - 基于 USB 密钥文件的 LUKS2 全盘加密
  - Btrfs, 强制 zstd:1 压缩，文件去重
- Wayland GTK4 桌面
  - GNOME 46+, PaperWM
  - Catppuccin Frappe
  - niri (TODO)
- 性能调优
  - linux-xanmod
  - system76-scheduler
  - linux-cachyos (TODO)
  - bore-scheduler (TODO)
- Nushell + Starship + Carapace
- Gaming (TODO)
  - fufexan/nix-gaming
  - Juvian-NixOS
- VR (TODO)
  - ALVR
  - WiVRn

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
