{
  imports = [
    ../shared
    ../shared/features/desktop/common
    ../shared/features/desktop/gnome
    ../shared/users/kwa
    ./disko.nix
    ./impermanence.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bluestar";
  networking.networkmanager.enable = true;

  users.mutableUsers = false;
  # FIXME: update password
  users.users.root.initialPassword = "correcthorsebatterystaple";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
