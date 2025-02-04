{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ hoppscotch ];
  home.persistence."/persist${config.home.homeDirectory}".directories = [
    ".config/io.hoppscotch.desktop"
  ];
}
