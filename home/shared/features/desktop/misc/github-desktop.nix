{ pkgs, ... }:
{
  home.packages = with pkgs; [ github-desktop ];
  home.persistence."/persist".directories = [ ".config/GitHub Desktop" ];
}
