{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ hopposcotch ];
  home.persistence."/persist${config.home.homeDirectory}".directories = [
    ".config/io.hoppscotch.desktop"
  ];
}
