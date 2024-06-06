{ pkgs, ... }:
let
  theme = {
    # name = "adw-gtk3";
    name = "adw-gtk3-dark";
    package = pkgs.adw-gtk3;
  };
  cursorTheme = {
    name = "Catppuccin-frappe-blue-cursors";
    package = pkgs.catppuccin-cursors.frappeBlue;
    size = 32;
  };
  iconTheme = {
    # name = "Papirus";
    name = "Papirus-Dark";
    package = pkgs.catppuccin-papirus-folders.override {
      accent = "blue";
      flavor = "frappe";
    };
  };
  extraConfig = {
    gtk-application-prefer-dark-theme = 1;
    gtk-error-bell = 0;
  };
in
{
  gtk = {
    inherit theme cursorTheme iconTheme;
    enable = true;
    gtk3 = { inherit extraConfig; };
    gtk4 = { inherit extraConfig; };
  };
  home.pointerCursor =
    cursorTheme
    // {
      gtk.enable = true;
    };
}
