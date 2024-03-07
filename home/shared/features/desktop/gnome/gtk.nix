{ pkgs, ... }: {
  gtk =
    let extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-error-bell = 0;
    };
    in {
      enable = true;

      theme.name = "adw-gtk3";
      theme.package = pkgs.adw-gtk3;

      gtk3 = { inherit extraConfig; };
      gtk4 = { inherit extraConfig; };
    };
}