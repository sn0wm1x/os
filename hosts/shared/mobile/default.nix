{ lib, ... }:
{
  imports = [
    ../fonts.nix
    ../locale.nix
    ../network.nix
    ../yubikey.nix
    ./modules.nix
    ./nix.nix
  ];

  hardware.enableRedistributableFirmware = true;

  zramSwap.enable = true;

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

  # clean default shellAliases
  environment.shellAliases =
    {
      l = "ls";
      ll = "ls";
      ls = "ls";
    };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = lib.mkDefault "23.11";
}
