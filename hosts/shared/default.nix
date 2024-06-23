{ lib, ... }: {
  imports = [
    ./btrfs.nix
    ./fonts.nix
    ./gpg.nix
    ./home-manager.nix
    ./locale.nix
    ./nix.nix
    ./ssh.nix
  ];

  zramSwap.enable = true;

  services.system76-scheduler.enable = true;
  services.system76-scheduler.useStockConfig = true;

  # sudo nopasswd
  security.sudo.wheelNeedsPassword = false;
  # increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = lib.mkDefault "23.11";
}
