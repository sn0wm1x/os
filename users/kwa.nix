# https://github.com/Misterio77/nix-starter-configs/blob/main/minimal/home-manager/home.nix
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [inputs.impermanence.nixosModules.home-manager.impermanence];
  nixpkgs = {};

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.username = "kwa";
  home.homeDirectory = "/home/kwa";
  home.persistence."/persist/home/kwa" = {
    # https://github.com/nix-community/impermanence#home-manager
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".gnupg"
      ".ssh"
      ".nixops"
      ".local/share/keyrings"
      ".local/share/direnv"
    ];
    allowOther = true;
  }
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
