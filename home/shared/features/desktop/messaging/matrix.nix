{ pkgs, ... }:
{
  home.packages = with pkgs; [ fractal ];
  home.persistence."/persist".directories = [ ".local/share/fractal" ];
}
