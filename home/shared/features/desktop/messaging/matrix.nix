{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ fractal ];
  home.persistence."/persist${config.home.homeDirectory}".directories = [ ".local/share/fractal" ];
}
