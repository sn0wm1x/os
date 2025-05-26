{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ cherry-studio ];
  home.persistence."/persist${config.home.homeDirectory}".directories = [
    ".config/CherryStudio"
  ];
}
