{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ localsend ];
  home.persistence."/persist${config.home.homeDirectory}".directories = [
    ".local/share/org.localsend.localsend_app"
  ];
}
