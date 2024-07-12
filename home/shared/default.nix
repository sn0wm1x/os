{ lib, ... }:
{
  imports = [
    ./catppuccin.nix
    ./xdg.nix
  ];

  systemd.user.startServices = "sd-switch";

  home.stateVersion = lib.mkDefault "23.11";
}
