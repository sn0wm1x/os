{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ../shared
    ../shared/features/desktop/common
    ../shared/features/desktop/gnome
    ./disko.nix
    ./impermanence.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bluestar";
  networking.networkmanager.enable = true;

  users.mutableUsers = false;
  users.users = {
    root.initialPassword = "correcthorsebatterystaple";
    kwa = {
      initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIApPwSaizmGRsjTbeFUuzAw/U1zHbVM4ybsN3iILi0mm openpgp:0x22222222" # 0x4444777733334444
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel"];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
