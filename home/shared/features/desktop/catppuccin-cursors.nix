{ pkgs, ... }: {
  # https://github.com/catppuccin/cursors#for-nix-users
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.frappeBlue;
    name = "Catppuccin-Frappe-Blue-Cursors";
    size = 32;
    gtk.enable = true;
  };
}
