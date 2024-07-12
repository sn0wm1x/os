{ config, ... }:
{
  programs.atuin.enable = true;
  programs.atuin.enableNushellIntegration = true;

  home.persistence."/persist${config.home.homeDirectory}".directories = [ ".local/share/atuin" ];
}
