{ config, lib, ... }:
{
  programs.atuin.enable = true;
  programs.atuin.enableNushellIntegration = true;

  home.persistence = lib.mkIf config.sn0wm1x.impermanence.enable {
    "/persist${config.home.homeDirectory}".directories = [ ".local/share/atuin" ];
  };
}
