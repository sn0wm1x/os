{ config, lib, ... }:
{
  programs.zoxide.enable = true;
  programs.zoxide.enableNushellIntegration = true;

  home.persistence = lib.mkIf config.sn0wm1x.impermanence.enable {
    "/persist${config.home.homeDirectory}".directories = [ ".local/share/zoxide" ];
  };
}
