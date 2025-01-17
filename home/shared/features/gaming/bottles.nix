{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ bottles ];

  home.persistence."/persist${config.home.homeDirectory}".directories = [ ".local/share/bottles" ];
}
