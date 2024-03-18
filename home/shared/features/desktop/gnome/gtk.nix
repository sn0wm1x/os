{pkgs, ...}: let
  theme = {
    name = "adw-gtk3";
    package = pkgs.adw-gtk3;
  };
  cursorTheme = {
    name = "Catppuccin-Frappe-Blue-Cursors";
    package = pkgs.catppuccin-cursors.frappeBlue;
  };
  iconTheme = {
    name = "Papirus";
    package = pkgs.catppuccin-papirus-folders.override {
      accent = "blue";
      flavor = "frappe";
    };
  };
  extraConfig = {
    gtk-application-prefer-dark-theme = 1;
    gtk-error-bell = 0;
  };
in {
  gtk = {
    inherit theme cursorTheme iconTheme;
    enable = true;
    gtk3 = {inherit extraConfig;};
    gtk4 = {inherit extraConfig;};
  };
  home.pointerCursor =
    cursorTheme
    // {
      size = 32;
      gtk.enable = true;
    };
}
