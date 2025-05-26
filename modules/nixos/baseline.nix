{
  config,
  options,
  lib,
  ...
}:
let
  cfg = config.sn0wm1x.baseline;
in
with lib;
{
  options.sn0wm1x.baseline = {
    enable = mkEnableOption "SN0WM1X baseline configurations";
  };
  config = lib.mkIf cfg.enable {
    boot = {
      kernel.sysctl = {
        # https://wiki.archlinux.org/title/Sysctl#Improving_performance
        "net.core.netdev_max_backlog" = 16384;
        "net.core.default_qdisc" = "cake";
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.ipv4.tcp_rmem" = "4096 131072 16777216";
        "net.ipv4.tcp_wmem" = "4096 16384 16777216";
        # https://github.com/klzgrad/naiveproxy/wiki/Performance-Tuning
        "net.ipv4.tcp_slow_start_after_idle" = 0;
      };
    };

    nix = {
      # gc = {
      #   automatic = true;
      #   options = "--delete-older-than 14d";
      #   dates = "weekly";
      # };
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

    zramSwap.enable = true;

    security.sudo.enable = false;
    security.sudo-rs.enable = true;
    security.sudo-rs.execWheelOnly = true;
    security.sudo-rs.wheelNeedsPassword = false;

    services.timesyncd.enable = false;
    services.ntpd-rs.enable = true;
    services.ntpd-rs.useNetworkingTimeServers = true;
    # https://wiki.nixos.org/wiki/NTP
    networking.timeServers = [ "ntp.felixc.at" ] ++ options.networking.timeServers.default;

    users.mutableUsers = false;
  };
}
