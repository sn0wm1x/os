{ lib, ... }: {
  imports = [
    ./btrfs.nix
    ./fonts.nix
    ./gpg.nix
    ./locale.nix
    ./nix.nix
    ./ssh.nix
  ];

  zramSwap.enable = true;

  services.system76-scheduler.enable = true;
  services.system76-scheduler.useStockConfig = true;

  # sudo nopasswd
  security.sudo.wheelNeedsPassword = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = lib.mkDefault "23.11";
}
