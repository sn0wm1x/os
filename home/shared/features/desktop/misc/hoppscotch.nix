{ pkgs, ... }:
{
  home.packages = with pkgs; [ hoppscotch ];
  home.persistence."/persist".directories = [
    ".config/io.hoppscotch.desktop"
  ];
}
