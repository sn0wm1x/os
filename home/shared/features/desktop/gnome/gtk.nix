{ config, pkgs, lib, ... }:
let
  theme = {
    # name = "adw-gtk3";
    name = "adw-gtk3-dark";
    package = pkgs.adw-gtk3;
  };
  cursorTheme = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
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
  extraCss = builtins.readFile ../../../../../assets/catppuccin-frappe-blue.css;
in
{
  gtk = {
    inherit theme cursorTheme iconTheme;
    enable = true;
    gtk3 = {
      inherit extraConfig extraCss;
    };
    gtk4 = {
      inherit extraConfig extraCss;
    };
  };

  home.pointerCursor = cursorTheme // {
    gtk.enable = true;
  };

  # https://github.com/nix-community/home-manager/issues/7113
  xdg.configFile."gtk-4.0/gtk.css" = lib.mkForce { text = config.gtk.gtk4.extraCss; };
}
