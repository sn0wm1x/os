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

  zramSwap.enable = true;

  services.system76-scheduler.enable = true;
  services.system76-scheduler.useStockConfig = true;

  # use sudo-rs
  security.sudo.enable = false;
  security.sudo-rs.enable = true;
  # sudo wheel only
  security.sudo-rs.execWheelOnly = true;
  # sudo nopasswd
  security.sudo-rs.wheelNeedsPassword = false;
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
