{
  config,
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
    systemd.user.startServices = "sd-switch";

    home.username = "kwa";
    home.homeDirectory = "/home/kwa";
    home.stateVersion = "23.11";
  };
}
