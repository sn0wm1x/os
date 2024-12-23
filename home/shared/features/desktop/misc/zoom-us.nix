{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ zoom-us ];
  home.persistence."/persist${config.home.homeDirectory}" = {
    directories = [ ".zoom" ];
    files = [
      ".config/zoom.conf"
      ".config/zoomus.conf"
    ];
  };
}
