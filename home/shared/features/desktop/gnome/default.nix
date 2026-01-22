{ lib, osConfig, ... }:
{
  imports = [
    ./circle.nix
    ./dconf.nix
    ./extensions.nix
    ./gtk.nix
    ./ptyxis.nix
    ./wallpaper.nix
  ];

  # gnome-keyring
  home.persistence."/persist".directories = lib.mkIf osConfig.services.gnome.gnome-keyring.enable [
    ".local/share/keyrings"
  ];
}
