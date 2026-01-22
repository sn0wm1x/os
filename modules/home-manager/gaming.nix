{
  config,
  lib,
  ...
}:
let
  cfg = config.sn0wm1x.gaming;
in
with lib;
{
  options.sn0wm1x.gaming = {
    enable = mkEnableOption "SN0WM1X gaming configurations";
  };
  config = lib.mkIf cfg.enable {
    home.persistence."/persist".directories = [ ".local/share/Steam" ];
  };
}
