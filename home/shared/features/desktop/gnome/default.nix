{ lib, config, osConfig, ... }:
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
  home.persistence."/persist${config.home.homeDirectory}".directories = lib.mkIf osConfig.services.gnome.gnome-keyring.enable [
    ".local/share/keyrings"
  ];
}
