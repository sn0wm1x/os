{
  config,
  lib,
  ...
}:
let
  cfg = config.sn0wm1x.powersave;
in
{

  options.sn0wm1x.powersave = {
    enable = lib.mkEnableOption "SN0WM1X powersave configurations";
  };

  config = lib.mkIf cfg.enable {
    # https://wiki.cachyos.org/configuration/general_system_tweaks/#enable-rcu-lazy
    boot.kernelParams = ["rcutree.enable_rcu_lazy=1"];

    services.auto-epp.settings.Settings = lib.mkIf config.services.auto-epp.enable {
      epp_state_for_AC = "balance_performance";
      epp_state_for_BAT = "power";
    };

    # https://wiki.nixos.org/wiki/Laptop#Powertop
    powerManagement.powertop.enable = lib.mkIf config.powerManagement.enable true;

    services.tuned.settings.dynamic_tuning = lib.mkIf config.services.tuned.enable true;

    # https://wiki.nixos.org/wiki/NetworkManager#Power_Saving
    networking.networkmanager.wifi.powersave = lib.mkIf config.networking.networkmanager.enable true;

    # https://wiki.archlinux.org/title/Laptop#udev
    services.udev.extraRules = ''
      SUBSYSTEM=="power_supply", \
      ATTR{status}=="Discharging", \
      ATTR{capacity}=="[0-5]", \
      RUN+="systemctl hibernate"
    '';

    # TODO: https://wiki.archlinux.org/title/Power_management#Power_saving
    # TODO: https://wiki.archlinux.org/title/Laptop#Power_management
    # TODO: https://wiki.archlinux.org/title/Power_management/Wakeup_triggers
  };
}
