# Enchilada

a.k.a OnePlus 6

## 状态

- 使用 Mobile NixOS fork [(linyinfeng/mobile-nixos)](https://github.com/linyinfeng/mobile-nixos/tree/development)
- 使用本地的 `nixpkgs-gnome-mobile` fork [(gnome-mobile/)](gnome-mobile/)
  - https://github.com/chuangzhu/nixpkgs-gnome-mobile/pull/4
- home-manager-kwa 失败
- 亮度调节，蓝牙不可用
- 时间默认为 1970 年
  - TODO: 尝试回退到 systemd-timesyncd
- Firefox Mobile 配置损坏

## 准备

手机已解锁 bootloader，刷入最新 OxygenOS 或 postmarketOS

## 编译

> 需要一台 aarch64 或配置了 `boot.binfmt.emulatedSystems = [ "aarch64-linux" ];` 的 x86-64 NixOS 设备
>
> 避免使用 `nixpkgs.crossSystem.system` 或 `nixpkgs.{buildPlatform,hostPlatform}.system`，以免获取不到 https://cache.nixos.org 的缓存

```bash
just build-mobile

# 不使用 just
nom build .#nixosConfigurations.enchilada.config.mobile.outputs.android.android-fastboot-images

# 不使用 nix-output-monitor
nix build .#nixosConfigurations.enchilada.config.mobile.outputs.android.android-fastboot-images
```

## 安装

```bash
sudo fastboot flash --slot=all boot result/boot.img
sudo fastboot flash userdata result/system.img
sudo fastboot erase dtbo
sudo fastboot reboot
```

## 参考

- https://gist.github.com/chrisguida/54d890f2929f973f45a4e5c3e4f4ddeb
