{
  config,
  options,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:
let
  cfg = config.sn0wm1x.baseline;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.sn0wm1x.baseline = {
    enable = lib.mkEnableOption "SN0WM1X baseline configurations";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      # https://wiki.cachyos.org/features/cachyos_settings/#memory-usage-tweaks
      kernelParams = [ "max_ptes_none=409" ];
      kernel.sysctl = {
        # https://wiki.archlinux.org/title/Sysctl#Improving_performance
        "net.core.netdev_max_backlog" = 16384;
        "net.core.default_qdisc" = "cake";
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.ipv4.tcp_rmem" = "4096 131072 16777216";
        "net.ipv4.tcp_wmem" = "4096 16384 16777216";
        # https://github.com/klzgrad/naiveproxy/wiki/Performance-Tuning
        "net.ipv4.tcp_slow_start_after_idle" = 0;
        # https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/sysctl.d/99-cachyos-settings.conf
        "vm.swappiness" = 100;
        "vm.vfs_cache_pressure" = 50;
        "vm.dirty_bytes" = 268435456;
        "vm.page-cluster" = 0;
        "vm.dirty_background_bytes" = 67108864;
        "vm.dirty_writeback_centisecs" = 1500;
        "kernel.nmi_watchdog" = 0;
        "kernel.unprivileged_userns_clone" = 1;
        "kernel.printk" = "3 3 3 3";
        "kernel.kptr_restrict" = 2;
        "kernel.kexec_load_disabled" = 1;
        "fs.file-max" = 2097152;
        # https://wiki.cachyos.org/configuration/general_system_tweaks/#disabling-split-lock-mitigate
        "kernel.split_lock_mitigate" = 0;
      };
      # https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/modprobe.d/blacklist.conf
      blacklistedKernelModules = [
        "iTCO_wdt"
        "sp5100_tco"
      ];
    };

    # sched-ext
    # https://wiki.cachyos.org/configuration/sched-ext/#lavd-autopilot--autopower
    services.scx = {
      enable = true;
      scheduler = "scx_lavd";
      extraArgs = [ "--autopower" ];
    };

    # https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/udev/rules.d/30-zram.rules
    services.udev.extraRules = ''
      ACTION=="change", \
      KERNEL=="zram0", \
      ATTR{initstate}=="1", \
      SYSCTL{vm.swappiness}="150"
    '';

    nix = {
      gc = {
        automatic = true;
        options = "--delete-older-than 14d";
        dates = "weekly";
      };
      settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        extra-substituters = [
          "https://sn0wm1x.cachix.org"
          # https://wiki.nixos.org/wiki/CUDA#Setting_up_CUDA_Binary_Cache
          "https://nix-community.cachix.org"
          # "https://nyx.chaotic.cx"
        ];
        extra-trusted-public-keys = [
          "sn0wm1x.cachix.org-1:osOGZnIhSALHVbNcjx9pJIcqNCieQp8I5asyf2IPZFc="
          # https://wiki.nixos.org/wiki/CUDA#Setting_up_CUDA_Binary_Cache
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          # "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
          # "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        ];
      };
    };

    # systemd
    # https://wiki.cachyos.org/features/cachyos_settings/#systemd-services-tweaks
    systemd = {
      user.extraConfig = "DefaultLimitNOFILE=1024:1048576";
      settings.Manager = {
        DefaultTimeoutStartSec = "15s";
        DefaultTimeoutStopSec = "10s";
        DefaultLimitNOFILE = "2048:2097152";
      };
    };

    # zram
    zramSwap.enable = true;
    zramSwap.memoryPercent = 100;

    # sudo-rs
    security.sudo.enable = false;
    security.sudo-rs.enable = true;
    security.sudo-rs.execWheelOnly = true;
    security.sudo-rs.wheelNeedsPassword = false;

    # NTP
    services.timesyncd.enable = false;
    services.ntpd-rs.enable = true;
    services.ntpd-rs.useNetworkingTimeServers = true;
    # https://wiki.nixos.org/wiki/NTP
    networking.timeServers = [ "ntp.felixc.at" ] ++ options.networking.timeServers.default;
    time.timeZone = lib.mkDefault "Asia/Taipei";

    # Networking
    services.resolved.enable = true;
    networking.networkmanager = lib.mkIf config.networking.networkmanager.enable {
      dns = "systemd-resolved";
      connectionConfig."connection.mdns" = 2;
      wifi.backend = lib.mkIf config.wireless.iwd.enable "iwd";
    };

    # https://wiki.cachyos.org/features/cachyos_settings/#memory-usage-tweaks
    services.journald.extraConfig = "SystemMaxUse=50M";

    # https://github.com/nix-community/nix-ld#installation
    programs.nix-ld.enable = true;

    users = {
      mutableUsers = false;
      users = {
        # FIXME: update password
        root.initialPassword = "correcthorsebatterystaple";
        kwa = {
          # FIXME: update password
          initialPassword = "correcthorsebatterystaple";
          isNormalUser = true;
          shell = pkgs.nushell;
          extraGroups = [
            "wheel"
            "video"
            "audio"
          ];

          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIApPwSaizmGRsjTbeFUuzAw/U1zHbVM4ybsN3iILi0mm openpgp:0x22222222" # 0x4444777733334444
          ];
        };
      };
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs outputs; };
      sharedModules = [ outputs.homeManagerModules.baseline ];
      users.kwa = {
        imports = [ ../../home/kwa ];
        sn0wm1x.baseline.enable = true;
      };
    };
  };
}
