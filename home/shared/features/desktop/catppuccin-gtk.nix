{ config, pkgs, ... }: {
  gtk.enable = true;
  gtk.gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  gtk.gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  
  # https://github.com/catppuccin/gtk#for-nix-users
  gtk.theme = {
    name = "Catppuccin-Frappe-Standard-Blue-Dark";
    package = pkgs.catppuccin-gtk.override {
      accents = [ "blue" ];
      size = "standard";
      # tweaks = [ "rimless" "black" ];
      variant = "frappe";
    };
  };

  # https://github.com/catppuccin/gtk#for-nix-users
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  # https://github.com/catppuccin/cursors#for-nix-users
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.frappeBlue;
    name = "Catppuccin-Frappe-Blue-Cursors";
    size = 32;
  };
}
