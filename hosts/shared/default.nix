{ lib, pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./gpg.nix
    ./locale.nix
    ./nix.nix
    ./ssh.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = lib.mkDefault "23.11";
}
