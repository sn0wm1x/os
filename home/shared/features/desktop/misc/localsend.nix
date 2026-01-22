{ pkgs, ... }:
{
  home.packages = with pkgs; [ localsend ];
  home.persistence."/persist".directories = [
    ".local/share/org.localsend.localsend_app"
  ];
}
