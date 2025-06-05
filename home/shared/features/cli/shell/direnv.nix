{ config, lib, ... }:
{
  # https://github.com/nix-community/nix-direnv#via-home-manager
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.enableNushellIntegration = true;

  home.persistence = lib.mkIf config.sn0wm1x.impermanence.enable {
    "/persist${config.home.homeDirectory}".directories = [ ".local/share/direnv" ];
  };
}
