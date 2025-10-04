{ pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    ideapad # Lenovo IdeaPad goodies for Gnome Shell
  ];
  dconf.settings."org/gnome/shell".enabled-extensions = with pkgs.gnomeExtensions; [
    ideapad.extensionUuid
  ];
}
