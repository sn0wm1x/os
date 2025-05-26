{ lib, ... }:
{
  imports = [
    ./btrfs.nix
    ./fonts.nix
    ./locale.nix
    ./modules.nix
    ./network.nix
    ./nix.nix
    ./yubikey.nix
  ];

  hardware.enableRedistributableFirmware = true;

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

  # clean default shellAliases
  environment.shellAliases = {
    l = "ls";
    ll = "ls";
    ls = "ls";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = lib.mkDefault "23.11";
}
